echo "Nombre del diseno"
read diseno
echo "Nombre del testbech"
read testbech

echo "corriendo simulacion"
iverilog -g2012 -o sim  /home/ronald_soc/Documents/github/soc-rtl-portfolio/Practice_sv/Basic_sys/design/"$diseno" /home/ronald_soc/Documents/github/soc-rtl-portfolio/Practice_sv/Basic_sys/testbech/"$testbech"

echo "Simulacion del programa"
vvp sim
