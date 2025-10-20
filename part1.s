.text
.global main

@ Main function of program
main:
    @ First load the desired Fibonacci number
    mov r2, #13 @ N

    @ Initialize the first two numbers in the sequence
    mov r0, #0  @ current
    mov r1, #1  @ previous

@ Loop will do the main work calculating the Fibonacci sequence
@ - uses R2 to count the number of iterations
@ - final result is in R0
main.top:
    mov r3, r0          @ move current value to temporary register
    add r0, r0, r1      @ R0 = R0 + R1
    mov r1, r3          @ set previous value to old current value
    
    @ Decrement counter and continue if R2 != 0
    subs r2, r2, #1
    bne main.top
    @ -- fall-through on exhaustion -- @

@ To be a good citizen we branch (and exchange) on the lr register
@ to return to the caller
exit:
    bx lr
