vlog -sv FSM.sv
vlog -sv tb_FSM.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_fsm

add wave *

run -all
