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

.INCLUDE "P24FJ1024GB610.INC" 
	  							; Data section in data memory
    	.BSS    				; Uninitialized data section 
    	DEL1:	.SPACE 2 		; DEL1 is a two-byte variable at address 800h
    	DEL2:	.SPACE 2 		; DEL2 is a two-byte variable at address 802h
    	K:		.SPACE 2 		; k is a two-byte variable at address 804h
	   							; Code Section in program memory
    	.TEXT   				; Start of Code section
    	.GLOBAL	 __reset		; Declare __reset label as global

__reset:   						; __reset is where the first instruction is located.

;********** Mainline Program ************
		CALL 	INIT
		CALL 	SWITCH
		;CALL 	EX1    			; TODO: uncomment this line to run EX1
		;CALL 	EX2    			; TODO: uncomment this line to run EX2
		;CALL 	EX3    			; TODO: uncomment this line to run EX3
		;CALL 	EX4    			; TODO: uncomment this line to run EX4

AGAIN:
 		BRA 	AGAIN 			; Traps program	

INIT:
	    						; LEDs on the Explorer board are connected to PORTA PINs
	    						; These statments configure PORTA to drive the LEDs
		CLR		TRISA			; Set PORTA as output (DRIVE Common Anode LEDs)
		CLR		PORTA			; Set PORTA outputs to all zeros (switch off LEDs)
		CLR		ANSA			; Set PORTA as digital I/O
		CLR		ODCA    		; Set PORTA pins as normal digital I/O (not open drain)
								; Switches on the Explorer board are connected to PORTD PINs
								; These statments configure PORTD to drive the Switches
		SETM 	TRISD			; Set PORTD as intputs (DRIVE switches)
		CLR		ANSD			; Set PORTD as digital I/O
		CLR		ODC    			; Set PORTD pins as normal digital I/O (not open drain)
		RETURN					; Go to the return address that was saved with the call instruction

SWITCH:   
		BSET	TRISD, #13  	; Set PORTD PIN 13 as an Input PIN	
		BSET	TRISD, #7		; Set PORTD PIN 7 as an input PIN
		BSET	TRISD, #6		; Set PORTD PIN 6 as an input PIN

LOOP:
		BTSS	PORTD, #13  	; Test if switch S4	is off	
		GOTO	SW_ON		


SW_OFF:	
		BCLR	PORTA, #7   	; Turn off LED 10  	 
		GOTO	LOOP


SW_ON:
		BSET	PORTA, #7    	; Turn on LED 10 	
		GOTO	LOOP
		RETURN
