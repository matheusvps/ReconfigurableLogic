# Counter59

## Descrição

O `Counter59` é um contador de 8 bits que implementa a lógica de contagem de 0 a 59, ideal para aplicações de cronômetros, relógios digitais e sistemas de tempo. O contador é construído usando dois módulos `Counter4WithLoad` para representar unidades e dezenas.

## Interface

### Entradas
- `RST` (std_logic): Reset assíncrono
- `CLK` (std_logic): Clock do sistema
- `EN` (std_logic): Enable para contagem
- `CLR` (std_logic): Clear síncrono
- `LD` (std_logic): Load paralelo
- `LOAD` (std_logic_vector(7 downto 0)): Valor a ser carregado

### Saídas
- `Q` (std_logic_vector(7 downto 0)): Valor atual do contador

## Arquitetura

O contador utiliza dois módulos `Counter4WithLoad`:

### Contador de Unidades (0-9)
- **Bits**: 3:0 da saída
- **Faixa**: 0 a 9
- **Reset**: Quando atinge 10, volta para 0

### Contador de Dezenas (0-5)
- **Bits**: 7:4 da saída
- **Faixa**: 0 a 5
- **Enable**: Ativado quando unidades = 9

## Lógica de Funcionamento

### 1. Contagem das Unidades
```vhdl
-- Contador de unidades (0-9)
units_counter : Counter4WithLoad
    port map(
        RST  => RST,
        CLK  => CLK,
        EN   => EN,        -- Enable externo
        CLR  => clr_int,   -- Clear interno
        LD   => LD,
        LOAD => load_buf(3 downto 0),
        Q    => units_cnt
    );
```

### 2. Contagem das Dezenas
```vhdl
-- Contador de dezenas (0-5)
tens_counter : Counter4WithLoad
    port map(
        RST  => RST,
        CLK  => CLK,
        EN   => en_tens,   -- Enable do vai-um
        CLR  => clr_int,   -- Clear interno
        LD   => LD,
        LOAD => load_buf(7 downto 4),
        Q    => tens_cnt
    );
```

### 3. Lógica do Vai-um (Carry)
```vhdl
-- Enable do contador das dezenas
en_tens <= '1' when (units_cnt = "1111" and EN = '1') else '0';
```

O contador de dezenas incrementa quando:
- O contador de unidades atinge 9 (0x9)
- E o enable externo está ativo

### 4. Reset Automático
```vhdl
-- Clear interno (zera quando >= 59 ou CLR externo ativo)
clr_int <= '1' when (unsigned(full_count) > 59) or (CLR = '1') else '0';
```

O contador é zerado quando:
- Atinge 60 (0x3C) ou mais
- Clear externo é ativado

### 5. Concatenação da Saída
```vhdl
-- Concatenação para gerar saída final
full_count <= tens_cnt & units_cnt;
Q <= full_count;
```

## Comportamento Detalhado

### Sequência de Contagem
```
00 → 01 → 02 → ... → 08 → 09 → 10 → 11 → ... → 58 → 59 → 00 → 01 → ...
```

### Exemplo de Estados
| Dezenas | Unidades | Valor Decimal | Hexadecimal |
|---------|----------|---------------|-------------|
| 0000    | 0000     | 00            | 0x00        |
| 0000    | 1001     | 09            | 0x09        |
| 0001    | 0000     | 10            | 0x10        |
| 0101    | 1001     | 59            | 0x3B        |
| 0000    | 0000     | 00            | 0x00        |

## Características

- **Faixa de Contagem**: 0 a 59
- **Representação**: BCD (Binary Coded Decimal) para dezenas
- **Reset Automático**: Volta para 00 quando atinge 60
- **Modular**: Usa dois contadores de 4 bits
- **Síncrono**: Operação baseada em clock

## Aplicações

Este contador é ideal para:
- **Cronômetros**: Contagem de segundos
- **Relógios Digitais**: Minutos e segundos
- **Sistemas de Tempo**: Medição de intervalos
- **Controle de Processos**: Temporização com base 60
- **Interfaces de Usuário**: Display de tempo

## Exemplos de Uso

### Contagem Normal
```vhdl
RST <= '0';
CLK <= clock_signal;
EN  <= '1';
CLR <= '0';
LD  <= '0';
-- Contador: 00, 01, 02, ..., 59, 00, 01, ...
```

### Carregamento de Valor
```vhdl
LD   <= '1';
LOAD <= "00101001";  -- Carrega 29 (0x1D)
-- Contador assume valor 29 e continua: 29, 30, 31, ..., 59, 00, ...
```

### Reset/Clear
```vhdl
-- Reset assíncrono (imediato)
RST <= '1';

-- Clear síncrono (próxima borda de clock)
CLR <= '1';
```

## Testbench

O testbench (`Counter59_tb.vhd`) testa:
- Contagem completa de 0 a 59
- Reset automático em 60
- Funcionamento do clear
- Carregamento de valores específicos
- Comportamento do enable/disable

## Vantagens

- **Eficiência**: Usa componentes modulares reutilizáveis
- **Clareza**: Lógica clara de vai-um entre contadores
- **Flexibilidade**: Permite carregamento de valores iniciais
- **Confiabilidade**: Reset automático previne estados inválidos

## Arquivos do Projeto

- `Counter59.vhd`: Implementação principal
- `Counter59_tb.vhd`: Testbench para simulação
- `Counter59.qpf`: Arquivo de projeto Quartus
- `Counter59.qsf`: Arquivo de configuração Quartus
- `output_files/`: Resultados da síntese
- `simulation/`: Arquivos de simulação ModelSim
- `simulate.do`: Script de simulação ModelSim