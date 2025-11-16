# NiosAndUserHW - Testbench de Simulação

Este projeto implementa um testbench que simula o comportamento do sistema NIOS + User HW conforme especificado.

## Descrição do Projeto

O testbench simula o comportamento descrito nas especificações:

1. **Instanciação de Block RAMs**: Utiliza uma BRAM de 1024x8 bits
2. **Interfaceamento com NIOS**: Implementa interface Avalon com registradores de endereço, dados e controle
3. **Operações de escrita**: Só grava quando CS=1, protege memória quando CS=0
4. **Operações de leitura**: Tri-state quando CS=0, dados válidos quando CS=1 e RD=1
5. **Registradores mapeados**:
   - ADD = "00": Registro de endereços
   - ADD = "01": Registro de dados  
   - ADD = "10": Registro de controle

## Registro de Controle

```
33222222222211111111110000000000
10987654321098765432109876543210
                                 ||
|\-- WE_MEM - Self Clear
|
 \-- RD_MEM - Self Clear
```

## Comportamento do Testbench

O testbench implementa a sequência especificada:

1. **Fase de Escrita (1024 escritas)**:
   - Escreve o nome completo "MATHEUS VINICIUS PASSOS DE SANTANA" em ASCII
   - Adiciona separador " +++--+++ " entre nomes completos
   - Repete a sequência até completar 1024 escritas

2. **Fase de Leitura (1024 leituras)**:
   - Lê todos os dados escritos na memória
   - Verifica se os dados lidos correspondem aos dados escritos
   - Exibe os caracteres lidos no console

3. **Testes de Funcionamento**:
   - Verifica comportamento tri-state quando CS=0
   - Testa proteção de escrita quando CS=0
   - Valida funcionamento dos registradores

## Estrutura dos Arquivos

- `NiosAndUserHW.vhd`: Entidade principal com interface Avalon
- `NiosAndUserHW_tb.vhd`: Testbench que simula o comportamento do NIOS
- `simulate.do`: Script de simulação para ModelSim
- `run_simulation.bat`: Script batch para execução automática no Windows
- `bram1024x32.vhd`: Componente BRAM (referência para `../BRAM1024/`)
- `NiosAndUserHW.qpf`: Arquivo de projeto do Quartus
- `NiosAndUserHW.qsf`: Arquivo de configuração do Quartus

## Como Executar a Simulação

### No ModelSim:

#### Opção 1 - Navegando até a pasta:
1. Abra o ModelSim
2. Navegue até o diretório do projeto
3. Execute o script de simulação:
   ```
   do simulate.do
   ```

#### Opção 2 - Comando direto no Windows:
Execute diretamente no prompt de comando do Windows (não dentro do ModelSim):
```cmd
cd /d "C:\Users\MATHEUS.VPS\Repos\Personal\ReconfigurableLogic\NiosAndUserHW"
vsim -do simulate.do
```

**IMPORTANTE**: Os comandos `cd /d` são do Windows, não do ModelSim. Se você já estiver dentro do ModelSim, use apenas:
```
do simulate.do
```

#### Opção 3 - Script batch para Windows:
Execute o arquivo `run_simulation.bat` (já incluído no projeto):
```cmd
run_simulation.bat
```

Este script automaticamente:
- Compila todos os arquivos VHDL necessários
- Executa a simulação
- Exibe mensagens de progresso
- Pausa ao final para visualizar resultados

### No Quartus:

1. Abra o projeto `NiosAndUserHW.qpf`
2. Configure o testbench como top-level entity
3. Execute a simulação funcional

### Comandos Alternativos:

#### Para compilar e simular em uma linha:
```cmd
cd /d "C:\Users\MATHEUS.VPS\Repos\Personal\ReconfigurableLogic\NiosAndUserHW"
vlib work
vcom -work work ../BRAM1024/bram1024x32.vhd
vcom -work work NiosAndUserHW.vhd
vcom -work work NiosAndUserHW_tb.vhd
vsim -t ps work.niosanduserhw_tb -do simulate.do
```

## Instruções Específicas para ModelSim

### Se você já está dentro do ModelSim:
1. Certifique-se de estar no diretório correto (use `pwd` para verificar)
2. Execute apenas: `do simulate.do`

### Se você está no prompt do Windows:
1. Navegue até a pasta: `cd /d "C:\Users\MATHEUS.VPS\Repos\Personal\ReconfigurableLogic\NiosAndUserHW"`
2. Execute: `vsim -do simulate.do`

### Comandos TCL válidos no ModelSim:
- `pwd` - mostra diretório atual
- `cd <diretório>` - muda diretório (sem `/d`)
- `do simulate.do` - executa o script
- `do setup_simulation.tcl` - configura e executa automaticamente
- `quit -sim` - limpa simulação anterior

### Script de configuração automática:
Se você estiver dentro do ModelSim e não souber o diretório correto, execute:
```
do setup_simulation.tcl
```

Este script irá:
1. Verificar o diretório atual
2. Navegar automaticamente para o diretório correto
3. Executar a simulação

## Sequência de Dados

O testbench escreve a seguinte sequência repetidamente:

```
"MATHEUS VINICIUS PASSOS DE SANTANA +++--+++ MATHEUS VINICIUS PASSOS DE SANTANA +++--+++ ..."
```

- **Nome completo**: 34 caracteres (incluindo espaços)
- **Separador**: 10 caracteres (" +++--+++ ")
- **Total por ciclo**: 44 caracteres (índices 0 a 43)
- **Ciclos completos**: 1024 ÷ 44 = 23 ciclos completos + 12 caracteres restantes

## Verificações Realizadas

1. ✅ Escrita de 1024 caracteres
2. ✅ Leitura de 1024 caracteres  
3. ✅ Verificação de dados lidos vs escritos
4. ✅ Comportamento tri-state quando CS=0
5. ✅ Proteção de escrita quando CS=0
6. ✅ Funcionamento dos registradores de controle
7. ✅ Operações self-clearing (WE_MEM e RD_MEM)

## Saída Esperada

O testbench deve exibir no console:
- Progresso das escritas (a cada 100)
- Progresso das leituras (a cada 100)
- Nomes completos lidos da memória
- Confirmações de funcionamento correto
- Mensagem de conclusão do teste

## Notas Técnicas

- O testbench usa `std.env.stop` para finalizar a simulação
- Sinais tri-state são simulados com 'Z'
- A BRAM é acessada através da interface Avalon
- Todos os acessos respeitam o protocolo Avalon
