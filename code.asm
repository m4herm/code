Q1: Button-Controlled LED Toggle

start:
    cbi ddrb, 1        ; Set PINB.1 as input
    sbi ddrb, 7        ; Set PINB.7 as output
    sbi ddrc, 7        ; Set PINC.7 as output

loop:
    in r16, pinb       ; Read PINB
    sbrs r16, 1        ; Skip if PINB.1 is set
    rjmp led_on        ; Jump to led_on if not set

    sbi portc, 7       ; Turn off LED
    rjmp loop          ; Loop back

led_on:
    cbi portc, 7       ; Turn on LED
    rjmp loop          ; Loop back


Q2: Binary Addition Display

.include "m32def.inc"

start:
    ldi r16, 0x00      ; Set PORTA and PORTB as input
    out ddra, r16
    out ddrb, r16
    ldi r16, 0xFF      ; Set PORTC as output
    out ddrc, r16

loop:
    in r17, pina       ; Read PINA
    in r18, pinb       ; Read PINB
    add r17, r18       ; Add values
    out portc, r17     ; Output result to PORTC
    rjmp loop          ; Repeat loop


Q3: Multi-Level Nested Loops with Counter

.include "m32def.inc"

ldi r17, 0xFF         ; Set PORTC as output
out ddrc, r17
ldi r16, 0x55         ; Initial value for PORTC
out portc, r16

math:
    ldi r20, 5        ; Outer loop counter

math1:
    ldi r21, 200      ; Middle loop counter

math2:
    ldi r22, 250      ; Inner loop counter

delay:
    out portc, r16    ; Output to PORTC
    com r16           ; Complement value in r16
    dec r22           ; Decrement inner counter
    brne math2        ; Repeat inner loop if not zero
    dec r21           ; Decrement middle counter
    brne math1        ; Repeat middle loop if not zero
    dec r20           ; Decrement outer counter
    brne math         ; Repeat outer loop if not zero
ret


Q4: XOR Logic Check and Output

.include "m32def.inc"

LDI R20, 0xFF         ; Set PORTC as output
OUT DDRC, R20 
LDI R20, 0x00         ; Set PORTB as input
OUT DDRB, R20
OUT PORTC, R20        ; Clear PORTC
LDI R21, 5            ; Reference value

HERE: 
    IN R20, PINB      ; Read PINB
    EOR R20, R21      ; Compare with reference using XOR
    BRNE HERE         ; Stay in loop if not equal

    LDI R20, 4        ; Set PORTC to 4
    OUT PORTC, R20

EXIT:
    JMP EXIT          ; Infinite loop


Q5: 7-Segment Display Counter

.include "m32def.inc"

ldi r16, 0xFF         ; Set PORTC as output
out DDRC, r16
ldi r16, 0x00         ; Clear PORTC
out PORTC, r16

main:
    ldi r17, 0        ; Initialize counter

count_loop:
    mov r16, r17      ; Move counter to r16
    out PORTC, r16    ; Output to PORTC
    rcall delay       ; Call delay subroutine
    inc r17           ; Increment counter
    cpi r17, 100      ; Check if counter reaches 100
    brne count_loop   ; Repeat if not
    ldi r17, 0        ; Reset counter
    rjmp count_loop   ; Restart loop


Q6: Alternating Bit Patterns

.include "m32def.inc"

ldi r16, 0xFF         ; Set PORTC as output
out DDRC, r16
ldi r17, 0x55         ; Initial pattern
out PORTC, r17

main:
    com r17           ; Complement pattern
    out PORTC, r17    ; Output to PORTC
    rcall delay       ; Call delay subroutine
    jmp main          ; Repeat

delay:
    ldi r20, 5

delay_outer:
    ldi r21, 200

delay_middle:
    ldi r22, 250

delay_inner:
    nop
    nop
    dec r22
    brne delay_inner
    dec r21
    brne delay_middle
    dec r20
    brne delay_outer
    ret


Q7: Multi-Level Delay with LED Blink

.include "m32def.inc"

ldi r16, 0xFF         ; Set PORTB as output
out DDRB, r16
LDI R16, 0x55         ; Initial value for PORTB
OUT PORTB, R16
LDI R23, 10           ; Outer loop counter

LOP_3:
    LDI R22, 100      ; Middle loop counter

LOP_2:
    LDI R21, 100      ; Inner loop counter

LOP_1:
    COM R16           ; Complement value
    DEC R21           ; Decrement inner counter
    BRNE LOP_1        ; Repeat if not zero
    DEC R22           ; Decrement middle counter
    BRNE LOP_2        ; Repeat if not zero
    DEC R23           ; Decrement outer counter
    BRNE LOP_3        ; Repeat if not zero



Control three LEDs connected to PORTC.5, PORTC.6, and PORTC.7 using three buttons connected to PINB.0, PINB.1, and PINB.2. Each button toggles its corresponding LED.

.include "m32def.inc"

; Initialization
ldi r16, 0xE0         ; Set PORTC.5-7 as output
out DDRC, r16
ldi r16, 0x00         ; Set PORTB.0-2 as input
out DDRB, r16
ldi r16, 0x00         ; Turn off all LEDs initially
out PORTC, r16

main:
    in r16, PINB      ; Read buttons

    ; Check and toggle LEDs
    andi r16, 0x01    ; Button 0
    breq skip_led5
    rcall toggle_led5

skip_led5:
    in r16, PINB
    andi r16, 0x02    ; Button 1
    breq skip_led6
    rcall toggle_led6

skip_led6:
    in r16, PINB
    andi r16, 0x04    ; Button 2
    breq main
    rcall toggle_led7

    rjmp main

toggle_led5:
    ldi r17, 0x20     ; Toggle PORTC.5
    in r18, PORTC
    eor r18, r17
    out PORTC, r18
    ret

toggle_led6:
    ldi r17, 0x40     ; Toggle PORTC.6
    in r18, PORTC
    eor r18, r17
    out PORTC, r18
    ret

toggle_led7:
    ldi r17, 0x80     ; Toggle PORTC.7
    in r18, PORTC
    eor r18, r17
    out PORTC, r18
    ret



slaw,bas awany ka tegaishtina tamsha bkan ,awanidi har kuaktan labar krdia tawawa ba letan tek nachi ,bas aw caisana ba (ror,rol )zor asan 7all abn "
ldi r16,0b11111000
out ddrb,r16

ldi r16,0b11100000
out ddrc,r16

start:

in r17,pinb
rol r17
rol r17
rol r17
rol r17
rol r17

out portc,r17

jmp start
"
