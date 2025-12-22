_start:
main_loop:
    # === Leer switches [1:0] del registro de entrada ===
    # t0 = dirección de los switches (0x2000)     
    addi t0, x0, 512         # 512 * 4 = 0x2000
    slli t0, t0, 4           # t0 = 0x2000 (porque se direcciona por bytes)
    lw t1, 0(t0)             # t1 = contenido del registro de switches
    andi t2, t1, 0x3         # t2 = switch[1:0]

    # === Calcular dirección del retardo en RAM ===

    # Calcular offset = t2 * 4 (4 bytes por palabra)
    slli t2, t2, 2           # offset de posición del retardo en RAM
    addi t3, x0, 1024        # 1024 * 4 = 0x1000
    slli t3, t3, 2           # t3 = 0x1000
    add  t4, t3, t2          # t4 = dirección en RAM con valor del retardo
    lw   t7, 0(t4)           # t7 = valor del retardo (ej. 10_000_000 para 1s)

    
    # ------------------------
    # Programar el TIMER
    # ------------------------

    # === Cargar retardo al timer ===
    addi t0, x0, 2000        # t0 = 0x201C / 4
    addi t0, t0, 55
    slli t0, t0, 2           # t0 = 0x201C
    sw t7, 0(t0)             # Guardar el valor del retardo en TIMER_DATA

    # === Iniciar timer ===
    addi t0, x0, 2000        # t0 = 0x2018 / 4
    addi t0, t0, 54
    slli t0, t0, 2           # t0 = 0x2018
    addi t3, x0, 1           # t3 = 0x1 → activar ctrl[0]
    sw t3, 0(t0)             # Iniciar el conteo del timer (ctrl[0] = 1)

wait_timer:
    lw   t4, 0(t0)           # Leer TIMER_CTRL
    andi t5, t4, 0x2         # Ver si ctrl[1] (bit 1) está activo
    beq  t5, x0, wait_timer  # Si no ha terminado, sigue esperando

    # ------------------------
    # LED ON → señal de actividad
    # ------------------------

    # Dirección del LED = 0x2004
    addi t0, x0, 512         # base = 0x2000
    slli t0, t0, 4
    addi t1, x0, 4
    add  t2, t0, t1          # t2 = 0x2004
    addi t3, x0, 1
    sw t3, 0(t2)             # Enciende el LED

    # ------------------------
    # Activar lectura del sensor TMP (ADC)
    # ------------------------

    # Dirección de TMP_CTRL = 0x2030
    addi t0, x0, 515         # 515 * 4 = 0x2030
    slli t0, t0, 4
    addi t1, x0, 1
    sw t1, 0(t0)             # Solicitar una lectura al TMP

wait_tmp:
    lw   t4, 0(t0)           # Leer TMP_CTRL
    andi t5, t4, 0x2         # Verificar si bit de listo (bit 1) está activo
    beq  t5, x0, wait_tmp    # Esperar hasta que esté listo

    # ------------------------
    # Leer valor de TMP_DATA (resultado ADC)
    # ------------------------

    addi t0, x0, 517         # 517 * 4 = 0x2034
    slli t0, t0, 4
    lw   t3, 0(t0)           # t3 = cuentas del sensor (ej. 0–1023)

    # ------------------------
    # Convertir a grados Celsius: (cuentas * 500) >> 10
    # t3 * 500 = t3 * (128 - 2 - 1) * 4
    # 500 = 125 * 4 = (128 - 3) * 4 = ((t3<<7 - t3<<1 - t3) << 2) >> 10
    # ------------------------

    slli t4, t3, 7           # t4 = t3 * 128
    slli t5, t3, 1           # t5 = t3 * 2
    sub  t6, t4, t5          # t6 = t3 * 126
    sub  t7, t6, t3          # t7 = t3 * 125
    slli t6, t7, 2           # t6 = t3 * 500
    srli a1, t6, 10          # a1 = (t3 * 500) >> 10

    # ------------------------
    # Mostrar en display de 7 segmentos
    # ------------------------

    addi t0, x0, 512
    slli t0, t0, 4           # t0 = 0x2000
    addi t1, x0, 8
    add  t2, t0, t1          # t2 = 0x2008 (dirección display)
    sw   a1, 0(t2)           # Mostrar temperatura en °C

    # ------------------------
    # Apagar LED
    # ------------------------

    addi t0, x0, 512
    slli t0, t0, 4
    addi t1, x0, 4
    add  t2, t0, t1          # t2 = 0x2004
    sw   x0, 0(t2)           # Apagar LED (escribir 0)

    # ------------------------
    # Repetir el ciclo
    # ------------------------

    jal x0, main_loop        # Salto incondicional a main_loop