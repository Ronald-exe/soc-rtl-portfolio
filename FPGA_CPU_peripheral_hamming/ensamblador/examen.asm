main_loop:
    # Direcci?n base perifericos
    addi t0, x0, 0x200
    slli t0, t0, 4       # t0 = 0x2000

    # Inicializar contador en t6
    addi t6, x0, 0

main_loop_wait:
    # Leer BTN-C (en 0x2010)
    addi t1, x0, 1024
    slli t1, t1, 6       # t1 = contine el valor de BTNC
    lw   t2, 16(t0)      # Leer valor combinado (BTN-C + switches)

    and  t4, t1, t2      # Verificamos si el BTN-C activo
    beq  t4, x0, main_loop_wait

    # Leer switches
    lw t3, 16(t0)

operacion:
    # Enviar a periferico (direccion base 0x3000)
    addi t0, x0, 0x300
    slli t0, t0, 4       # t0 = 0x3000

    sw t3, 0(t0)         # enviar switches
    lw t5, 4(t0)         # leer resultado del periferico

    # Incrementar contador de operaciones
    addi t0, x0, 0x200
    slli t0, t0, 4       # t0 = 0x2000
    addi t6, t6, 1       # t6++
    sw   t6, 8(t0)

    # Mostrar resultado en LEDs (0x2004)
    addi t0, x0, 0x200
    slli t0, t0, 4       # t0 = 0x2000
    sw t5, 4(t0)

esperar_liberacion:
    lw   t2, 16(t0)      # volver a leer BTN-C
    and  t4, t1, t2
    bne  t4, x0, esperar_liberacion

    jal x0, main_loop_wait