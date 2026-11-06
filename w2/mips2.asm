.data
	ia: .asciiz "a = "
	ib: .asciiz "b = "
	g: .asciiz "GCD = "
	l: .asciiz ", LCM = "
	text: .asciiz "Must be positive!"

.text
.globl main
main:
	la $a0, ia
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	la $a0, ib
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s1, $v0

	blez $s0, invalid
	blez $s1, invalid

	move $t0, $s0
	ble $s0, $s1, exit_min
	move $t0, $s1

exit_min:
	bge $s1, $s0, exit_max
	move $s1, $s0

exit_max:
	move $s0, $t0

	move $a0, $s0
	move $a1, $s1
	jal gcd
	move $s2, $v0

	la $a0, g
	li $v0, 4
	syscall

	move $a0, $s2
	li $v0, 1
	syscall

	la $a0, l
	li $v0, 4
	syscall

	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	jal lcm

	move $a0, $v0
	li $v0, 1
	syscall
	j exit

invalid:
	la $a0, text
	li $v0, 4
	syscall

exit:
	li $v0, 10
	syscall

gcd:
	bne $a0, $zero, gcd_recurse
	move $v0, $a1
	jr $ra

gcd_recurse:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	div $a1, $a0
	mfhi $t0
	move $a1, $a0
	move $a0, $t0
	jal gcd

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

lcm:
	div $a0, $a2
	mflo $t0
	mult $t0, $a1
	mflo $v0
	jr $ra
