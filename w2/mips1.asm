.data
	arr:     .space 20
	result:  .asciiz "Result: "
	space:   .asciiz " "

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

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	sw $v0, 0($t2)

	addi $t0, $t0, 1
	j input_loop

exit_loop:
	li $t0, 0

process_loop:
	beq $t0, $s0, print_start

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	lw $t3, 0($t2)

	andi $t4, $t3, 3
	beq $t4, $zero, next

	li $t5, 2
	ble $t4, $t5, round_down

	addi $t3, $t3, 1
	j store

round_down:
	sub $t3, $t3, $t4

store:
	sw $t3, 0($t2)

next:
	addi $t0, $t0, 1
	j process_loop

print_start:
	li $v0, 4
	la $a0, result
	syscall

	li $t0, 0

print_loop:
	beq $t0, $s0, done

	sll $t1, $t0, 2
	add $t2, $t1, $s1
	lw $a0, 0($t2)
	li $v0, 1
	syscall

	li $v0, 4
	la $a0, space
	syscall

	addi $t0, $t0, 1
	j print_loop

done:
	li $v0, 10
	syscall