.data
	arr: .space 20
	text: .asciiz "Please input element "
	afen: .asciiz ":"
	prompt: .asciiz "Please enter index: "

.text
.globl main
main:
	li $s0, 0
	li $t0, 5
	la $s1, arr	

for_loop:
	beq $s0, $t0, exit_for_loop

	la $a0, text
	li $v0, 4
	syscall

	move $a0, $s0
	li $v0, 1
	syscall

	la $a0, afen
	li $v0, 4
	syscall

	sll $t1, $s0, 2
	add $t2, $t1, $s1

	li $v0, 5
	syscall
	sw $v0, 0($t2)

	addi $s0, $s0, 1
	j for_loop

exit_for_loop:
	la $a0, prompt
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t0, $v0

	sll $t1, $t0, 2
	add $t2, $t1, $s1

	lw $a0, 0($t2)
	li $v0, 1
	syscall

	li $v0, 10
	syscall