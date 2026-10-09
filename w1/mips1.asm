.data
	text: .asciiz "Hello "
	afen: .asciiz "!"
	inputSize: .space 20

.text
.globl main
main:
	li $v0, 8
	la $a0, inputSize
	li $a1, 20
	syscall

	la $a0, text
	li $v0, 4
	syscall

	la $a0, inputSize
	li $v0, 4
	syscall
	
	la $a0, afen
	li $v0, 4
	syscall

	li $v0, 10
	syscall