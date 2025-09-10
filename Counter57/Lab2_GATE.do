# Limpa biblioteca gate_work se existir
if {[file exists "C:/Users/MATHEUS.VPS/Documents/Counter57/simulation/modelsim/gate_work"]} {
    vdel -lib "C:/Users/MATHEUS.VPS/Documents/Counter57/simulation/modelsim/gate_work" -all
}

# Cria e mapeia a biblioteca gate_work
vlib "C:/Users/MATHEUS.VPS/Documents/Counter57/simulation/modelsim/gate_work"
vmap work "C:/Users/MATHEUS.VPS/Documents/Counter57/simulation/modelsim/gate_work"

# Compila arquivos VHDL
vcom -93 -work work "C:/Users/MATHEUS.VPS/Documents/Counter57/simulation/modelsim/Counter57_6_1200mv_85c_slow.vho"
vcom -reportprogress 300 -work work "C:/Users/MATHEUS.VPS/Documents/Counter4WithLoad/Counter4WithLoad.vhd"
vcom -reportprogress 300 -work work "C:/Users/MATHEUS.VPS/Documents/Counter57/Counter57_TB.vhd"

# Simulação com SDF back-annotation
vsim -t 1ps +transport_int_delays +transport_path_delays \
    -sdftyp /uut=C:/Users/MATHEUS.VPS/Documents/Counter57/simulation/modelsim/Counter57_6_1200mv_85c_vhd_slow.sdo \
    -L altera -L work -voptargs="+acc" Counter57_TB

# Adiciona sinais à Wave (um por linha para evitar problemas)
add wave  \
 sim:/Counter57_TB/clk_tb \
 sim:/Counter57_TB/rst_tb \
 sim:/Counter57_TB/q_tb \
 -radix unsigned -position end sim:/Counter57_TB/q_tb \
 sim:/Counter57_TB/en_tb \
 sim:/Counter57_TB/clr_tb \
 sim:/Counter57_TB/ld_tb \
 sim:/Counter57_TB/dload_tb 

# Configurações de visualização da Wave
config wave -signalnamewidth 1

# Roda a simulação por 5000 ns
run 5000 ns

# Ajusta zoom da Wave
WaveRestoreZoom {0 fs} {5000 ns}
