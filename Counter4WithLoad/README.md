# Counter4WithLoad

## Descrição

O `Counter4WithLoad` é um contador de 4 bits com funcionalidade de carregamento paralelo. Este é o módulo base usado por outros contadores mais complexos no projeto.

## Interface

### Entradas
- `RST` (std_logic): Reset assíncrono - zera o contador quando ativo ('1')
- `CLK` (std_logic): Clock do sistema - contagem ocorre na borda de subida
- `EN` (std_logic): Enable - habilita a contagem quando ativo ('1')
- `CLR` (std_logic): Clear síncrono - zera o contador na próxima borda de clock
- `LD` (std_logic): Load - carrega valor paralelo quando ativo ('1')
- `LOAD` (std_logic_vector(3 downto 0)): Valor a ser carregado no contador

### Saídas
- `Q` (std_logic_vector(3 downto 0)): Valor atual do contador

## Lógica de Funcionamento

O contador opera com a seguinte prioridade de operações:

1. **Reset Assíncrono** (`RST = '1'`): Zera imediatamente o contador
2. **Clear Síncrono** (`CLR = '1'`): Zera o contador na próxima borda de clock
3. **Load** (`LD = '1'` e `EN = '1'`): Carrega o valor de `LOAD` no contador
4. **Incremento** (`EN = '1'` e `LD = '0'`): Incrementa o contador em 1

### Comportamento Detalhado

```vhdl
-- Reset assíncrono tem prioridade máxima
if RST = '1' then
    CONT <= "0000";
elsif CLK'event and CLK = '1' then
    if CLR = '1' then
        CONT <= "0000";  -- Clear síncrono
    elsif EN = '1' then
        if LD = '1' then
            CONT <= LOAD;  -- Carregamento paralelo
        else
            CONT <= CONT + 1;  -- Incremento
        end if;
    end if;
end if;
```

## Características

- **Faixa de Contagem**: 0 a 15 (4 bits)
- **Overflow**: Após 15, volta para 0
- **Reset Assíncrono**: Zera imediatamente independente do clock
- **Clear Síncrono**: Zera na próxima borda de subida do clock
- **Carregamento Paralelo**: Permite definir qualquer valor de 0 a 15

## Exemplos de Uso

### Contagem Normal
```vhdl
RST <= '0';
CLK <= clock_signal;
EN  <= '1';
CLR <= '0';
LD  <= '0';
-- Contador incrementa: 0, 1, 2, 3, ..., 15, 0, 1, ...
```

### Carregamento de Valor
```vhdl
RST <= '0';
CLK <= clock_signal;
EN  <= '1';
CLR <= '0';
LD  <= '1';
LOAD <= "1010";  -- Carrega valor 10
-- Contador assume valor 10 e continua incrementando
```

### Reset/Clear
```vhdl
-- Reset assíncrono (imediato)
RST <= '1';

-- Clear síncrono (próxima borda de clock)
CLR <= '1';
```

## Testbench

O testbench (`Counter4WithLoad_TB.vhd`) testa:
- Contagem normal com enable
- Carregamento de valor específico
- Funcionamento do clear síncrono
- Comportamento do reset assíncrono

## Aplicações

Este contador é usado como componente base em:
- **Counter57**: Contador de 8 bits com faixa específica
- **Counter59**: Contador de 0-59 para cronômetros
- Outros contadores modulares

## Arquivos do Projeto

- `Counter4WithLoad.vhd`: Implementação principal
- `Counter4WithLoad_TB.vhd`: Testbench para simulação
- `Counter4WithLoad.qpf`: Arquivo de projeto Quartus
- `Counter4WithLoad.qsf`: Arquivo de configuração Quartus
- `output_files/`: Resultados da síntese e place & route
