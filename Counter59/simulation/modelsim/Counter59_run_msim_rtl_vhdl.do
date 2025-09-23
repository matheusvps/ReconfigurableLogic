transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter4WithLoad/Counter4WithLoad.vhd}
vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/Counter59/Counter59.vhd}

