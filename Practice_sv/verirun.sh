#!/bin/bash
# verirun.sh - Compila, ejecuta y limpia

echo "🚀 Compilando con Verilator..."
echo "Nombre del archivo de diseño (ej: transaction.sv):"
read DISENO

echo "Nombre del archivo testbench (ej: 1_practice_tb.sv):"
read TESTBENCH

# Compilar
verilator --binary -Wno-fatal "$DISENO" "$TESTBENCH"

if [ $? -eq 0 ] || [ $? -eq 2 ]; then
    echo "✅ Compilación exitosa"
    echo "▶️  Ejecutando simulación..."
    
    # Mostrar qué ejecutables hay
    echo "Ejecutables disponibles en obj_dir:"
    ls -la obj_dir/V*
    
    # Intentar ejecutar el que encontró Verilator
    if [ -f "obj_dir/V1_practice_tb" ]; then
        ./obj_dir/V1_practice_tb
    elif [ -f "obj_dir/V__031_practice" ]; then
        ./obj_dir/V__031_practice
    else
        echo "Usando el primer ejecutable encontrado:"
        ./obj_dir/V*
    fi
    
    echo "🧹 Limpiando obj_dir..."
    rm -rf obj_dir/
    
    echo "✅ ¡Listo!"
else
    echo "❌ Error en compilación"
    exit 1
fi