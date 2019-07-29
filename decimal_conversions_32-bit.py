# -*- coding: utf-8 -*-
# Aluno: Douglas Mateus Soares Cândido da Silva
# Questão 2

import random

arquitetura_pc_dec = 32 # Referente a arquitetura que o meu computador trabalha

maior_numero_dec_possivel = (2 ** (arquitetura_pc_dec - 1) - 1) 
menor_numero_dec_possivel = -2 ** (arquitetura_pc_dec - 1)

numero_dec_sorteado = random.randint(menor_numero_dec_possivel, maior_numero_dec_possivel)
n_int = numero_dec_sorteado

if(numero_dec_sorteado < 0):
	complemento_de_1 = (numero_dec_sorteado * -1) ^ maior_numero_dec_possivel
	complemento_de_2 = complemento_de_1 + 1

else:
	complemento_de_2 = numero_dec_sorteado

conteudo_da_memoria_da_variavel_hex = format(complemento_de_2, '08x')
conteudo_da_memoria_da_variavel_hex = conteudo_da_memoria_da_variavel_hex.upper()
conteudo_da_memoria_da_variavel_bin = format(complemento_de_2, '032b')

print('Número decimal sorteado: %d' %numero_dec_sorteado) 
print('Representado como int: %d' %n_int)
print('Representado em Unsigned Int: %d' %complemento_de_2)
print('Conteúdo da memória da variável em hexadecimal: %s' %conteudo_da_memoria_da_variavel_hex)
print('Conteúdo da memória da variável em binário: %s' %conteudo_da_memoria_da_variavel_bin)