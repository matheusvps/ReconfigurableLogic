# CronometerController

## Descrição

O `CronometerController` é uma máquina de estados que controla o funcionamento de um cronômetro digital. Ele gerencia três estados principais: Reset, Ativo e Pausado, respondendo a comandos de botões para transição entre os estados.

## Interface

### Entradas
- `btn_clear` (std_logic): Botão de limpar/zerar
- `btn_pause` (std_logic): Botão de pausar/retomar
- `btn_reset` (std_logic): Botão de reset (prioridade máxima)

### Saídas
- `current_state` (std_logic_vector(1 downto 0)): Estado atual da máquina

## Estados da Máquina

| Código | Estado | Descrição |
|--------|--------|-----------|
| 00     | Reset  | Estado inicial, cronômetro zerado |
| 01     | Active | Cronômetro contando normalmente |
| 10     | Paused | Cronômetro pausado |

## Lógica de Transição de Estados

### Prioridade das Transições

1. **Reset (btn_reset = '1')**: Sempre volta para estado 00
2. **Clear (btn_clear = '0')**: Só funciona quando pausado (estado 10)
3. **Pause (btn_pause = '0')**: Alterna entre ativo e pausado

### Tabela de Transições

| Estado Atual | Condição | Próximo Estado | Ação |
|--------------|----------|----------------|------|
| 00 (Reset)   | btn_reset = '1' | 00 (Reset) | Reset |
| 00 (Reset)   | btn_pause = '0' | 01 (Active) | Inicia contagem |
| 01 (Active)  | btn_reset = '1' | 00 (Reset) | Reset |
| 01 (Active)  | btn_pause = '0' | 10 (Paused) | Pausa contagem |
| 10 (Paused)  | btn_reset = '1' | 00 (Reset) | Reset |
| 10 (Paused)  | btn_clear = '0' | 00 (Reset) | Zera cronômetro |
| 10 (Paused)  | btn_pause = '0' | 01 (Active) | Retoma contagem |

## Implementação

### Processo de Transição
```vhdl
process(btn_reset, btn_clear, btn_pause)
begin
    if btn_reset = '1' then
        internal_state <= "00";
    elsif btn_clear = '0' and internal_state = "10" then
        internal_state <= "00";
    elsif btn_pause = '0' and internal_state = "01" then
        internal_state <= "10";
    elsif btn_pause = '0' and (internal_state = "10" or internal_state = "00") then
        internal_state <= "01";
    end if;
end process;
```

### Lógica Detalhada

1. **Reset Global**: `btn_reset = '1'` sempre força estado 00
2. **Clear Pausado**: `btn_clear = '0'` só funciona no estado 10 (pausado)
3. **Pausar Ativo**: `btn_pause = '0'` no estado 01 (ativo) vai para 10 (pausado)
4. **Retomar/Iniciar**: `btn_pause = '0'` nos estados 00 ou 10 vai para 01 (ativo)

## Comportamento dos Botões

### btn_reset
- **Função**: Reset global
- **Prioridade**: Máxima
- **Efeito**: Sempre volta para estado 00
- **Uso**: Emergência ou reinicialização completa

### btn_clear
- **Função**: Zerar cronômetro
- **Condição**: Só funciona quando pausado (estado 10)
- **Efeito**: Volta para estado 00 (reset)
- **Uso**: Limpar tempo acumulado

### btn_pause
- **Função**: Pausar/Retomar/Iniciar
- **Comportamento**:
  - Estado 00 → 01: Inicia contagem
  - Estado 01 → 10: Pausa contagem
  - Estado 10 → 01: Retoma contagem
- **Uso**: Controle principal do cronômetro

## Diagrama de Estados

```
    [btn_reset=1]     [btn_pause=0]
         ↓                ↓
    ┌─────────┐      ┌─────────┐
    │   00    │──────│   01    │
    │ (Reset) │      │(Active) │
    └─────────┘      └─────────┘
         ↑                ↓
    [btn_clear=0]    [btn_pause=0]
    (only in 10)         ↓
         ↑          ┌─────────┐
         └──────────│   10    │
                    │(Paused) │
                    └─────────┘
```

## Aplicações

Este controlador é ideal para:
- **Cronômetros Digitais**: Controle de tempo
- **Sistemas de Medição**: Temporização precisa
- **Interfaces de Usuário**: Controle intuitivo
- **Sistemas de Teste**: Medição de intervalos
- **Aplicações Industriais**: Controle de processos

## Exemplos de Uso

### Sequência Típica
1. **Inicialização**: Estado 00 (Reset)
2. **Iniciar**: Pressionar `btn_pause` → Estado 01 (Active)
3. **Pausar**: Pressionar `btn_pause` → Estado 10 (Paused)
4. **Retomar**: Pressionar `btn_pause` → Estado 01 (Active)
5. **Zerar**: Pressionar `btn_clear` (só funciona pausado) → Estado 00 (Reset)

### Reset de Emergência
- **Qualquer estado**: Pressionar `btn_reset` → Estado 00 (Reset)

## Características

- **Assíncrono**: Resposta imediata aos botões
- **Priorizado**: Reset tem prioridade sobre outras ações
- **Seguro**: Clear só funciona quando pausado
- **Intuitivo**: Comportamento esperado de cronômetro
- **Robusto**: Prevenção de estados inválidos

## Testbench

O testbench (`CronometerController_tb.vhd`) testa:
- Transições entre todos os estados
- Funcionamento do reset global
- Comportamento do clear quando pausado
- Sequências de pause/resume
- Prioridade do reset sobre outras ações

## Integração com Cronômetro

Este controlador deve ser usado em conjunto com:
- **Contadores de Tempo**: Para contagem de segundos/minutos
- **Display**: Para mostrar o tempo atual
- **Clock**: Para sincronização temporal
- **Lógica de Enable**: Para controlar quando contar

## Arquivos do Projeto

- `CronometerController.vhd`: Implementação principal
- `CronometerController_tb.vhd`: Testbench para simulação
- `CronometerController.qpf`: Arquivo de projeto Quartus
- `CronometerController.qsf`: Arquivo de configuração Quartus
- `output_files/`: Resultados da síntese
- `simulation/`: Arquivos de simulação ModelSim
- `simulate.do`: Script de simulação ModelSim
