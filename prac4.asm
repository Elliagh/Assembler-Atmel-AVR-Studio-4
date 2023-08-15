.include "m16def.inc"

.def max = r16
.def nulls = r17
.def not_nulls = r18

.org 0x00

.cseg

array_max: .db 1,5,0,9,4,10,7,7,5,3,0
array_nulls: .db 1,0,6,4,0,5,8,0,7,10,0,4

rjmp start

start:

	ldi r28, low(array_nulls*2)
	ldi r29, high(array_nulls*2)
	ldi r30, low(array_max*2)
	ldi r31, high(array_max*2)

main:
	lpm r21, z+
	mov max, r21
	ldi r19, 0x0a
	ldi r20, 0x00
	time1:
		cp r20, r19
		breq time2
		inc r20
		lpm r21, z+
		cp max, r21
		brlo change
		rjmp time1
		change:
			mov max, r21
			rjmp time1

time2:
	clr r20
	ldi r19, 12
	cycle:
		inc r20
		cp r20, r19
		breq end
		lpm r21, z+
		cpi r21, 0x00
		breq plus
		rjmp cycle
		plus:
			inc nulls
			rjmp cycle
end:
	sub r19, nulls
	mov not_nulls, r19
	rjmp main
