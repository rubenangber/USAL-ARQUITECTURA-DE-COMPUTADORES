def secuencia_3n1(valor_inicial):
    secuencia = []
    numero = valor_inicial
    maximo = valor_inicial

    while numero > 1:
        secuencia.append(numero)
        if numero % 2 == 0:
            numero /= 2
        else:
            numero = (3 * numero) + 1
        if numero > maximo:
            maximo = numero

    secuencia.append(1)
    return secuencia, maximo

# Ejemplo de uso
valor_inicial = int(input("Ingrese el valor inicial (entre 1 y 100) >> "))

if 1 <= valor_inicial <= 100:
    secuencia, maximo = secuencia_3n1(valor_inicial)
    media = sum(secuencia) / len(secuencia)
    print("Valor inicial >> ", valor_inicial)
    print("Secuencia >> ", secuencia)
    print("Longitud de la secuencia >> ", len(secuencia))
    print("Número máximo del vector >> ", maximo)
    print("Media de la secuencia >> ", media)

    # Crear el nuevo vector
    nuevo_vector = [
        valor_inicial * len(secuencia),
        maximo * len(secuencia),
        media * len(secuencia),
        (valor_inicial / maximo) * len(secuencia),
        (valor_inicial / media) * len(secuencia),
        (maximo / valor_inicial) * len(secuencia),
        (maximo / media) * len(secuencia),
        (media / valor_inicial) * len(secuencia),
        (media / maximo) * len(secuencia)
    ]

    print("Nuevo vector >> ", nuevo_vector)
    sumatorio_nuevo_vector = sum(nuevo_vector)
    media_nuevo_vector = sumatorio_nuevo_vector / len(nuevo_vector)
    print("Media del nuevo vector >> ", media_nuevo_vector)

else:
    print("Error: El valor inicial debe estar entre 1 y 100")
