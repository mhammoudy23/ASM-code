TITLE Assignment 4
;Mike Hammoud
;March 18 2018


INCLUDE Irvine32.inc
	                 
.data
	Line BYTE 0ah, 0

	A BYTE 'A', 0
	B BYTE 'B', 0
	C BYTE 'C', 0
	D BYTE 'D', 0
	E BYTE 'E', 0
	F BYTE 'F', 0

	choice  BYTE "What do you want to do?", 0ah, 0
	msg1 BYTE "h", 0ah, 0
	msg2 BYTE "Get Lost Sweetey Honey Bun", 0ah, 0
	msg3 BYTE "Thank you Sweetey Honey Bun", 0ah, 0
	msg4 BYTE "Please enter a decimal number: ", 0
	msg5 BYTE "Please enter a hexadecimal number: ", 0

.code
main PROC

    mov EDX, OFFSET choice
    call writeString
    mov EDX, OFFSET Line

    call readChar
    call writeChar				
    call writeString

	cmp AL, 'W'
    je optB
    cmp AL, 'w'
    je optB

    cmp AL, 'R'
    je optA
    cmp AL, 'r'
    je optA
 

    mov EDX, OFFSET msg2
    call writeString
    jmp quit

    optA:
    	call HexInput

    optB:
    	mov EDX, OFFSET msg4
	    call writeString
	    mov EDX, OFFSET Line

	    call readDec

	    mov EBX, EAX
	    mov EAX, 0ah
	    
    	call HexOutput

    quit:
    	exit
main ENDP


HexOutput PROC
	mov ECX, 8

	hexDec:
		rol EBX, 4
		mov DL, BL
		and DL, 0Fh

		mov AL, DL 
		
		cmp AL, 10
		jnb hexWrite
		call writeDec
		jmp lend

		hexWrite:
			cmp AL, 10
			jne L1
			mov EDX, OFFSET A
			call writeString
			jmp lend

		L1:
			cmp AL, 11
			jne L2
			mov EDX, OFFSET B
			call writeString
			jmp lend

		L2:
			cmp AL, 12
			jne L3
			mov EDX, OFFSET C
			call writeString
			jmp lend

		L3:
			cmp AL, 13
			jne L4
			mov EDX, OFFSET D
			call writeString
			jmp lend

		L4:
			cmp AL, 14
			jne L5
			mov EDX, OFFSET E
			call writeString
			jmp lend

		L5:
			cmp AL, 15
			jne lend
			mov EDX, OFFSET F
			call writeString

		lend:
			loop hexDec

	mov EDX, OFFSET Line
	call writeString
	mov EDX, OFFSET msg3
	call writeString

	exit
HexOutput ENDP

HexInput PROC
	xor EBX, EBX

	mov EDX, OFFSET msg5
	call writeString

	hexIn:
		call readChar
        call writeChar
        cmp AL, 'h'
        je hexEnd

        hexNext:

        	cmp AL, '0'
        	jne L1
        	mov AL, 0
        	jmp hexLoop

        L1:
        	cmp AL, '1'
        	jne L2
        	mov AL, 1
        	jmp hexLoop

        L2:
        	cmp AL, '2'
        	jne L3
        	mov AL, 2
        	jmp hexLoop

        L3:
        	cmp AL, '3'
        	jne L4
        	mov AL, 3
        	jmp hexLoop

        L4:
        	cmp AL, '4'
        	jne L5
        	mov AL, 4
        	jmp hexLoop

        L5:
        	cmp AL, '5'
        	jne L6
        	mov AL, 5
        	jmp hexLoop

        L6:
        	cmp AL, '6'
        	jne L7
        	mov AL, 6
        	jmp hexLoop

        L7:
        	cmp AL, '7'
        	jne L8
        	mov AL, 7
        	jmp hexLoop

        L8:
        	cmp AL, '8'
        	jne L9
        	mov AL, 8
        	jmp hexLoop

        L9:
        	cmp AL, '9'
        	jne LA
        	mov AL, 9
        	jmp hexLoop

        LA:
        	cmp AL, 'A'
        	jne LB
        	mov AL, 10
        	jmp hexLoop

        LB:
        	cmp AL, 'B'
        	jne LC
        	mov AL, 11
        	jmp hexLoop

        LC:
        	cmp AL, 'C'
        	jne LD
        	mov AL, 12
        	jmp hexLoop

        LD:
        	cmp AL, 'D'
        	jne L14
        	mov AL, 13
        	jmp hexLoop

        L14:
        	cmp AL, 'E'
        	jne LF
        	mov AL, 14
        	jmp hexLoop

        LF:
        	cmp AL, 'F'
        	jne hexLoop
        	mov AL, 15

        hexLoop:
        shl EBX, 4
        add BL, AL
        jmp hexIn


    hexEnd:
    	mov EDX, OFFSET Line
		call writeString

		mov EAX, EBX
		call writeBin
		call writeString
		mov EDX, OFFSET msg3
		call writeString

	exit
HexInput ENDP
END main  
