.data
helloworld: .asciiz "input a: "

.text
main:
	la $a0, helloworld
	li $v0, 4
	syscall

#exit
	li $v0, 10
	syscall
