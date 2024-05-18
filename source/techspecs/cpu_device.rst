Dispositivos CPU
================

.. contents:: :local:


1. Visão geral
--------------

Derivados de dispositivos de CPU são, sem surpresa, usados para
implementar a emulação de CPUs, MCUs e SOCs. Um dispositivo de CPU é
inicialmente uma combinação de ``device_execute_interface``,
``device_memory_interface``, ``device_state_interface`` e
``device_disasm_interface``. Consulte a documentação apropriada, se
estiver disponível.

Dois outros recursos são específicos dos dispositivos da CPU, o DRC e o
suporte a interrupções.


2. DRC
------

A FAZER.


3. Interruptibilidade
---------------------

3.1 Definição
~~~~~~~~~~~~~

Uma CPU com a capacidade de interromper é definida como um núcleo capaz
de interromper a execução de uma instrução a qualquer momento, sair do
``execute_run`` e continuar de onde parou no próximo ``execute_run``.
Isso inclui a capacidade de abortar um acesso à memória emitido, sair do
``execute_run`` e, em seguida, reemitir exatamente o mesmo acesso na
próxima vez que o ``execute_run`` for invocado.


3.2 Requisitos para a implementação
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Os acessos à memória devem ser feitos com ``read_interruptible`` ou
``write_interruptible`` num ``memory_access_specific`` ou num
``memory_access_cache``. O acesso deve ser feito conforme a largura e o
alinhamento do barramento.

Após cada acesso, o núcleo deve testar se ``icount <= 0``. Esse teste
deve ser feito após diminuir o ``icount`` pelo tempo gasto pelo próprio
acesso para limitar a quantidade de testes. Se o ``icount`` chegar a
``0`` ou menos, isso significa que a emulação da instrução deve ser
suspensa.

Para saber se o acesso precisa ser reemitido, o
``access_to_be_redone()`` deve ser invocado. Se o retorno for
verdadeiro, o tempo gasto pelo acesso deverá ser creditado de volta,
pois ele ainda não aconteceu, e o acesso deverá ser reemitido. A chamada
``access_to_be_redone()`` limpa o sinalizador de reemissão. Caso precise
verificar o sinalizador sem limpá-lo, use
``access_to_be_redone_noclear()``.

O núcleo deve fazer uma contabilidade suficiente para, eventualmente,
reiniciar a execução da instrução logo antes do acesso ou logo após o
teste, dependendo da necessidade de reemissão.

Por fim, para indicar o suporte ao restante da infraestrutura, ele deve
substituir ``cpu_is_interruptible()`` para retornar ``true``.


3.3 Exemplo de uma implementação com geradores
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para garantir um desempenho decente, as implementações atuais (h8, 6502
e 68000) usam um gerador python para gerar duas versões de cada
interpretador de instruções, uma para a emulação normal e outra para
reiniciar a instrução.

A versão reiniciada tem a seguinte aparência (para uma CPU com 4 ciclos
por acesso):


To ensure decent performance, the current implementations (h8, 6502
and 68000) use a python generator to generate two versions of each
instruction interpreter, one for the normal emulation, and one for
restarting the instruction.

The restarted version looks like that (for a 4-cycles per access cpu):

.. code-block:: C++

    void device::execute_inst_restarted()
    {
        switch(m_inst_substate) {
        case 0:
            [...]

            m_address = [...];
            m_mask = [...];
            [[fallthrough]];
        case 42:
            m_result = specific.read_interruptible(m_address, m_mask);
            m_icount -= 4;
            if(m_icount <= 0) {
                if(access_to_be_redone()) {
                    m_icount += 4;
                    m_inst_substate = 42;
                } else
                    m_inst_substate = 43;
                return;
            }
            [[fallthrough]];
        case 43:
            [...] = m_result;
            [...]
        }
        m_inst_substate = 0;
        return;
    }

A versão não reiniciada é a mesma, com a chave e a limpeza final
removidas de ``m_inst_substate``.

.. code-block:: C++

    void device::execute_inst_non_restarted()
    {
        [...]
        m_address = [...];
        m_mask = [...];
        m_result = specific.read_interruptible(m_address, m_mask);
        m_icount -= 4;
        if(m_icount <= 0) {
            if(access_to_be_redone()) {
                m_icount += 4;
                m_inst_substate = 42;
            } else
                m_inst_substate = 43;
            return;
        }
        [...] = m_result;
        [...]
        return;
    }

O loop principal será semelhante a este:

.. code-block:: C++

    void device::execute_run()
    {
        if(m_inst_substate)
            call appropriate restarted instrution handler
        while(m_icount > 0) {
            debugger_instruction_hook(m_pc);
            call appropriate non-restarted instruction handler
        }
    }

Portanto, a ideia é que ``m_inst_substate`` indique onde você está numa
instrução, mas apenas quando ocorre uma interrupção. Caso contrário,
ele permanece em ``0`` e, essencialmente, nunca é examinado. Ao ter duas
versões da interpretação permite remover a sobrecarga da troca e a
limpeza dos estados secundários no final da instrução.

Não é obrigatório usar um método baseado em gerador, mas ainda não foi
encontrado nenhum outro que não tenha implicações inaceitáveis para o
desempenho.


3.4 Interagindo com o DRC
~~~~~~~~~~~~~~~~~~~~~~~~~

Nesse ponto, a interruptibilidade e o DRC são totalmente incompatíveis.
Não temos nenhum método para interromper o código gerado antes ou após
um acesso. Isso é teoricamente possível, mas definitivamente não é
trivial.
