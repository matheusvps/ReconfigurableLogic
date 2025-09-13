# Counter57

## Descrição

O `Counter57` é um contador de 8 bits que implementa uma lógica especial de contagem com faixa específica. O contador opera na faixa de 12 a 68, e quando está fora desta faixa, automaticamente carrega o valor 12 (0x0C).

## Interface

### Entradas
- `rst_i` (std_logic): Reset assíncrono
- `clk_i` (std_logic): Clock do sistema
- `en_i` (std_logic): Enable para contagem
- `clr_i` (std_logic): Clear síncrono
- `ld_i` (std_logic): Load externo
- `load_i` (std_logic_vector(7 downto 0)): Valor a ser carregado

### Saídas
- `q_o` (std_logic_vector(7 downto 0)): Valor atual do contador

## Arquitetura

O contador é implementado usando dois módulos `Counter4WithLoad`:
- **C1**: Contador das unidades (bits 3:0)
- **C2**: Contador das dezenas (bits 7:4)

### Sinais Internos

- `cont1_s`: Saída do contador de unidades
- `cont2_s`: Saída do contador de dezenas
- `cont_s`: Concatenação dos dois contadores (cont2_s & cont1_s)
- `en_c2_s`: Enable do contador de dezenas (vai-um)
- `ld_s`: Sinal de load interno
- `load_s`: Buffer do valor de load
- `ld_cte_c`: Constante de load (0x0C = 12)

## Lógica de Funcionamento

### 1. Contagem Normal
- O contador de unidades incrementa a cada clock quando `en_i = '1'`
- Quando o contador de unidades atinge 15 (0xF), o contador de dezenas incrementa
- A saída é a concatenação: `q_o = cont2_s & cont1_s`

### 2. Lógica de Faixa Específica
```vhdl
-- Saída com lógica de faixa
q_o <= cont_s when ((unsigned(cont_s) > 11) and (unsigned(cont_s) < 69))
       else ld_cte_c;
```

**Comportamento:**
- Se `cont_s` está entre 12 e 68: saída normal
- Se `cont_s` está fora desta faixa: força saída para 12 (0x0C)

### 3. Enable do Contador de Dezenas
```vhdl
en_c2_s <= '1' when (cont1_s = "1111" and en_i = '1')
                 or (ld_s = '1')       
           else '0';
```

O contador de dezenas incrementa quando:
- O contador de unidades atinge 15 E enable está ativo
- OU quando há um load ativo

### 4. Lógica de Load
```vhdl
ld_s <= '1' when (unsigned(cont_s) < 12)
             or (unsigned(cont_s) >= 68)
             or clr_i = '1'
             or rst_i = '1' 
        else ld_i;
```

Load é ativado quando:
- Contador está abaixo de 12
- Contador está acima ou igual a 68
- Clear externo ativo
- Reset ativo

### 5. Seleção do Valor de Load
```vhdl
load_s <= ld_cte_c when ld_i = '0'        
          else load_i;
```

- Se `ld_i = '0'`: carrega constante 12 (0x0C)
- Se `ld_i = '1'`: carrega valor externo `load_i`

## Comportamento Detalhado

### Ciclo de Contagem
1. **Inicialização**: Contador carrega 12 (0x0C)
2. **Contagem**: Incrementa de 12 até 68
3. **Reset Automático**: Quando atinge 68, volta para 12
4. **Fora de Faixa**: Se por algum motivo sair da faixa, força volta para 12

### Exemplo de Sequência
```
12 → 13 → 14 → ... → 67 → 68 → 12 → 13 → ...
```

## Aplicações

Este contador é ideal para:
- **Sistemas de medição** com faixa específica
- **Controle de processos** com limites definidos
- **Interfaces de usuário** com valores pré-definidos
- **Sistemas de segurança** com faixas operacionais

## Testbench

O testbench (`Counter57_TB.vhd`) testa:
- Contagem normal na faixa 12-68
- Funcionamento do clear
- Carregamento de valores externos
- Comportamento do enable/disable
- Reset automático quando sai da faixa

## Características Especiais

- **Faixa Controlada**: Operação restrita entre 12 e 68
- **Reset Automático**: Volta para 12 quando sai da faixa
- **Modular**: Usa dois contadores de 4 bits
- **Flexível**: Permite load externo quando necessário

## Arquivos do Projeto

- `Counter57.vhd`: Implementação principal
- `Counter57_TB.vhd`: Testbench para simulação
- `Counter57.qpf`: Arquivo de projeto Quartus
- `Counter57.qsf`: Arquivo de configuração Quartus
- `output_files/`: Resultados da síntese
- `simulation/`: Arquivos de simulação ModelSim
