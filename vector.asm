TITLE Assignment 2 Question 1
;Mike Hammoud
;March 19 2018

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data
Vector SDWORD 50 DUP(?)
N DWORD ?
I DWORD ?
J DWORD ?
min SDWORD 7FFFFFFFh
X DWORD ?
Y DWORD ?

newLine BYTE 0Dh,0Ah,0
space BYTE " ",0

msg1 BYTE "What is the size N of Vector?: ",0
msg2 BYTE "Enter the ",0
msg3 BYTE " values of Vector:" ",0
msg4 BYTE "Size of Vector is N = ",0
msg5 BYTE "Vector =",0
msg6 BYTE "The sum of all the negative values in Vector is: Sum = ",0
msg7 BYTE "The sum of all the positive values in Vector is: Sum = ",0
msg8 BYTE "Please give me two values I and J such that 1 <= I <= J <= N : ",0
msg9 BYTE "I = ",0
msg10 BYTE " and J = ",0
msg11 BYTE "The minimum value between position I & J is : ",0
msg12 BYTE "Invalid I or J:", 0Dh, 0Ah, 0
msg13 BYTE "Invalid N:", 0Dh, 0Ah, 0
msg14 BYTE "Vector is a palindrome:",0
msg15 BYTE "Vector is not a palindrome:", 0
msg16 BYTE "Do you want to do restart?: ", 0



.code
main PROC
	restart:
	rest1:
	MOV edx, OFFSET msg1
	CALL WriteString

	CALL ReadInt
	MOV N, eax
	cmp eax, 1
	js badInp1
	jmp goodInp1
	badInp1:
		MOV edx, OFFSET msg13
		CALL WriteString
		jmp rest1
	goodInp1:

	MOV edx, OFFSET msg2
	CALL WriteString
	MOV eax, N
	CALL WriteDec
	MOV edx, OFFSET msg3
	CALL WriteString

	MOV ecx, N
	MOV ebx, 0

	L1:
		CALL ReadInt
		MOV [Vector + ebx], eax
		ADD ebx, 4
		loop L1
	

	MOV edx, OFFSET newLine
	CALL WriteString

	MOV edx, OFFSET msg4
	CALL WriteString

	MOV eax, N
	CALL WriteDec

	MOV edx, OFFSET newLine
	CALL WriteString

	MOV edx, OFFSET msg5
	CALL WriteString

	MOV ecx, N
	MOV ebx, 0

	L2:
		MOV edx, OFFSET space
		CALL WriteString

		MOV eax, [Vector + ebx]
		CALL WriteInt

		ADD ebx, 4
		loop L2

	MOV edx, OFFSET newLine
	CALL WriteString
	CALL WriteString

	MOV ecx, N	; Loop variable
	MOV ebx, 0	; Iteration counter
	MOV eax, 0	; Negative number counter
	MOV edx, 0	; Postive number counter

	L3:
		cmp [Vector + ebx], 0
		jns pos
		ADD eax, [Vector + ebx]
		jmp fi
		pos:
			ADD edx, [Vector + ebx]
		fi:
		
		ADD ebx, 4
		loop L3

	MOV ebx, edx

	MOV edx, OFFSET msg6
	CALL WriteString
	CALL WriteInt

	MOV edx, OFFSET newLine
	CALL WriteString

	MOV edx, OFFSET msg7
	CALL WriteString
	MOV eax, ebx
	CALL WriteInt

	MOV edx, OFFSET newLine
	CALL WriteString

	rest2:
	MOV edx, OFFSET newLine
	CALL WriteString

	MOV edx, OFFSET msg8
	CALL WriteString

	CALL ReadDec
	MOV I, eax
	
	CALL ReadDec
	MOV J, eax

	MOV eax, J
	cmp eax, I
	js badInp2
	cmp J, 1
	js badInp2
	cmp I, 1
	js badInp2

	MOV eax, N
	cmp eax, I
	js badInp2
	cmp eax, J
	js badInp2

	jmp goodInp2
	badInp2:
		MOV edx, OFFSET msg12
		CALL WriteString
		jmp rest2
	goodInp2:

	MOV edx, OFFSET newLine
	CALL WriteString

	MOV edx, OFFSET msg9
	CALL WriteString

	MOV eax, I
	CALL WriteDec

	MOV edx, OFFSET msg10
	CALL WriteString

	MOV eax, J
	CALL WriteDec

	MOV edx, OFFSET newLine
	CALL WriteString

	MOV edx, OFFSET msg11
	CALL WriteString

	MOV ecx, J
	SUB ecx, I
	ADD ecx, 1

	L4:
		MOV ebx, I
		ADD ebx, ecx
		MOV eax, [Vector + 4*ebx - 8]
		cmp eax, min
		jns nextVal
		MOV min, eax
		nextVal:
		loop L4

	MOV eax, min
	CALL WriteInt

	MOV edx, OFFSET newLine
	CALL WriteString
	CALL WriteString

	MOV X, 0
	MOV eax, N
	SUB eax, 1
	MOV Y, eax

	palWhile:
		MOV ebx, X
		MOV ecx, Y
		MOV eax, [Vector + 4*ecx]
		cmp eax, [Vector + 4*ebx]
		jnz notPal
		MOV eax, X
		ADD eax, 1
		MOV X, eax
		MOV eax, Y
		SUB eax, 1
		MOV Y, eax
		cmp eax, X
		js isPal
		jmp palWhile

	notPal:
		MOV edx, OFFSET msg15
		CALL WriteString
		jmp endPal
	isPal:
		MOV edx, OFFSET msg14
		CALL WriteString
	endPal:

	MOV edx, OFFSET newLine
	CALL WriteString
	CALL WriteString
	MOV edx, OFFSET msg16
	CALL WriteString

	CALL ReadChar
	CALL WriteChar

	MOV edx, OFFSET newLine
	CALL WriteString

	cmp al, "y"
	jz restart

	INVOKE ExitProcess,0
main ENDP
END main