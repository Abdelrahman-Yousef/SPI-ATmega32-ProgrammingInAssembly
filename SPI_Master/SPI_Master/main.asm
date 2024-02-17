;
; SPI_Master.asm
;
; Created: 12/6/2023 10:19:59 AM
; Author : Options
;


; Replace with your application code
.ORG 0x00
MAIN:
LDI R16,HIGH(RAMEND)
OUT SPH,R16
LDI R16,LOW(RAMEND)
OUT SPL,R16

CBI DDRC,PC7

LDI R16,0xB0
OUT DDRB,R16
SBI PORTB,PB4

LDI R16,0xFF
OUT DDRA,R16

LDI R16,0x00
OUT SPSR,R16
LDI R16,0x50
OUT SPCR,R16

LDI R18,0xFF

CBI PORTB,PB4

LOOP:
SBIC PINC,PC7
RJMP LOOP
CALL DELAY
SBIC PINC,PC7
RJMP LOOP

INC R18
OUT SPDR,R18
HERE:
IN R16,SPSR
SBRS R16,SPIF
RJMP HERE
IN R17,SPDR
OUT PORTA,R17
RJMP LOOP

.ORG 0x100
DELAY:
LDI R20,0xFF
L1:
LDI R21,0xFF
L2:
DEC R21
BRNE L2
DEC R20
BRNE L1
RET