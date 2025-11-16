transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/BRAM1024/bram1024x32.vhd}
vcom -93 -work work {C:/Users/MATHEUS.VPS/Repos/Personal/ReconfigurableLogic/NiosAndUserHW/NiosAndUserHW.vhd}

