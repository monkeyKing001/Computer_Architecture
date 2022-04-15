	.text
	.globl main

main:			                 # $t0 : i , $t1 : temp, $t2 : ans , $t7 : 1(0,1팩토리얼을 위한 값)

	li $t7,1	                 # $t7에 1대입
	li $t2,1	                 # $t2에 1대입


	li $v0,5 	                 # scanf 준비
	syscall
	move $t0,$v0	           # $v0값을 $t0로 저장 

	beq $t0,0,return0            # 0이면 return0으로

	jal return1	                # 그게 아니면 return1로

	li $v0,1	                 # print준비
	move $a0,$t2	           # $t7(1)값을 $a0로 저장
	syscall	


	li $v0,10
	syscall

return0:		                 # 1일때 결과 출력하는곳


	li $v0,1	               # print준비
	move $a0,$t7	         # $t7(1)값을 $a0로 저장
	syscall
	

return1:


	beq $t0,1,return0           # 1이면 return0으로


	                             # 아래 코드는 2이상만 취급
	mul $t2,$t2,$t0	          # $t2에 $t2*$t0을 한것을 넣는다.
	sub $t0,$t0,1	          # $t0 = $t0 - 1
	bne $t0,1,return1           # 여기서 $t0가 1이 아니면 return1로

	jr $ra



