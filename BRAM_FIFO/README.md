# Projeto BRAM-FIFO com Controle de Fluxo

## Descrição
Este projeto implementa um sistema de controle de fluxo entre Block RAMs e FIFO, conforme especificado no exercício de lógica reconfigurável.

## Arquitetura
O sistema é composto por:
- **BRAM1 (2048x8)**: Primeira BRAM para escrita de dados crescentes (0 a 2048)
- **FIFO (1024x8)**: Buffer intermediário para controle de fluxo
- **BRAM2 (2048x8)**: Segunda BRAM para leitura dos dados processados
- **Máquinas de Estado**: Controle de escrita e leitura com velocidades diferentes

## Características
- Velocidade de escrita 7x maior que a leitura (WR_speed / RD_speed = 7)
- Controle de fluxo baseado em percentuais da FIFO (75% e 50%)
- Preenchimento automático da BRAM1 com valores crescentes
- Transferência controlada via FIFO para BRAM2

## Arquivos do Projeto

### Componentes Básicos
- `bram_2048x8.vhd` - Block RAM de 2048 palavras de 8 bits
- `bram_2048x8_read.vhd` - Block RAM para leitura (idêntica à primeira)
- `fifo_1024x8.vhd` - FIFO de 1024 palavras de 8 bits

### Máquinas de Estado
- `write_fsm.vhd` - Controle de escrita (BRAM1 → FIFO)
- `read_fsm.vhd` - Controle de leitura (FIFO → BRAM2)

### Sistema Principal
- `bram_fifo_controller.vhd` - Entidade principal que integra todos os componentes
- `bram_fifo_tb.vhd` - Testbench para simulação

## Estados das Máquinas

### Write FSM
- **RESET (000)**: Estado inicial
- **LOAD_BRAM (001)**: Carregamento inicial da BRAM1
- **WR_FIFO (010)**: Escrita da BRAM1 para FIFO
- **WR_WAIT (011)**: Aguarda espaço na FIFO

### Read FSM
- **RESET (00)**: Estado inicial
- **RD_FIFO (01)**: Leitura da FIFO para BRAM2
- **RD_WAIT (10)**: Aguarda dados na FIFO

## Controle de Fluxo
- **75% da FIFO**: Para escrita quando cheia
- **50% da FIFO**: Retoma escrita quando há espaço
- **Velocidade 7:1**: Escrita 7x mais rápida que leitura

## Simulação
Execute o testbench `bram_fifo_tb.vhd` no ModelSim para verificar o funcionamento do sistema.

## Sinais de Debug
- `write_state`: Estado atual da máquina de escrita
- `read_state`: Estado atual da máquina de leitura
- `fifo_count`: Número de dados na FIFO
- `fifo_full/empty`: Sinais de controle da FIFO
- `bram1_addr/bram2_addr`: Endereços atuais das BRAMs
- `done`: Sinal de conclusão do processamento

## Bibliografia
- VOLNEI PEDRONI
- DOUGLAS PERRY
