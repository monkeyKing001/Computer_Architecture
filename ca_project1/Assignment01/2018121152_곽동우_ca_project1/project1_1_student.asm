.data
string: .asciiz "Welcome to Computer Architecture\n"
string_end:

.text
main:
	# print original string
	li $v0, 4	
	la $a0, string
	syscall
		
	la $a1, string
	la $a2, string_end
	
# your code goes here...

	#############################
	####  arg var assignment ####
	#############################
	addi $s0, $0, 32 			# $s0 is ' ' (ascii 32)
	li $v0, 0 					# $v0 = 0 initialize


	#call wordCount func
	jal wordCount

	# a0 become syscall's argument(wordcount)
	move $a0, $v0

	# print word count
	li $v0, 1
	syscall
	# exit program
	li $v0, 10		
	syscall

wordCount:
	#############################
	###       end_loop        ###
	#############################
	beq $a1, $a2, Exit

	#############################
	###    char assignment    ###
	#############################
	lb $t0, 0($a1)					# char t0 = *str

	#############################
	###       pointer mov     ###
	#############################
	addi $a1, $a1, 1				# str += 1;

	beq $t0, $s0, passThroughWhiteSpace
	addi $v0, $v0, 1
	j passThroughWord

passThroughWord:
	#############################
	###       end_loop        ###
	#############################
	beq $a1, $a2, Exit

	#############################
	###    char assignment    ###
	#############################
	lb $t0, 0($a1)					# char temp = *str
	addi $a1, $a1, 1				# str += 1;
	bne $t0, $s0, passThroughWord
	j	passThroughWhiteSpace

passThroughWhiteSpace:
	#############################
	###       end_loop        ###
	#############################
	beq $a1, $a2, Exit

	#############################
	###    char assignment    ###
	#############################
	lb $t0, 0($a1)					# char temp = *str
	addi $a1, $a1, 1				# str += 1;
	beq $t0, $s0, passThroughWhiteSpace
	addi $v0, $v0, 1
	j	passThroughWord
	
Exit:
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall
