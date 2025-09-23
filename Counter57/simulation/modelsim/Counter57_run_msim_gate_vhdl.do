transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {Counter57_6_1200mv_85c_slow.vho}

do "C:/Users/MATHEUS.VPS/Documents/Counter57/Lab2_GATE.do"
