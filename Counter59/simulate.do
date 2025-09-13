if {[file exists rtl_work]} {
    vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

# Compila primeiro o contador de 4 bits
vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter4WithLoad/Counter4WithLoad.vhd}

# Compila o contador de 59
vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter59/Counter59.vhd}

# Compila o testbench
vcom -reportprogress 300 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter59/Counter59_tb.vhd}

# Simula o testbench
vsim rtl_work.counter59_tb

# Adiciona sinais na waveform
add wave  \
    sim:/counter59_tb/clk \
    sim:/counter59_tb/rst \
    sim:/counter59_tb/en \
    sim:/counter59_tb/clr \
    sim:/counter59_tb/ld \
    sim:/counter59_tb/load \
    sim:/counter59_tb/q

# Mostra Q também em formato unsigned para ficar legível
add wave -radix unsigned sim:/counter59_tb/q

config wave -signalnamewidth 1

# Executa simulação por 5000 ns
run 5000 ns

# Ajusta zoom
WaveRestoreZoom {0 ns} {5000 ns}
