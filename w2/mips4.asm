.data
	text: .asciiz "A factorial for your number can not be found."

.text
.globl main
main:
	li $v0, 5
	syscall
	move $s0, $v0

	bltz $s0, invalid

	move $a0, $s0
	jal factorial

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

factorial:
	li $v0, 1
	li $t0, 1

for_loop:
	bgt $t0, $a0, exit_for_loop

	mult $v0, $t0
	mflo $v0

	addi $t0, $t0, 1
	j for_loop

exit_for_loop:
	jr $ra
