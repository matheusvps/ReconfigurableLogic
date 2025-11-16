# Script de simulação para NiosAndUserHW
# Executa o testbench que simula o comportamento do NIOS + User HW

# Limpa a simulação anterior
quit -sim

# Cria a biblioteca de trabalho
vlib work

# Compila os arquivos VHDL
vcom -work work ../BRAM1024/bram1024x32.vhd
vcom -work work NiosAndUserHW.vhd
vcom -work work NiosAndUserHW_tb.vhd

# Simula o testbench
vsim -t ps work.niosanduserhw_tb

# Adiciona sinais ao wave
add wave -divider "Clock e Reset"
add wave -position insertpoint sim:/niosanduserhw_tb/clk
add wave -position insertpoint sim:/niosanduserhw_tb/reset_n

add wave -divider "Avalon Bus"
add wave -position insertpoint sim:/niosanduserhw_tb/avs_address
add wave -position insertpoint sim:/niosanduserhw_tb/avs_write
add wave -position insertpoint sim:/niosanduserhw_tb/avs_read
add wave -position insertpoint sim:/niosanduserhw_tb/avs_writedata
add wave -position insertpoint sim:/niosanduserhw_tb/avs_readdata
add wave -position insertpoint sim:/niosanduserhw_tb/avs_chipselect

add wave -divider "Controle do Teste"
add wave -position insertpoint sim:/niosanduserhw_tb/write_count
add wave -position insertpoint sim:/niosanduserhw_tb/read_count
add wave -position insertpoint sim:/niosanduserhw_tb/current_addr
add wave -position insertpoint sim:/niosanduserhw_tb/current_char
add wave -position insertpoint sim:/niosanduserhw_tb/current_name
add wave -position insertpoint sim:/niosanduserhw_tb/write_phase

add wave -divider "Sinais Internos do DUT"
add wave -position insertpoint sim:/niosanduserhw_tb/dut/reg_addr
add wave -position insertpoint sim:/niosanduserhw_tb/dut/reg_data
add wave -position insertpoint sim:/niosanduserhw_tb/dut/reg_control
add wave -position insertpoint sim:/niosanduserhw_tb/dut/we_mem_pulse
add wave -position insertpoint sim:/niosanduserhw_tb/dut/rd_mem_pulse
add wave -position insertpoint sim:/niosanduserhw_tb/dut/bram_wren
add wave -position insertpoint sim:/niosanduserhw_tb/dut/bram_dout

# Configura o formato dos sinais
configure wave -namecolwidth 200
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

# Executa a simulação
run -all

# Mantém a janela aberta
wave zoom full

