vcom -93 -work work {C:/Users/MATHEUS.VPS/Documents/Counter4WithLoad/Counter4WithLoad.vhd}
vcom -93 -work work {C:/Users/MATHEUS.VPS/Documents/Counter57/Counter57.vhd}
vcom -reportprogress 300 -work work C:/Users/MATHEUS.VPS/Documents/Counter57/Counter57_TB.vhd

vsim work.Counter57_TB

add wave \
 sim:/Counter57_TB/clk_tb \
 sim:/Counter57_TB/rst_tb \
 -radix unsigned sim:/Counter57_TB/q_tb \
 sim:/Counter57_TB/en_tb \
 sim:/Counter57_TB/clr_tb \
 sim:/Counter57_TB/ld_tb \
 sim:/Counter57_TB/load_tb

config wave -signalnamewidth 1
run 5000 ns
WaveRestoreZoom {0 fs} {5000 ns}
