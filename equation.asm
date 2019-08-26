TITLE Assignment 1 Question 1
;Program that evaluates Z = (A - B) + (C - D)
;Mike Hammoud
;March 6 2018


INCLUDE Irvine32.inc

.data
A SDWORD 10
B SDWORD -210
C1 SDWORD 3210
D SDWORD 43210

str1 BYTE "EDX = (A - B) + (C - D)", 0
space byte "   +   ",0

Z SDWORD ?

.code
main PROC

	mov edx, offset str1	;Write the Str1
	call WriteString
	call crlf ;return
	
	mov eax, A			;Write the values of the variables
	call WriteInt ;writes int
	mov edx, offset space
	call WriteString
	mov eax, B
	call WriteInt
	call WriteString
	mov eax, C1
	call WriteInt
	call WriteString
	mov eax, D
	call WriteInt
	call Crlf

	call Crlf  ;Display an empty line

	mov eax, A ; A-B
	sub eax, B
	mov Z, eax

	mov eax, C1; (A-B) + (C-D)
	sub eax, D
	add Z, eax

	mov eax, Z ;Display the results
	call WriteBinB ;writes output in binary form
	call calf
	call WriteInt ;writes 32 to dec
	call crlf
	call WriteHexB ; writes it to hex
	call crlf

	exit
main ENDP
END main

