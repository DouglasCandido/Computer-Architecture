# Q2 2020_6

# Aluno: Douglas Mateus Soares C�ndido da Silva

#Implementar:

# for(i=0;i<5;i++){
#    F[i] = A[B[i]] - 5 + i;
# }

#resultado esperado F = 9, 5, 1, 23, 69 
 
.data # �rea destinada � declara��o de vari�veis que ir�o armazenar dados est�ticos

	i: .word 0 # Declare i inteiro e igual a zero
	
	# Essas instru��es tratam da aloca��o de endere�os, bem como o seu preenchimento com valores, para as posi��es
	# dos vetores (Arrays)
	F: .word 0, 0, 0, 0, 0	# Declare F inteiro com 5 posi��es e inicialize todas com 0
	A: .word 14, 9, 4, 25, 70 # Declare A inteiro com 5 posi��es e inicialize com 14 9 4 25 70
	B: .word 0, 1, 2, 3, 4	# Declare B inteiro com 5 posi��es e inicialize com 0 1 2 3 4
	
	# O tipo de dado .word foi utilizado porque a arquitetura do MIPS trabalha com instru��es com o tamanho de 32 bits 
	# e, portanto, para representar n�meros inteiros a arquitetura dedica 4 Bytes (Sua limita��o de representatividade)

