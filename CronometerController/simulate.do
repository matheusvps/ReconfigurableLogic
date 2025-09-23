# Limpa a biblioteca rtl_work se já existir
if {[file exists rtl_work]} {
    vdel -lib rtl_work -all
}

# Cria a biblioteca
vlib rtl_work
vmap work rtl_work

# Compilação do VHDL do CronometerController
vcom -93 -work work "C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/CronometerController/CronometerController.vhd"

# Compilação do testbench
vcom -reportprogress 300 -work work "C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/CronometerController/CronometerController_tb.vhd"

# Simulação
vsim rtl_work.CronometerController_tb

# Adiciona sinais à wave
add wave  \
    sim:/CronometerController_tb/btn_reset_s \
    sim:/CronometerController_tb/btn_clear_s \
    sim:/CronometerController_tb/btn_pause_s \
    sim:/CronometerController_tb/state_out

# Configura exibição de nome de sinal na wave
config wave -signalnamewidth 1

# Executa a simulação
run 5000 ns

# Ajusta zoom da wave
WaveRestoreZoom {0 fs} {5000 ns}
