.include "m16def.inc"

.cseg
array:
  .db 1,2,3,4,3,6,2,6,7,3,3,9,1,9,9,1,6

rjmp reset

reset:
  ldi r26, 0x60
  ldi r27, 0x00
  ldi r23, 9
  ldi r24, 17

  ldi r30, low(array*2)
  ldi r31, high(array*2)

main:
  clr r16
  clr r17
  set_zeros:
    st x+, r16
    inc r17
    cp r17, r23
    brlo set_zeros
  clr r17
  counting:
    ldi r26, 0x60
    ldi r27, 0x00
    lpm r0, z+
    dec r0
    add r26, r0
    ld r1, x
    inc r1
    st x, r1

    inc r17
    cp r17, r24
    brlo counting

  rjmp reset
