.data
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100)
valor_inicial:                  .word       97
;; VARIABLES DE SALIDA:
secuencia:                      .space      120*4
secuencia_tamanho:              .word       0
secuencia_maximo:               .word       0
secuencia_valor_medio:          .float      0
lista:                          .space      9*4
lista_valor_medio:              .float      0
;; FIN VARIABLES DE ENTRADA Y SALIDA

.text
.global main

main:
    addi r1, r0, secuencia          ; Cargar secuencia en r1
    lw r5, valor_inicial            ; Cargar en r5 valor_inicial
    add r5, r5, 0                   ; Convertir r5 en un registro float en f1
    movi2fp f1, r5                  ; Convertir r5 en un registro float en f1
    cvti2f f1, f1                   ; Convertir r5 en un registro float en f1

    add r13, r0, #3                 ; 3
    add r14, r0, #9                 ; 9
    movi2fp f30, r14                ; Convertir r14 en un registro float f30
    cvti2f f30, f30                 ; Convertir r14 en un registro float f30

    sf 0(r1), f1                    ; Guardamos el valor calculado en la posicion

    addi r1, r1, #4                 ; Movemos la posicion efectiva del vector
    addi r3, r3, #1                 ; Sumamos 1 al tamaño
    addi r30, r30, #1               ; Sumamos 1 al tamaño_aux

    movi2fp f5, r5
    cvti2f f5, f5

    movf f25, f0                    ; f25 = 0

bucle:
    addf f25, f25, f1               ; sumatorio = sumatorio + n

    subi r11, r5, #1                ; Si r5 - 1 == 0 salir del bucle
    beqz r11, fin_bucle             ; Si r5 - 1 == 0 salir del bucle

    addi r3, r3, #1                 ; Sumamos 1 al tamaño
    addi r30, r30, #1               ; Sumamos 1 al tamaño_aux

    andi r12, r5, 1                 ; Si el bit menos significativo de r5 es 0, es par, si es 1 impar
    beqz r12, par                   ; Si r12 es 0 salta a par

    mult r5, r5, r13                ; Si es impar r5 * 3 + 1
    addi r5, r5, #1                 ; Si es impar r5 * 3 + 1
    movi2fp f1, r5                  ; Si es impar r5 * 3 + 1
    cvti2f f1, f1                   ; Si es impar r5 * 3 + 1

    sf 0(r1), f1                    ; Guardamos el valor calculado en la posicion
    addi r1, r1, #4                 ; Movemos la posicion efectiva de secuencia

    j bucle

par:
    srli r5, r5, 1                  ; Desplazamiento a la derecha (equivale a dividir entre 2)
    movi2fp f1, r5                  ; Desplazamiento a la derecha (equivale a dividir entre 2)
    cvti2f f1, f1                   ; Desplazamiento a la derecha (equivale a dividir entre 2)

    sf 0(r1), f1                    ; Guardamos el valor calculado en la posicion
    addi r1, r1, #4                 ; Movemos la posicion efectiva de secuencia
    j bucle

fin_bucle:
    addi r1, r0, secuencia          ; Reiniciamos el vector secuencia a secuencia[0]
    lw r5, valor_inicial            ; Cargamos el valor_inicial a r5
    add r5, r5, 0
    movi2fp f1, r5                  ; f1 = valor_inicial
    cvti2f f1, f1                   ; f1 = valor_inicial
    movi2fp f2, r5                  ; f2 = valor_inicial
    cvti2f f2, f2                   ; f2 = valor_inicial

    addi r1, r1, #4                 ; Movemos la posicion efectiva de secuencia
    subi r30, r30, #1               ; Restamos 1 al tamaño_aux
    beqz r30, final                 ; Si tamaño_aux == 0, final

bucle_mayor:
    lf f1, 0(r1)                    ; f1 = secuencia[n]
    subi r30, r30, #1               ; Restamos 1 al tamaño_aux
    beqz r30, final                 ; Si tamaño_aux == 0, final

    gtf f1, f2                      ; Comparamos f1 y f2
    bfpt si_mayor                   ; Si f1 > f2, si_mayor

    addi r1, r1, #4                 ; Movemos la posicion efectiva de secuencia
    j bucle_mayor

si_mayor:
    lf f2, 0(r1)                    ; f2 = secuencia[n]

    addi r1, r1, #4                 ; Movemos la posicion efectiva de secuencia
    j bucle_mayor

final:
    add r3, r3, 0                   ; tamaño en float
    movi2fp f3, r3                  ; tamaño en float
    cvti2f f3, f3                   ; tamaño en float
    sf secuencia_tamanho, f3        ; Cargar secuencia_tamanho

    divf f4, f25, f3
    sf secuencia_valor_medio, f4    ; Cargar secuencia_valor_medio

    sf secuencia_maximo, f2         ; Cargar secuencia_maximo

    addi r2, r0, lista              ; Cargamos lista en r2

    multf f7, f5, f3                ; vIni * vT
    addf f17, f0, f7                ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    multf f7, f2, f3                ; vMax * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    multf f7, f4, f3                ; vMed * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    divf f7, f5, f2                 ; vIni / vMax
    multf f7, f7, f3                ; vIni / vMax * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    divf f7, f5, f4                 ; vIni / vMed
    multf f7, f7, f3                ; vIni / vMed * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    divf f7, f2, f5                 ; vMax / vIni
    multf f7, f7, f3                ; vMax / vIni * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    divf f7, f2, f4                 ; vMax / vMed
    multf f7, f7, f3                ; vMax / vMed * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    divf f7, f4, f5                 ; vMed / vIni
    multf f7, f7, f3                ; vMed / vIni * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    divf f7, f4, f2                 ; vMed / vMax
    multf f7, f7, f3                ; vMed / vMax * vT
    addf f17, f17, f7               ; sumatorio lista
    sf 0(r2), f7
    addi r2, r2, #4

    add r14, r14, 0                 ; Convertir r14 (9) en el registro f20
    movi2fp f20, r14                ; Convertir r14 (9) en el registro f20
    cvti2f f20, f20                 ; Convertir r14 (9) en el registro f20

    divf f17, f17, f20              ; sumatorio = sumatorio / 9
    sf lista_valor_medio, f17       ; Cargar lista_valor_medio

    trap 0
