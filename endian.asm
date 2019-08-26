bTITLE Assignment 1 Question 2
;March 6 2018

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data
	bigEndian BYTE 12h, 34h, 56h, 78h
	littleEndian DWORD ?

.code
main PROC
	mov al, [BigEndian+3]
	mov [BigEndian+4], al

	mov al, [BigEndian+2]
	mov [BigEndian+5], al

	mov al, [BigEndian+1]
	mov [bigEndian+6], al

	mov al, [BigEndian]
	mov [BigEndian+7], al

	mov eax, littleEndian
	call WriteHex
	call crlf

	mov al, [BigEndian+3]
	mov [BigEndian+7], al

	mov al, [BigEndian+2]
	mov [BigEndian+6], al

	mov al, [BigEndian+1]
	mov [bigEndian+5], al

	mov al, [BigEndian]
	mov [BigEndian+4], al

	mov eax, littleEndian
	call WriteHex
	call crlf
	

	exit
main ENDP
END main
