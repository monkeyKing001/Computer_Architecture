.data
input: .asciiz "input an integer: "

.text
main:
	# prompt input
	la $a0, input
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	#############################
	####  arg var assignment ####
	#############################
	# $s0 = input
	# $s1 = input / 2
	# $t0 = 1
	move $s0, $t0
	srl $s1, $s0, 1
	li $t0, 0

	#if input is less than zero, branch to exception
	blt $s0, 0, exception

	#input value is valid
	# calculate sqrt
	jal sqrt
	
	# exit program
	li $v0, 10
	syscall

sqrt:
	# if int i > input -> exception (not found)
	# $t1 = $t0 * $t0
	# if $t1 == input -> found! print and exit
	bgt $t0, $s0, exception
	mul $t1, $t0, $t0
	beq $t1, $s0, found  
	addi $t0, $t0, 1
	j sqrt

found: 
	move $a0, $t0
	li $v0, 1
	syscall
	j exit

exception:
	li $a0, -1
	li $v0, 1
	syscall
	j exit

exit:
	li $v0, 10
	syscall