.text # �rea destinada ao corpo do programa, contendo o procedimento principal (Main) e poss�veis outros procedimentos, al�m de outras instru��es.

	.globl main # O .globl � uma diretiva para o assembler (Montador) que permite fazer com que o procedimento Main deste programa
 		    # possa ser chamado a partir de outros programas
 		    # Percebi que isso � um padr�o em todos os exemplos e portanto decidi adota-lo
 			
		main: # Label que indica onde a primeira instru��o do procedimento principal main ir� come�ar. 
  
  			# Como F, A e B s�o vetores, eu utilizei a instru��o la (Load Adress) para carregar o endere�o
  			# equivalente a primeira posi��o dos vetores espec�ficos nos registradores espec�ficos 
  			la $s5, F
  			la $s6, A
  			la $s7, B
  			
  			lw $s1, i # Como i j� foi declarado no .data, eu utilizo o lw (Load Word) para carregar seu valor atual no 
  				  # registrador $s1
  				  # O valor de i, inicialmente, ser� zero e, a partir da�, o la�o de repeti��o for ser� iterado
  				  # com a incrementa��o do valor atual de i
  				  # Todas as opera��es que est�o dentro do la�o de repeti��o passar�o a executar com valores atualizados
  				  # at� chegar a sua condi��o de parada, ou seja, quando i for igual a 5
  			
			li $s0, 5 # Utilizei a instru��o li (Load Immediate) para carregar no registrador $s0 o valor 5
				  # $s0 atuar� como delimitador (Condi��o de parada) do la�o de repeti��o for
  
  		for: # Esse label indica onde come�a o la�o de repeti��o for
    			beq $s1, $s0, exit # Compara��o: se o i for igual a 5, vai para 'exit' (encerra o la�o de repeti��o)
    					   # Para realizar essa compara��o e preservar o padr�o de codifica��o de um for, 
    					   # utilizei a instru��o beq (Branch on equal)
    					   # Essa instru��o compara dois valores e, se forem iguais, transfere o fluxo de controle
    					   # do programa para o label designado
    					   # Ou seja, atualiza o valor de pc (Program Counter) que aponta para a pr�xima instru��o
    					   # a ser processada
   
   			sll $t0, $s1, 2 # $t0 = 4 * i
   					# Atrav�s da resolu��o de exemplos e exerc�cios e, com a ajuda do monitor, notei que
   					# quando se trabalha com vetores na arquitetura MIPS � necess�rio fazer o processo passo a passo
   					# Entendi o padr�o de codifica��o e notei que o primeiro passo � multiplicar por 4,
   					# atrav�s da instru��o sll (Shift left logical), a vari�vel que atuar� como �ndice do
   					# vetor, pois na arquitetura MIPS isso � necess�rio para percorrer a mem�ria
   					# Como o tipo de dados dos vetores � inteiro de 32 bits e a mem�ria opera com bytes, �
   					# necess�rio multiplicar o �ndice por 4, pois isso significa dizer que
   					# a posi��o atual do vetor e suas posi��es seguintes ser�o determinadas pelo avan�o
   					# ou retrocesso de 4 bytes * o �ndice atual + o endere�o de mem�ria atual correspondente
   					# a posi��o do vetor especificada pelo determinado �ndice
   					# O registrador $t0 ser� utilizado posteriormente para indexa��o por todos os vetores
   					
   					
   					
   			add $t1, $t0, $s7 # $t1 = &B[i] -----> Endere�o da primeira posi��o do vetor B[i]
   					  # Pois o registrador $s7 cont�m o endere�o base da primeira posi��o do vetor B
   					  # Ent�o basta indexa-lo com i, que foi tratado no registrador $t0
    			lw $t1, 0($t1) # $t1 = B[i] -> Conte�do da primeira posi��o do vetor B[i]
    				       # $t1 cont�m o endere�o da primeira posi��o do vetor B[i]
    				       # mas para se transferir o conte�do da primeira posi��o � necess�rio
    				       # utilizar uma instru��o Load Word para o registrador $t1 com o offset 0, ou seja,
    				       # o deslocamento zero simboliza que est� transferindo o conte�do contido na primeira posi��o
    				       # do vetor B
    				       # visto que i inicialmente � zero e ser� iterado, o registrador $t1 ser� atualizado conforme
    				       # cada nova itera��o do loop e passar� a ter valor correspondente a B[i]
    
    
    
   			add $t2, $t0, $s6 # $t2 = &A[i] -----> Endere�o da primeira posi��o do vetor A[i]
   					  # Pois o registrador $s6 cont�m o endere�o base da primeira posi��o do vetor A
   					  # Ent�o basta indexa-lo com i, que foi tratado no registrador $t0
    			lw $t2, 0($t2) # t2 = A[i] ---> Conte�do da primeira posi��o do vetor A[i]
    				       # $t2 cont�m o endere�o da primeira posi��o do vetor A[i]
    				       # mas para se transferir o conte�do da primeira posi��o � necess�rio
    				       # utilizar uma instru��o Load Word para o registrador $t2 com o offset 0, ou seja,
    				       # o deslocamento zero simboliza que est� transferindo o conte�do contido na primeira posi��o
    				       # do vetor A
    				       # visto que i inicialmente � zero e ser� iterado, o registrador $t2 ser� atualizado conforme
    				       # cada nova itera��o do loop e passar� a ter valor correspondente a A[i]
    			add $t2, $t2, $t1 # t2 = A[B[i]]
    					  # Como $t1 possui o conte�do de B[i], basta soma-lo ao pr�prio $t2 (Que cont�m o 
    					  # conte�do de A[i]
    			addi $t2, $t2, -5 # A[B[i]] - 5 + i	
    					  # Como a indexa��o dos vetores com i em seus �ndices � feita em tempo de execu��o,
    					  # basta decrementar o valor atual de $t2 por 5 e isso garante que, a cada nova itera��o
    					  # do loop, a f�rmula proposta na quest�o seja mantida e utilizada com novos valores
    					
    			add $t3, $t0, $s5 # $t3 = &F[i] -----> Endere�o da primeira posi��o do vetor F[i]
    			sw $t2, 0($t3) # O Store Word � necess�rio para transferir o resultado atual de toda a f�rmula (armazenado
    				       # em $t2 para a mem�ria no endere�o de mem�ria atual de F (Influenciado pelo 
    				       # deslocamento e itera��o do loop)
    
    			addi $s1, $s1, 1 # Incrementa i de 1 em 1
    			
    			j for # A instru��o j (Jump) pula para o label for, executando uma nova itera��o do la�o de repeti��o
    			      # , se e somente se, a condi��o de parada ainda n�o foi satisfeita, ou seja, se i ainda � menor que 5
		exit:
		
  			# Termina o programa
  
  			li $v0, 10 # Carrega o servi�o de syscall 10 no registrador $v0, esse servi�o � respons�vel por terminar a
  			           # execu��o do programa
  			syscall # Ativa um determinado servi�o no programa (Por exemplo, entrada e sa�da de dados)
  			        # com base no que foi passado como par�metro para os registradores de retorno $v ...
  			        # e os registradores de argumentos $a ...
