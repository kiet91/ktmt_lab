.data
	arr: .space 40
	space: .asciiz ", "

.text
.globl main
main:
	li $s0, 10            # n
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
	li $t0, 0             # i = 0
	sub $t1, $s0, 1       # j = n - 1

reverse_loop:
	bge $t0, $t1, exit_reverse_loop   # dừng khi i >= j

	sll $t2, $t0, 2
	add $t2, $t2, $s1     # &arr[i]
	sll $t3, $t1, 2
	add $t3, $t3, $s1     # &arr[j]

	lw $t4, 0($t2)        # tmp1 = arr[i]
	lw $t5, 0($t3)        # tmp2 = arr[j]
	sw $t5, 0($t2)        # arr[i] = tmp2
	sw $t4, 0($t3)        # arr[j] = tmp1

	addi $t0, $t0, 1
	addi $t1, $t1, -1
	j reverse_loop

exit_reverse_loop:
	li $t0, 0

print_loop:
	beq $t0, $s0, exit_print_loop

	sll $t1, $t0, 2
	add $t2, $t1, $s1
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