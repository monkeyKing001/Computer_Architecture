.data
inputa: .asciiz "input a: "
inputb: .asciiz "input b: "
inputc: .asciiz "input c: "

.text
main:
	# prompt a
	la $a0, inputa
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
# your code goes here...	

	#############################
	####  arg var assignment ####
	#############################

	# a = $t0	

	# b = $t1
	la $a0, inputb
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

	# c = $t2
	la $a0, inputc
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	
	# $a0 = a
	# $a1 = b
	# $a2 = c
	move $a0, $t0
	move $a1, $t1
	move $a2, $t2

	#############################
	####   sq funtion call   ####
	#############################
	jal squareBMinusAC

	#############################
	####     print result    ####
	#############################
	move $a0, $v0
	li $v0, 1
	syscall

	# exit program
	li $v0, 10
	syscall

squareBMinusAC:
	#############################
	####   squareBMinusAC    ####
	#############################
	# $t3 = b ^2
	# $t4 = ac
	# $t5 = b^2 -  4ac
	mul $t3, $a1, $a1 
	mul $t4, $a0, $a2
	sub $t5, $t3, $t4
	add $v0, $0, $t5

	# return
	jr $ra
