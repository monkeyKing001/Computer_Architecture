.data
equation: .asciiz "x2 + 2b'x + c = 0\n"
inputb: .asciiz "input b': "
inputc: .asciiz "input c: "
imaginary: .asciiz "Imaginary roots!"
nonintegral: .asciiz "Non-integral roots!"

.text
main:
	# print equation
	la $a0, equation
	li $v0, 4
	syscall
	
	# input a = 1
	# $s0 = 1
	
	li $s0, 1
	# print x1
	# $a0 = x1 (b)
	# $s1 = b
	la $a0, inputb
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s1, $v0

	# print x2
	# $a0 = x2 (c)
	# $s2 = c
	la $a0, inputc
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	
	#############################
	####  arg var assignment ####
	#############################
	# $s0 = 1
	# $s1 = b
	# $s2 = c
	# $s3 = b^2 
	# $s4 = ac
	# $s5 = b^2-ac
	mul $s3, $s1, $s1
	mul $s4, $s0, $s2
	sub $s5, $s3, $s4

	#############################
	####  arg var assignment ####
	####     for b^2-ac      ####
	#############################
	move $a0, $s5
	blt $a0, $0, imaginaryException

	#############################
	####  arg var assignment ####
	####      for sqrt       ####
	#############################
	# initialze $t0
	li $t0, 0
	move $a0, $s5

	#############################
	####        sqrt         ####
	#############################
	jal sqrt

	#############################
	####  arg var assignment ####
	####     for getSol      ####
	#############################
	# get solutiont
	# $a0 = b $a1 = root(b^2 - ac)
	move $a0,$s1 
	move $a1, $s6
	jal getSolution

integralCase:
	# $s6 = root(b^2-ac) 
	move $s6, $t0	
	jr $ra

sqrt:
	# if int i > input -> exception (not found)
	# $t1 = $t0 * $t0
	# if $t1 == input -> found! print and exit
	bgt $t0, $a0, nonIntegralException
	mul $t1, $t0, $t0
	beq $t1, $a0, integralCase
	addi $t0, $t0, 1
	j sqrt
	
imaginaryException:
	la $a0, imaginary
	li $v0, 4
	syscall
	j exit

nonIntegralException:
	la $a0, nonintegral
	li $v0, 4
	syscall
	j exit

getSolution:
	# $a0 = b $a1 = root(b^2 - ac)
	neg $t0, $a0
	add $t1, $t0, $a1
	sub $t2, $t0, $a1

	# print 1
	move $a0, $t1
	li $v0, 1
	syscall
	
	# print new line
	li $a0, 10
	li $v0, 11
	syscall

	# print 2
	move $a0, $t2
	li $v0, 1
	syscall
	j exit
	
exit:
	# exit program
	li $v0, 10
	syscall
