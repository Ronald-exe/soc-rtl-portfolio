$env:Path = 'C:\intelFPGA\20.1\modelsim_ase\win32aloem;' + $env:Path

$REPO = Get-Location
$REPO = $REPO -replace "\\","/"
Write-Host $REPO

vlib work
vmap work work
vlog -sv fifo_flops_tb.sv fifo_flops.sv 
vsim -c -voptargs=+acc work.fifo_flops_tb -do sim.do
vsim -view vsim.wlf
