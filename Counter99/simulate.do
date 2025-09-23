if {[file exists rtl_work]} {
    vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

# Compila primeiro o contador de 4 bits
vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter4WithLoad/Counter4WithLoad.vhd}

# Compila o contador de 99
vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter99/Counter99.vhd}

# Compila o testbench
vcom -reportprogress 300 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter99/Counter99_tb.vhd}

# Simula o testbench
vsim rtl_work.counter99_tb

# Adiciona sinais na waveform
add wave  \
    sim:/counter99_tb/clk \
    sim:/counter99_tb/rst \
    sim:/counter99_tb/en \
    sim:/counter99_tb/clr \
    sim:/counter99_tb/ld \
    sim:/counter99_tb/load \
    sim:/counter99_tb/q

# Mostra Q também em formato unsigned para ficar legível
add wave -radix unsigned sim:/counter99_tb/q

config wave -signalnamewidth 1

# Executa simulação por 5000 ns
run 5000 ns

# Ajusta zoom
WaveRestoreZoom {0 ns} {5000 ns}
