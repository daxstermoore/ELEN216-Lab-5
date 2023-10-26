;************Lab5 Input Output Programming*****
;*********************Program Description *****
;This program provides a template for Input Output programs
;two input output ports are being programmed to read Switches and drive LEDs
;DE explorer board is equiped with four switches: 
	  ;SW3 RD6
	  ;SW4 RD13
	  ;SW5 RA7
	  ;SW6 RD7
;Eight LEDs:
	  ;LED3 RA0
	  ;LED4 RA1
	  ;LED5 RA2
	  ;LED6 RA3
	  ;LED7 RA4
	  ;LED8 RA5
	  ;LED9 RA6
	  ;LED10 RA7
;*** Program Hierarchy ** Mainline plus Subs*******************
; Mainline
;	Init
;	Sub1
;	Sub2
;loop   bra loop	  
;*** Assembler and printing  Directives *******************
.include "p24FJ1024GB610.inc" 
	  ; Data section in data memory
    .bss    ;Uninitialized data section 
    DEL1:	.space 2 ; DEL1 is a two-byte variable at address 800h
    DEL2:	.space 2 ; DEL2 is a two-byte variable at address 802h
    k:		.space 2 ; k is a two-byte variable at address 804h
	   ; Code Section in program memory
    .text   ;Start of Code section
    .global __reset	;declare __reset label as global
__reset:   ;__reset is where the first instruction is located.

;********** Mainline Program ************
	call Init
	call switch
	;call Ex1    ;TODO: uncomment this line to run EX1
	;call Ex2    ;TODO: uncomment this line to run EX2
	;call Ex3    ;TODO: uncomment this line to run EX3
	;call Ex4    ;TODO: uncomment this line to run EX4
again:
 	bra	again ;trap	
Init:
	    ; LEDs on the Explorer board are connected to PORTA PINs
	    ;these statments configure PORTA to drive the LEDs
	clr	TRISA	;Sets PORTA as output (DRIVE Common Anode LEDs)
	clr	PORTA	;Sets PORTA outputs to all zeros (switch off LEDs)
	clr	ANSA	;set porta as digital I/O
	clr	ODCA    ;set PORTA pins as normal digital I/O (not open drain)
	; Switches on the Explorer board are connected to PORTD PINs
	;these statments configure PORTD to drive the Switches
setm	TRISD	;Sets PORTD as intputs (DRIVE switches)
	clr	ANSD	;set portd as digital I/O
	clr	ODCD    ;set PORTD pins as normal digital I/O (not open drain)
	RETURN			;Go to the return address that was saved with the call instruction
switch:   
	BSET	TRISD,#13  ; Set Portd D PIN 13 as Input PIN	
LOOP:	BTSS	PORTD,#13  ;Test if Switch S4		
	GOTO	SW_ON		
SW_OFF:	BCLR	PORTA,#7   ;Turn off LED 10  	 
	GOTO	LOOP
SW_ON:	BSET	PORTA,#7    ;Turn on LED 10 	
	GOTO	LOOP
	return
