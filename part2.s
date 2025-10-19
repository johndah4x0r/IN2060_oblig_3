.text
.global main

@ Function that `main` should call
@ Accepts: R0/A1 (index)
@ Returns: R0 (result)
@ Clobbers: R0, R1, R2, R3
fib:
    @ We have
    @ - R0, R1 for arithmetic
    @ - R2 for counting
    @ - R3 for scratch space
    mov r2, a1          @ load R2 with index

    mov r0, #0          @ Initial current value
    mov r1, #1          @ Initial previous value
    @ -- fall-through -- @

fib.top:
    @ Loop will do the main work calculating the Fibonacci sequence
    @ - uses R2 to count the number of iterations
    @ - final result is in R0

    mov r3, r0          @ move current value to temporary register
    add r0, r0, r1      @ R0 = R0 + R1
    mov r1, r3          @ set previous value to old current value
    
    @ Decrement counter and continue if R2 != 0
    subs r2, r2, #1
    bnz fib.top
    @ -- fall-through on exhaustion -- @

    @ Final current value is in R0; return to caller
    bx lr

main:
    @ Pass index to `fib` and call it
    mov a1, #13
    bl fib
    @ (result returned in R0)

    @ TODO: Print to screen

    @ Always return properly to caller (even from main)
    bx lr

@ The 'data' section contains static data for our program
.data
output_string:
    .asciz "%d\n"