.text
.global main
@ Function that `main` should call
fib:
    @ Fill in the Fibonacci algorithm here
    @ ensure that input arguments and return values
    @ follows the ARM calling convetion, section `6.3.7`
    @ Also note that if you need extra registers it might
    @ be necessary to store previous state on the stack
    bx lr

main:
    @ Always return properly to caller (even from main)
    bx lr

@ The 'data' section contains static data for our program
.data
output_string:
    .asciz "%d\n"