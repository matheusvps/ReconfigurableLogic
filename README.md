# ReconfigurableLogic

Este repositório contém projetos de lógica reconfigurável desenvolvidos em VHDL para FPGAs, focados em implementação de contadores e controladores de cronômetro.

## Estrutura do Projeto

### Contadores Básicos
- **Counter4WithLoad**: Contador de 4 bits com funcionalidade de carregamento
- **Counter57**: Contador de 8 bits com faixa específica (12-68)
- **Counter59**: Contador de 8 bits que conta de 0 a 59 (ideal para segundos/minutos)

### Controladores
- **CronometerController**: Máquina de estados para controle de cronômetro

## Tecnologias Utilizadas

- **VHDL**: Linguagem de descrição de hardware
- **Quartus Prime**: Ambiente de desenvolvimento da Intel/Altera
- **ModelSim**: Simulador de hardware
- **FPGA**: Dispositivos de lógica programável

## Estrutura dos Projetos

Cada projeto contém:
- Arquivo principal `.vhd` com a implementação
- Testbench `_TB.vhd` para simulação
- Arquivos de projeto Quartus (`.qpf`, `.qsf`, `.qws`)
- Pasta `output_files` com resultados da síntese
- Pasta `simulation` com arquivos de simulação ModelSim

## Como Usar

1. Abra o projeto desejado no Quartus Prime
2. Compile o projeto (Analysis & Synthesis)
3. Execute a simulação usando ModelSim
4. Faça o download do bitstream para a FPGA

## Documentação Detalhada

Cada módulo possui sua própria documentação explicando:
- Funcionalidade e propósito
- Interface de entrada e saída
- Lógica de funcionamento
- Exemplos de uso
- Testes realizados

Consulte os READMEs individuais em cada pasta para informações específicas de cada módulo.
