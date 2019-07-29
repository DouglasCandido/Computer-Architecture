# -*- coding: utf-8 -*-
# Aluno: Douglas Mateus Soares Cândido da Silva
# Questão 1

print('\n')

# Hexadecimal:
n_hexa = int(input('Digite um número hexadecimal com 4 dígitos: '), 16)

print('\n')

n_hexa_str = hex(n_hexa)
n_hexa_bin = format(n_hexa, '016b')

# Binário para Ponto Flutuante:
excesso = 15 # Excesso: 15
maior_expoente = excesso # Maior expoente: 15
menor_expoente = -14 # Menor expoente: -14

sinal = n_hexa_bin[0]
expoente = n_hexa_bin[1:6]
mantissa = n_hexa_bin[6:]
expoente_decimal = int(expoente, 2) # Converte para decimal utilizando a lógica do polinômio 
expoente_decimal -= excesso

# A lógica do polinômio é novamente utilizada para descobrir a parte fracionária (depois da vírgula)
parte_fracionaria = 0
index  = -1 # Representa o expoente do 2 na multiplicação do polinômio. Ex: 1 x 2^-1 + 0 * 2^-2...
for i in mantissa:
	parte_fracionaria += int(i) * (2 ** index)
	index -= 1

# Tratamento de casos específicos:
if expoente == '11111': # Não normalizado
	print('Não normalizado.\n')
	if sinal == '1' and mantissa == '0000000000':
    		print('-' + u'\u221E' + ' (Tende a menos infinito).')
	elif sinal == '0' and mantissa == '0000000000':
    		print('+' + u'\u221E' + ' (Tende a mais infinito).')
	elif sinal == '1' and mantissa == '1000000000':
    		print('Indeterminação.')
	else:
    		print('NaN - Not a Number.')

elif expoente != '00000' and expoente != '11111': # Normalizado
	if sinal == '0':
		sinal_str = '+'
		sinal_pf = '0'
	elif sinal == '1':
		sinal_str = '-'
		sinal_pf = '1'
	bit_escondido_pf = '1'
	print('Normalizado. \n')
	n_pf_bin = sinal_str + bit_escondido_pf + '.' + str(n_hexa_bin[6:]) + 'x2^' + str(expoente_decimal)
	n_pf_dec = (1 + parte_fracionaria) * (2 ** expoente_decimal)
	print(n_hexa_bin + ' --> ' + n_pf_bin + ' --> ' + sinal_str + str(n_pf_dec))

else:
	print('Não Normalizado. \n')
	bit_escondido_pf = '0'
	if sinal == '0':
		sinal_str = '+'
		sinal_pf = '0'
	elif sinal == '1':
		sinal_str = '-'
		sinal_pf = '1'
	n_pf_bin = sinal_str + bit_escondido_pf + '.' + str(n_hexa_bin[6:]) + 'x2^' + str(expoente_decimal)
	n_pf_dec = (1 + parte_fracionaria) * (2 ** expoente_decimal)
	print(n_hexa_bin + ' --> ' + n_pf_bin + ' --> ' + sinal_str + str(n_pf_dec))

print('\n')

