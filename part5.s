@ The two numbers we want to add
num1:   .word   0x3f800000
num2:   .word   0x3f800000

.text
.global main

@ Main routine
@ - for now, we'll concern ourselves
@   with ABI-level correctness
@ - for simplicity, the adder routine will
@   NOT account for negative numbers
main:
    @ Push registers, as we may have to use
    @ more than what the ABI allows
    push {lr}
    push {r4-r12}

    @ Load numbers
    ldr r0, num1
    ldr r1, num2
main.addf:
    @ Disable the sign bit, so that the
    @ numbers can be naively sorted by
    @ their exponents
    ubfx r0, r0, #0, #31
    ubfx r1, r1, #0, #31

    @ Sort the numbers, so that r0 > r1
    cmp r0, r1

    @ - swap only if r0 < r1
    movlt r2, r0
    movlt r0, r1
    movlt r1, r2

    @ Obtain r0.dec and r1.dec (23 bits long),
    @ then set r0 and r1 to their exponents
    ubfx r2, r0, #0, #23        @ r0.dec (ACC.)
    ubfx r3, r1, #0, #23        @ r1.dec

    ubfx r0, r0, #23, #8        @ r0.exp (KEEP / MODIFY)
    ubfx r1, r1, #23, #8        @ r1.exp

    @ Calculate the difference between
    @ r0.exp and r1.exp, and store that
    @ difference in r1
    sub r1, r0, r1              @ r1 = r0.exp - r1.exp

    @ Set the implied MSB (bit mask 0x80_0000)
    orr r2, r2, #0x800000
    orr r3, r3, #0x800000

    @ Then shift r1.dec to the right
    @ by the difference (in r1)
    lsr r3, r3, r1

    @ Add r0.dec and the adjusted r1.dec
    add r2, r2, r3              @ r2 = r0.dec + r1.adj_dec

    @ Obtain the carry bit (bit mask 0x100_0000)
    ubfx r1, r2, #24, #1        @ r1 is scratch at this point

    @ Use that carry bit to normalize r2
    @ and increment r0 = r0.exp
    lsr r2, r2, r1              @ r2 = r2 >> r1
    add r0, r0, r1              @ r0 = r0 + r1
    cmp r0, #0xff               @ cap r0 to 255 (+inf)
    movgt r0, #0xff             @ (here)

    @ Unset the implied MSB (bit mask 0x7F_FFFF),
    @ then make r0 = (r0 << 22) | r2
    ubfx r2, r2, #0, #23
    orr r0, r2, r0, lsl #23
main.exit:
    @ Restore registers
    pop {r4-r12}
    pop {lr}

    @ Return to caller
    bx lr
