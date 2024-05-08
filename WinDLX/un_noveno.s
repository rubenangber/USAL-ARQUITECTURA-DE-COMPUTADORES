.data
;; VARIABLES DE ENTRADA Y SALIDA: NO MODIFICAR ORDEN
; VARIABLE DE ENTRADA: (SE PODRA MODIFICAR EL VALOR ENTRE 1 Y 100)
valor_inicial:                  .word       10
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
    lf f1, un_noveno
    
    add r1, r0, #1
    add r1, r1, 0
    movi2fp f3, r1
    cvti2f f3, f3

    add r2, r0, #9
    add r2, r2, 0
    movi2fp f4, r2
    cvti2f f4, f4

    divf f2, f3, f4

    movfp2i r5, f1
    movfp2i r6, f2

    trap 0                          