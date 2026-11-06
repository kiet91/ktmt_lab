.data
	arr: .space 40
	prompt: .asciiz "Please insert a element: "
	text: .asciiz "Second largest value is "
	found: .asciiz ", found in index "
	space: .asciiz ", "

.text
.globl main
main:
	li $s0, 10
	li $t0, 0
	la $s1, arr
	li $s2, -32768
	move $s3, $s2

input_loop:
	beq $t0, $s0, exit_loop

	la $a0, prompt
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t3, $v0

	bge $t3, $s2, check_first

	bge $s3, $t3, store
	move $s3, $t3
	j store

check_first:
	ble $t3, $s2, store

	bge $s3, $s2, set_first
	move $s3, $s2

set_first:
	move $s2, $t3

store:
	sll $t1, $t0, 2
	add $t2, $t1, $s1
	sw $t3, 0($t2)

	addi $t0, $t0, 1
	j input_loop

exit_loop:
	la $a0, text
	li $v0, 4
	syscall

	move $a0, $s3
	li $v0, 1
	syscall

	la $a0, found
	li $v0, 4
	syscall

	li $t0, 0

print_loop:
	beq $t0, $s0, exit

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	lw $t3, 0($t2)
	bne $t3, $s3, next

	move $a0, $t0
	li $v0, 1
	syscall

	la $a0, space
	li $v0, 4
	syscall

next:
	addi $t0, $t0, 1
	j print_loop

exit:
	li $v0, 10
	syscall
