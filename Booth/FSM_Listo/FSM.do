vlog -sv FSM_Booth.sv
vlog -sv sub_lectura.sv
vlog -sv con_hacia_abajo.sv
vlog -sv multiplicador_sin_control.sv
vlog -sv tb_fsm.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_fsm

add wave *

run -all
