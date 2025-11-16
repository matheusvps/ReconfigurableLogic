# Script TCL para configurar a simulação no ModelSim
# Execute este script se você estiver dentro do ModelSim

# Mostra o diretório atual
puts "Diretório atual: [pwd]"

# Tenta navegar para o diretório correto
# Ajuste o caminho conforme necessário
set target_dir "C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/NiosAndUserHW"

if {[file exists $target_dir]} {
    cd $target_dir
    puts "Navegando para: [pwd]"
    
    # Executa o script de simulação
    puts "Executando script de simulação..."
    do simulate.do
} else {
    puts "ERRO: Diretório não encontrado: $target_dir"
    puts "Por favor, navegue manualmente para o diretório correto e execute: do simulate.do"
    puts "Ou use o comando: cd <caminho_para_o_diretorio>"
}

