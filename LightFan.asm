###########################################################
# Written by: Diego Andrade and Brian Padilla
# Date:       March 12, 2020
# Purpose:    To control fan with led strip in order to display images.
#             Wheel is split into 24 segments, with blade of 8 RGB LEDs
#
###########################################################
.data
img1:   .word 0x00FF0000 #LED1 (Portion 1)
        .word 0x00FF0000
        .word 0x00FF0000 #LED3
        .word 0x00FF0000
        .word 0x00FF0000 #LED5
        .word 0x00FF0000
        .word 0x00FF0000 #LED7
        .word 0x00FF0000

        .word 0x00DD2200 #LED1 (Portion 2)
        .word 0x00DD2200
        .word 0x00DD2200 #LED3
        .word 0x00DD2200
        .word 0x00DD2200 #LED5
        .word 0x00DD2200
        .word 0x00DD2200 #LED7
        .word 0x00DD2200

        .word 0x00BB4400 #LED1 (Portion 3)
        .word 0x00BB4400
        .word 0x00BB4400 #LED3
        .word 0x00BB4400
        .word 0x00BB4400 #LED5
        .word 0x00BB4400
        .word 0x00BB4400 #LED7
        .word 0x00BB4400

        .word 0x00996600 #LED1 (Portion 4)
        .word 0x00996600
        .word 0x00996600 #LED3
        .word 0x00996600
        .word 0x00996600 #LED5
        .word 0x00996600
        .word 0x00996600 #LED7
        .word 0x00996600

        .word 0x00778800 #LED1 (Portion 5)
        .word 0x00778800
        .word 0x00778800 #LED3
        .word 0x00778800
        .word 0x00778800 #LED5
        .word 0x00778800
        .word 0x00778800 #LED7
        .word 0x00778800

        .word 0x0055AA00 #LED1 (Portion 6)
        .word 0x0055AA00
        .word 0x0055AA00 #LED3
        .word 0x0055AA00
        .word 0x0055AA00 #LED5
        .word 0x0055AA00
        .word 0x0055AA00 #LED7
        .word 0x0055AA00

        .word 0x0033CC00 #LED1 (Portion 7)
        .word 0x0033CC00
        .word 0x0033CC00 #LED3
        .word 0x0033CC00
        .word 0x0033CC00 #LED5
        .word 0x0033CC00
        .word 0x0033CC00 #LED7
        .word 0x0033CC00

        .word 0x0011EE00 #LED1 (Portion 8)
        .word 0x0011EE00
        .word 0x0011EE00 #LED3
        .word 0x0011EE00
        .word 0x0011EE00 #LED5
        .word 0x0011EE00
        .word 0x0011EE00 #LED7
        .word 0x0011EE00

        .word 0x0000FF00 #LED1 (Portion 9)
        .word 0x0000FF00
        .word 0x0000FF00 #LED3
        .word 0x0000FF00
        .word 0x0000FF00 #LED5
        .word 0x0000FF00
        .word 0x0000FF00 #LED7
        .word 0x0000FF00

        .word 0x0000DD22 #LED1 (Portion 10)
        .word 0x0000DD22
        .word 0x0000DD22 #LED3
        .word 0x0000DD22
        .word 0x0000DD22 #LED5
        .word 0x0000DD22
        .word 0x0000DD22 #LED7
        .word 0x0000DD22

        .word 0x0000BB44 #LED1 (Portion 11)
        .word 0x0000BB44
        .word 0x0000BB44 #LED3
        .word 0x0000BB44
        .word 0x0000BB44 #LED5
        .word 0x0000BB44
        .word 0x0000BB44 #LED7
        .word 0x0000BB44

        .word 0x00009966 #LED1 (Portion 12)
        .word 0x00009966
        .word 0x00009966 #LED3
        .word 0x00009966
        .word 0x00009966 #LED5
        .word 0x00009966
        .word 0x00009966 #LED7
        .word 0x00009966

        .word 0x00007788 #LED1 (Portion 13)
        .word 0x00007788
        .word 0x00007788 #LED3
        .word 0x00007788
        .word 0x00007788 #LED5
        .word 0x00007788
        .word 0x00007788 #LED7
        .word 0x00007788

        .word 0x000055AA #LED1 (Portion 14)
        .word 0x000055AA
        .word 0x000055AA #LED3
        .word 0x000055AA
        .word 0x000055AA #LED5
        .word 0x000055AA
        .word 0x000055AA #LED7
        .word 0x000055AA

        .word 0x000033CC #LED1 (Portion 15)
        .word 0x000033CC
        .word 0x000033CC #LED3
        .word 0x000033CC
        .word 0x000033CC #LED5
        .word 0x000033CC
        .word 0x000033CC #LED7
        .word 0x000033CC

        .word 0x000011EE #LED1 (Portion 16)
        .word 0x000011EE
        .word 0x000011EE #LED3
        .word 0x000011EE
        .word 0x000011EE #LED5
        .word 0x000011EE
        .word 0x000011EE #LED7
        .word 0x000011EE

        .word 0x000000FF #LED1 (Portion 17)
        .word 0x000000FF
        .word 0x000000FF #LED3
        .word 0x000000FF
        .word 0x000000FF #LED5
        .word 0x000000FF
        .word 0x000000FF #LED7
        .word 0x000000FF

        .word 0x002200DD #LED1 (Portion 18)
        .word 0x002200DD
        .word 0x002200DD #LED3
        .word 0x002200DD
        .word 0x002200DD #LED5
        .word 0x002200DD
        .word 0x002200DD #LED7
        .word 0x002200DD

        .word 0x004400BB #LED1 (Portion 19)
        .word 0x004400BB
        .word 0x004400BB #LED3
        .word 0x004400BB
        .word 0x004400BB #LED5
        .word 0x004400BB
        .word 0x004400BB #LED7
        .word 0x004400BB

        .word 0x00660099 #LED1 (Portion 20)
        .word 0x00660099
        .word 0x00660099 #LED3
        .word 0x00660099
        .word 0x00660099 #LED5
        .word 0x00660099
        .word 0x00660099 #LED7
        .word 0x00660099

        .word 0x00880077 #LED1 (Portion 21)
        .word 0x00880077
        .word 0x00880077 #LED3
        .word 0x00880077
        .word 0x00880077 #LED5
        .word 0x00880077
        .word 0x00880077 #LED7
        .word 0x00880077

        .word 0x00AA0055 #LED1 (Portion 22)
        .word 0x00AA0055
        .word 0x00AA0055 #LED3
        .word 0x00AA0055
        .word 0x00AA0055 #LED5
        .word 0x00AA0055
        .word 0x00AA0055 #LED7
        .word 0x00AA0055

        .word 0x00CC0033 #LED1 (Portion 23)
        .word 0x00CC0033
        .word 0x00CC0033 #LED3
        .word 0x00CC0033
        .word 0x00CC0033 #LED5
        .word 0x00CC0033
        .word 0x00CC0033 #LED7
        .word 0x00CC0033

        .word 0x00EE0011 #LED1 (Portion 24)
        .word 0x00EE0011
        .word 0x00EE0011 #LED3
        .word 0x00EE0011
        .word 0x00EE0011 #LED5
        .word 0x00EE0011
        .word 0x00EE0011 #LED7
        .word 0x00EE0011

.text
init:	li s0, 0x11100000	# LEDs base address
	
rnbw:	li s1, 0x00000060	# Segment base address
	li s2, 0x00000120	# Max segments

start:	mv a0, s1  		# Start at first segment
main:	call wrSeg		# Write Segment out. 8 values sent to 8 leds
	
	li t5, 1000000		# Delay
wait:	addi t5, t5, -1
	bnez t5, wait
	blt a0, s2, main	# if (a0 < 192)
	
	j start

# Send out 8 RGB colours for current sengment
# args:   a0 = head of current segment
# return: null, ends a0 at end of segment + 1
wrSeg:	li t0, 0x11300000	# Create stopping condition
	mv t1, s0		# Get address of first LED
	li t4, 0x40000		# Value to next LED 
next:	lw t3, (a0)		# Get value of current segment
	sw t3, (t1)		# Send to current LED
	add t1, t1, t4		# move LED address to next address
	addi a0, a0, 4		# move current value of segment down
	bne t1, t0, next	# if (t1 != 0x11300000) next
	ret			# done writting 8 LEDS







