@ The two numbers we want to add
num1:   .word   0x3f800000
num2:   .word   0x3f800000

.text
.global main
main:
    @ Load numbers
    ldr r0, num1
    ldr r1, num2

    @ ! Perform addition here !

    @ When done, return
    bx lr