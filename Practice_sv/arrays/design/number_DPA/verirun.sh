#!/bin/bash
# verirun.sh - Compila, ejecuta y limpia

echo "🚀 Compilando con Verilator..."
read pepe
verilator --binary --build "$pepe".sv

echo "▶️  Ejecutando simulación..."
./obj_dir/V"$pepe"

echo "🧹 Limpiando obj_dir..."
rm -rf obj_dir/

echo "✅ ¡Listo!"
