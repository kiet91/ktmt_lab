.data
	arr: .space 20
	space: .asciiz " "

.text
.globl main
main:
	li $s0, 5
	li $t0, 0
	la $s1, arr

input_loop:
	beq $t0, $s0, exit_loop

	li $v0, 5
	syscall

	move $a0, $v0
	jal check

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	sw $v0, 0($t2)

	addi $t0, $t0, 1
	j input_loop

exit_loop:
	li $t0, 0

print_loop:
	beq $t0, $s0, exit

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	lw $a0, 0($t2)
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

	addi $t0, $t0, 1
	j print_loop

exit:
	li $v0, 10
	syscall

check:
	andi $t3, $a0, 3
	beq $t3, 1, round_down
	beq $t3, 2, round_down
	bne $t3, 3, exit_check

	addi $a0, $a0, 1
	j exit_check

round_down:
	sra $a0, $a0, 2
	sll $a0, $a0, 2

exit_check:
	move $v0, $a0
	jr $ra
