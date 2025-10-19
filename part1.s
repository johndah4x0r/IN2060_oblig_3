.text
.global main

@ Main function of program
main:
    @ First load the desired Fibonacci number
    mov r0, #13 @ N
    @ Initialize the first two numbers in the sequence
    mov r1, #0  @ current
    mov r2, #1  @ previous

@ Loop will do the main work calculating the Fibonacci sequence
loop:
    @ ! Implement your logic here !
    @ Jump to start off loop
    b loop

@ To be a good citizen we branch (and exchange) on the lr register
@ to return to the caller
exit:
    bx lr