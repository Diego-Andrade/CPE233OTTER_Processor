init:	li s0, 0x11000000	# switches 
        li s1, 0x11080000	# leds
    
        li s2, 1		    # led value
    
        li t0, 1000000		# wait counter
    
        la t1, ISR
        csrrw x0, mtvec, t1
    
        li t1, 1
        csrrw x0, mie, t1
    
# wait counter
main:	addi t0, t0, -1
        bnez t0, main
    
        # shift light
        slli s2, s2, 1
        sw s2, (s1)

        # reset
        li t0, 1000000
        j main
    
#done:	j done

ISR:	li t2, 5000000
LOOP:	addi t2, t2, -1
        bnez t2, LOOP
        mret
