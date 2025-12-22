vlog -sv con_hacia_abajo.sv
vlog -sv tb_con_hacia_abajo.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_con_hacia_abajo

add wave *

run -all
