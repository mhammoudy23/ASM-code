TITLE Assignment 3
; Mike Hammoud
; March 18 2018

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data

N DWORD 5
Vector DWORD 15,94,103,54,89
Input SDWORD ?
Count DWORD 0

S BYTE " ", 0
Line BYTE 0Dh, 0Ah, 0

msg1 BYTE "What would you like to do now?: ", 0
msg2 BYTE "What is the size N of Vector?: ", 0
msg3 BYTE "What are the values in Vector?: ", 0
msg4 BYTE "Size of Vector is N = ", 0
msg5 BYTE "Vector = ", 0
msg6 BYTE "Stack is empty!", 0Dh, 0Ah, 0
msg7 BYTE "Stack = ", 0
msg8 BYTE "before ArrayToStack:", 0Dh, 0Ah, 0
msg9 BYTE "after ArrayToStack:", 0Dh, 0Ah, 0
msg10 BYTE "Stack not empty!", 0Dh, 0Ah, 0
msg11 BYTE "before StackToArray:",0Dh, 0Ah, 0
msg12 BYTE "after StackToArray:", 0Dh, 0Ah, 0
msg13 BYTE "before StackReverse:", 0Dh, 0Ah, 0
msg14 BYTE "after StackReverse:", 0Dh, 0Ah, 0
msg15 BYTE "Error - Stack is empty: Cannot perform StackToArray", 0Dh, 0Ah, 0
msg16 BYTE "I am exiting… Thank you Honey… and Get lost…", 0Dh, 0Ah, 0


.code
main PROC
	whileloop1:


		MOV edx, OFFSET msg1
		CALL WriteString
		CALL ReadInt
		MOV Input, eax
		

		CMP Input, 0
			JNZ ELif1

			MOV edx, OFFSET Line
			CALL WriteString
			MOV edx, OFFSET msg2
			CALL WriteString

			CALL ReadDec
			MOV N, eax

			MOV edx, OFFSET msg3
			CALL WriteString

			MOV ecx, N
			MOV ebx, 0
			L7:
				CALL ReadInt
				MOV [Vector + ebx], eax
				ADD ebx, 4
				loop L7

			MOV edx, OFFSET Line
			CALL WriteString
			MOV edx, OFFSET msg4
			CALL WriteString
			MOV eax, N
			CALL WriteDec
			MOV edx, OFFSET Line
			CALL WriteString
			MOV edx, OFFSET msg5
			CALL WriteString

			CALL PRTVector

			MOV edx, OFFSET Line
			CALL WriteString

			CMP Count, 0
				JZ ELif2
				MOV edx, OFFSET msg10
				CALL WriteString

			jmp Endif2
			ELif2:
				MOV edx, OFFSET msg6
				CALL WriteString
			Endif2:

			MOV edx, OFFSET Line
			CALL WriteString

		JMP whileloop1
		ELif1:
		CMP Input, 1
			JNZ ELif3

			MOV edx, OFFSET Line
			CALL WriteString
			MOV edx, OFFSET msg5
			CALL WriteString

			CALL PRTVector

			MOV edx, OFFSET msg8
			CALL WriteString

			MOV ebx, N
			MOV esi, OFFSET Vector
			CALL ArrayToStack

			MOV edx, OFFSET msg7
			CALL WriteString

			CALL PRTStack

			MOV edx, OFFSET msg9
			CALL WriteString
			MOV edx, OFFSET msg10
			CALL WriteString
			MOV eax, Count
			ADD eax, 1
			MOV Count, eax

			MOV edx, OFFSET Line
			CALL WriteString

		JMP whileloop1
		ELif3:
		CMP Input, 2
			JNZ ELif4

			MOV edx, OFFSET Line
			CALL WriteString

			CMP Count, 0
				JZ ELif5

				MOV edx, OFFSET msg7
				CALL WriteString

				CALL PRTStack

				MOV edx, OFFSET msg11
				CALL WriteString

				MOV ebx, N
				MOV esi, OFFSET Vector
				CALL StackToArray

				MOV edx, OFFSET msg5
				CALL WriteString

				CALL PRTVector

				MOV edx, OFFSET msg12
				CALL WriteString

				MOV eax, Count
				SUB eax, 1
				MOV Count, eax

				CMP Count, 0
					JZ ELif6
					MOV edx, OFFSET msg10
					CALL WriteString

				jmp Endif3
				ELif6:
					MOV edx, OFFSET msg6
					CALL WriteString
				Endif3:


			JMP Endif4
			ELif5:
				MOV edx, OFFSET msg15
				CALL WriteString
			
			Endif4:

			MOV edx, OFFSET Line
			CALL WriteString

		JMP whileloop1
		ELif4:
			CMP Input, 3
			JNZ Endif5

			MOV edx, OFFSET Line
			CALL WriteString

			MOV edx, OFFSET msg5
			CALL WriteString

			CALL PRTVector

			MOV edx, OFFSET msg13
			CALL WriteString

			CALL StackReverse

			MOV edx, OFFSET msg5
			CALL WriteString

			CALL PRTVector

			MOV edx, OFFSET msg14
			CALL WriteString

			CMP Count, 0
				JZ ELif7
				MOV edx, OFFSET msg10
				CALL WriteString

			jmp Endif6
			ELif7:
				MOV edx, OFFSET msg6
				CALL WriteString
			Endif6:

			MOV edx, OFFSET Line
			CALL WriteString

		JMP whileloop1
	Endif5:

	MOV edx, OFFSET Line
	CALL WriteString
	MOV edx, OFFSET msg16
	CALL WriteString
	CALL ReadChar

	INVOKE ExitProcess,0
main ENDP



ArrayToStack PROC
	MOV ecx, ebx
	POP eax

	L1:
		PUSH [esi]
		ADD esi, 4
		loop L1
	
	PUSH eax
	RET
ArrayToStack ENDP


StackToArray PROC
	MOV ecx, ebx
	POP eax

	L4:
		POP ebx
		MOV [esi + 4*ecx - 4], ebx
		loop L4

	PUSH eax
	RET
StackToArray ENDP


StackReverse PROC
	MOV ecx, N
	MOV esi, OFFSET Vector
	POP eax

	L5:
		PUSH [esi]
		ADD esi, 4
		loop L5

	MOV ecx, N
	MOV esi, OFFSET Vector

	L6:
		POP ebx
		MOV [esi], ebx
		ADD esi, 4
		loop L6
	
	PUSH eax
	RET
StackReverse ENDP		


PRTStack PROC
	MOV ebx, esp
	MOV ecx, N
	MOV edx, OFFSET S
	
	L2:
		ADD EBX, 4
		MOV eax, [ebx]
		CALL WriteDec
		CALL WriteString
		loop L2

	RET
PRTStack ENDP


PRTVector PROC
	MOV edx, OFFSET S
	MOV ecx, N
	MOV esi, OFFSET Vector

	L3:
		MOV eax, [esi]
		CALL WriteDec
		CALL WriteString
		ADD esi, 4
		loop L3

	RET
PRTVector ENDP

END main