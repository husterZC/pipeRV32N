.text
.globl main
main:
	la ra, array
	li sp, 10
loop:
	lw t0, 0(ra)
	lw t1, 4(ra)
	lw t2, 8(ra)
	add gp, t0, t1
	add gp, gp, t2
	sw gp, 12(ra)
	addi ra, ra, 4
	addi sp, sp, -1
	bgtz sp, loop
L2:
	j	L2
.data
array: .word 1,1,1
tmp:   .word 0,0,0,0,0,0,0,0,0,0 
.ident	"GCC: (GNU MCU Eclipse RISC-V Embedded GCC, 64-bit) 8.2.0"
