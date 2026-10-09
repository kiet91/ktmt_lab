.data
	arr: .space 40
	rArr: .space 40
	space: .asciiz ", "
	
.text
.globl main
main:
	li $s0, 10
	li $t0, 0
	la $s1, arr
	la $s2, rArr

input_loop:
	beq $t0, $s0, exit_loop

	li $v0, 5
	syscall

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	sw $v0, 0($t2)

	addi $t0, $t0, 1
	j input_loop

exit_loop:
	li $t0, 0

reverse_loop:
	beq $t0, $s0, exit_reverse_loop

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	lw $t3, 0($t2)

	sub $t4, $s0, 1
	sub $t4, $t4, $t0
	sll $t4, $t4, 2
	add $t5, $t4, $s2
	sw $t3, 0($t5)

	addi $t0, $t0, 1
	j reverse_loop

exit_reverse_loop:
	li $t0, 0

print_loop:
	beq $t0, $s0, exit_print_loop

	sll $t1, $t0, 2
	add $t2, $t1, $s2
	lw $a0, 0($t2)
	li $v0, 1
	syscall
	
	addi $t0, $t0, 1

	beq $t0, $s0, skip_comma

	la $a0, space
	li $v0, 4
	syscall

skip_comma:
	j print_loop

exit_print_loop:

exit:
	li $v0, 10
	syscall