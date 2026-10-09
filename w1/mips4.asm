.data
	prompt: .asciiz "Please enter a positive integer less than 16: "

.text
.globl main
main:
	la $a0, prompt
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	li $t0, 4

print_loop:
	beqz $t0, exit

	srl $t1, $s0, 3
	andi $a0, $t1, 1
	li $v0, 1
	syscall

	sll $s0, $s0, 1
	addi $t0, $t0, -1
	j print_loop

exit:
	li $v0, 10
	syscall