.data
	text: .asciiz "Hello "
	afen: .asciiz "!"
	input: .space 20

.text
.globl main
main:
	li $v0, 8
	la $a0, input
	li $a1, 20
	syscall

	la $t0, input
loop:
	lb $t1, 0($t0)
	beq $t1, 10, remove
	beq $t1, 0, print
	addi $t0, $t0, 1
	j loop
remove:
	sb $zero, 0($t0)

print:
	la $a0, text
	li $v0, 4
	syscall

	la $a0, input
	li $v0, 4
	syscall
	
	la $a0, afen
	li $v0, 4
	syscall

exit:
	li $v0, 10
	syscall