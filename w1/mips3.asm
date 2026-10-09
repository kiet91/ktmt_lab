.data
	# F = (a+10)x(b-d)x(c-2a)/((a+b+c)
	f: .asciiz "F= "
	efan: .asciiz ", "
	r: .asciiz "remainder= "
	
	ia: .asciiz "Insert a: "
	ib: .asciiz "Insert b: "
	ic: .asciiz "Insert c: "
	id: .asciiz "Insert d: "

.text
.globl main
main:
	# input
	la $a0, ia
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s0, $v0 #a
	
	la $a0, ib
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s1, $v0 #b
	
	la $a0, ic
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s2, $v0 #c
	
	la $a0, id
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s3, $v0 #d
	# -------------------
	
	#1st calc
	#a + 10
	addi $t0, $s0, 10
	
	#b - d
	sub $t1, $s1, $s3
	
	#multi
	mult $t0, $t1
	mflo $t0
	
	#2a
	sll $t2, $s0, 1
	
	#c - 2a
	sub $t2, $s2, $t2
	
	#multi
	mult $t0, $t2
	mflo $t0
	
	#a+b+c
	add $t1, $s0, $s1
	add $t1, $t1, $s2
	
	#div
	div $t0, $t1
	mflo $t2
	mfhi $t3
	
	#print
	la $a0, f
	li $v0, 4
	syscall
	
	move $a0, $t2
	li $v0, 1
	syscall
	
	la $a0, efan
	li $v0, 4
	syscall
	
	la $a0, r
	li $v0, 4
	syscall
	
	move $a0, $t3
	li $v0, 1
	syscall
	#---------

exit:	
	li $v0, 10
	syscall