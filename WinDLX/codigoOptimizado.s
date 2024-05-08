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
un_noveno:                      .float      0.11111111
;; FIN VARIABLES DE ENTRADA Y SALIDA

.text
.global main

main:
    addi r1, r0, secuencia          ; Cargar secuencia en r1
    lw r5, valor_inicial            ; Cargar en r5 valor_inicial
    addi r2, r0, lista              ; Cargar en r2 lista
    add r5, r5, 0                   ; Convertir r5 en un registro float en f1
    movi2fp f1, r5                  ; Convertir r5 en un registro float en f1
    cvti2f f1, f1                   ; Convertir r5 en un registro float en f1

    add r13, r0, #3                 ; 3
    
    sf 0(r1), f1                    ; Guardamos el valor calculado en la posicion
    movf f2, f1                     ; f2 = f1

    addi r1, r1, #4                 ; Movemos la posicion efectiva del vector
    addi r3, r3, #1                 ; Sumamos 1 al tamaño

    movf f5, f1                     ; f5 = f1

    movf f25, f0                    ; f25 = 0

bucle:
    subi r11, r5, #1                ; r5 - 1
    addf f25, f25, f1               ; sumatorio = sumatorio + n

    beqz r11, fin_bucle             ; Si r5 - 1 == 0 salir del bucle

    andi r12, r5, 1                 ; Si el bit menos significativo de r5 es 0, es par, si es 1 impar
    addi r3, r3, #1                 ; Sumamos 1 al tamaño
    
    beqz r12, par                   ; Si r12 es 0 salta a par

    mult r5, r5, r13                ; Si es impar r5 * 3 + 1
    addi r5, r5, #1                 ; Si es impar r5 * 3 + 1
    movi2fp f1, r5                  ; Si es impar r5 * 3 + 1
    cvti2f f1, f1                   ; Si es impar r5 * 3 + 1

    sf 0(r1), f1                    ; Guardamos el valor calculado en la posicion
    addi r1, r1, #4                 ; Movemos la posicion efectiva del vector

    gtf f1, f2                      ; Comparamos f1 y f2
    bfpt si_mayor                   ; Si f1 > f2, si_mayor

    j bucle

par:
    srli r5, r5, 1                  ; Desplazamiento a la derecha (equivale a dividir entre 2)
    movi2fp f1, r5
    cvti2f f1, f1

    sf 0(r1), f1                    ; Guardamos el valor calculado en la posicion
    addi r1, r1, #4                 ; Movemos la posicion efectiva del vector
    j bucle

si_mayor:
    movf f2, f1                     ; f2 = f1
    j bucle

fin_bucle:
    add r3, r3, 0                   ; tamaño en float
    movi2fp f3, r3                  ; tamaño en float
    cvti2f f3, f3                   ; tamaño en float

    divf f4, f25, f3                ; secuencia_valor_medio

    multf f6, f5, f3                ; vIni * vT
    lf f31, un_noveno               ; Cargamos en f31, un_noveno
    multf f7, f2, f3                ; vMax * vT
    multf f8, f4, f3                ; vMed * vT

    divf f9, f6, f2                 ; vIni * vT / vMax
    divf f12, f7, f4                ; vMax * vT / vMed
    divf f13, f8, f5                ; vMed * vT / vIni

    divf f10, f6, f4                ; vIni * vT / vMed
    divf f11, f7, f5                ; vMax * vT / vIni
    divf f14, f8, f2                ; vMed * vT / vMax

    addf f15, f6, f7                ; sumatorio_lista

    sf 0(r2), f6                    ; Cargar lista[0]
    sf 4(r2), f7                    ; Cargar lista[1]

    addf f15, f15, f8               ; sumatorio_lista
    addf f15, f15, f9               ; sumatorio_lista

    sf 8(r2), f8                    ; Cargar lista[2]
    sf 12(r2), f9                   ; Cargar lista[3]

    addf f15, f15, f10              ; sumatorio_lista
    addf f15, f15, f11              ; sumatorio_lista

    sf 16(r2), f10                  ; Cargar lista[4]
    sf 20(r2), f11                  ; Cargar lista[5]

    addf f15, f15, f12              ; sumatorio_lista
    addf f15, f15, f13              ; sumatorio_lista

    sf 24(r2), f12                  ; Cargar lista[6]
    sf 28(r2), f13                  ; Cargar lista[7]

    addf f15, f15, f14              ; sumatorio_lista

    sf 32(r2), f14                  ; Cargar lista[8]

    multf f15, f15, f31             ; sumatorio = sumatorio * 0.11111111 (sumatorio / 9)

    sf secuencia_maximo, f2         ; Cargar secuencia_maximo
    sf secuencia_valor_medio, f4    ; Cargar secuencia_valor_medio
    sf secuencia_tamanho, f3        ; Cargar secuencia_tamanho

    sf lista_valor_medio, f15       ; lista_valor_medio

    trap 0;
