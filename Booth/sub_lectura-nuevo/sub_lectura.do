vlog -sv sub_lectura.sv
vlog -sv tb_sub_lectura.sv

vsim -voptargs=+acc -t ns -onfinish stop tb_sub_lectura

add wave *

run -all
