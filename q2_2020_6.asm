# Q2 2020_6

# Aluno: Douglas Mateus Soares Cândido da Silva

#Implementar:

# for(i=0;i<5;i++){
#    F[i] = A[B[i]] - 5 + i;
# }

#resultado esperado F = 9, 5, 1, 23, 69 
 
.data # Área destinada à declaração de variáveis que irão armazenar dados estáticos

	i: .word 0 # Declare i inteiro e igual a zero
	
	# Essas instruções tratam da alocação de endereços, bem como o seu preenchimento com valores, para as posições
	# dos vetores (Arrays)
	F: .word 0, 0, 0, 0, 0	# Declare F inteiro com 5 posições e inicialize todas com 0
	A: .word 14, 9, 4, 25, 70 # Declare A inteiro com 5 posições e inicialize com 14 9 4 25 70
	B: .word 0, 1, 2, 3, 4	# Declare B inteiro com 5 posições e inicialize com 0 1 2 3 4
	
	# O tipo de dado .word foi utilizado porque a arquitetura do MIPS trabalha com instruções com o tamanho de 32 bits 
	# e, portanto, para representar números inteiros a arquitetura dedica 4 Bytes (Sua limitação de representatividade)

.text # Área destinada ao corpo do programa, contendo o procedimento principal (Main) e possíveis outros procedimentos, além de outras instruções.

	.globl main # O .globl é uma diretiva para o assembler (Montador) que permite fazer com que o procedimento Main deste programa
 		    # possa ser chamado a partir de outros programas
 		    # Percebi que isso é um padrão em todos os exemplos e portanto decidi adota-lo
 			
		main: # Label que indica onde a primeira instrução do procedimento principal main irá começar. 
  
  			# Como F, A e B são vetores, eu utilizei a instrução la (Load Adress) para carregar o endereço
  			# equivalente a primeira posição dos vetores específicos nos registradores específicos 
  			la $s5, F
  			la $s6, A
  			la $s7, B
  			
  			lw $s1, i # Como i já foi declarado no .data, eu utilizo o lw (Load Word) para carregar seu valor atual no 
  				  # registrador $s1
  				  # O valor de i, inicialmente, será zero e, a partir daí, o laço de repetição for será iterado
  				  # com a incrementação do valor atual de i
  				  # Todas as operações que estão dentro do laço de repetição passarão a executar com valores atualizados
  				  # até chegar a sua condição de parada, ou seja, quando i for igual a 5
  			
			li $s0, 5 # Utilizei a instrução li (Load Immediate) para carregar no registrador $s0 o valor 5
				  # $s0 atuará como delimitador (Condição de parada) do laço de repetição for
  
  		for: # Esse label indica onde começa o laço de repetição for
    			beq $s1, $s0, exit # Comparação: se o i for igual a 5, vai para 'exit' (encerra o laço de repetição)
    					   # Para realizar essa comparação e preservar o padrão de codificação de um for, 
    					   # utilizei a instrução beq (Branch on equal)
    					   # Essa instrução compara dois valores e, se forem iguais, transfere o fluxo de controle
    					   # do programa para o label designado
    					   # Ou seja, atualiza o valor de pc (Program Counter) que aponta para a próxima instrução
    					   # a ser processada
   
   			sll $t0, $s1, 2 # $t0 = 4 * i
   					# Através da resolução de exemplos e exercícios e, com a ajuda do monitor, notei que
   					# quando se trabalha com vetores na arquitetura MIPS é necessário fazer o processo passo a passo
   					# Entendi o padrão de codificação e notei que o primeiro passo é multiplicar por 4,
   					# através da instrução sll (Shift left logical), a variável que atuará como índice do
   					# vetor, pois na arquitetura MIPS isso é necessário para percorrer a memória
   					# Como o tipo de dados dos vetores é inteiro de 32 bits e a memória opera com bytes, é
   					# necessário multiplicar o índice por 4, pois isso significa dizer que
   					# a posição atual do vetor e suas posições seguintes serão determinadas pelo avanço
   					# ou retrocesso de 4 bytes * o índice atual + o endereço de memória atual correspondente
   					# a posição do vetor especificada pelo determinado índice
   					# O registrador $t0 será utilizado posteriormente para indexação por todos os vetores
   					
   					
   					
   			add $t1, $t0, $s7 # $t1 = &B[i] -----> Endereço da primeira posição do vetor B[i]
   					  # Pois o registrador $s7 contém o endereço base da primeira posição do vetor B
   					  # Então basta indexa-lo com i, que foi tratado no registrador $t0
    			lw $t1, 0($t1) # $t1 = B[i] -> Conteúdo da primeira posição do vetor B[i]
    				       # $t1 contém o endereço da primeira posição do vetor B[i]
    				       # mas para se transferir o conteúdo da primeira posição é necessário
    				       # utilizar uma instrução Load Word para o registrador $t1 com o offset 0, ou seja,
    				       # o deslocamento zero simboliza que está transferindo o conteúdo contido na primeira posição
    				       # do vetor B
    				       # visto que i inicialmente é zero e será iterado, o registrador $t1 será atualizado conforme
    				       # cada nova iteração do loop e passará a ter valor correspondente a B[i]
    
    
    
   			add $t2, $t0, $s6 # $t2 = &A[i] -----> Endereço da primeira posição do vetor A[i]
   					  # Pois o registrador $s6 contém o endereço base da primeira posição do vetor A
   					  # Então basta indexa-lo com i, que foi tratado no registrador $t0
    			lw $t2, 0($t2) # t2 = A[i] ---> Conteúdo da primeira posição do vetor A[i]
    				       # $t2 contém o endereço da primeira posição do vetor A[i]
    				       # mas para se transferir o conteúdo da primeira posição é necessário
    				       # utilizar uma instrução Load Word para o registrador $t2 com o offset 0, ou seja,
    				       # o deslocamento zero simboliza que está transferindo o conteúdo contido na primeira posição
    				       # do vetor A
    				       # visto que i inicialmente é zero e será iterado, o registrador $t2 será atualizado conforme
    				       # cada nova iteração do loop e passará a ter valor correspondente a A[i]
    			add $t2, $t2, $t1 # t2 = A[B[i]]
    					  # Como $t1 possui o conteúdo de B[i], basta soma-lo ao próprio $t2 (Que contém o 
    					  # conteúdo de A[i]
    			addi $t2, $t2, -5 # A[B[i]] - 5 + i	
    					  # Como a indexação dos vetores com i em seus índices é feita em tempo de execução,
    					  # basta decrementar o valor atual de $t2 por 5 e isso garante que, a cada nova iteração
    					  # do loop, a fórmula proposta na questão seja mantida e utilizada com novos valores
    					
    			add $t3, $t0, $s5 # $t3 = &F[i] -----> Endereço da primeira posição do vetor F[i]
    			sw $t2, 0($t3) # O Store Word é necessário para transferir o resultado atual de toda a fórmula (armazenado
    				       # em $t2 para a memória no endereço de memória atual de F (Influenciado pelo 
    				       # deslocamento e iteração do loop)
    
    			addi $s1, $s1, 1 # Incrementa i de 1 em 1
    			
    			j for # A instrução j (Jump) pula para o label for, executando uma nova iteração do laço de repetição
    			      # , se e somente se, a condição de parada ainda não foi satisfeita, ou seja, se i ainda é menor que 5
		exit:
		
  			# Termina o programa
  
  			li $v0, 10 # Carrega o serviço de syscall 10 no registrador $v0, esse serviço é responsável por terminar a
  			           # execução do programa
  			syscall # Ativa um determinado serviço no programa (Por exemplo, entrada e saída de dados)
  			        # com base no que foi passado como parâmetro para os registradores de retorno $v ...
  			        # e os registradores de argumentos $a ...
