; Global BIOS Print Functions
; Made by Kaiden Bird
; Created: 18/06/2023
; Last updated: 25/06/2023
; Changelog: Added Hex printing, added macros for printing, refactored code.

; Macro to print a string, then print a new line.
%macro printsLn 1 
	mov bx, %1
	call printsf
	mov bx, newLine
	call printsf
%endmacro

; Alternative, no new line.
%macro prints 1 
	mov bx, %1
	call printsf
	;mov bx, 0x0a
	;call printsf
%endmacro

; Macro to print a hex number, then print a new line.
%macro printhLn 1
	mov cx, %1
	call printhf
%endmacro

; Alternative, no new line.
%macro printh 1 
	mov cx, %1
	call printhf
	mov bx, 0x0a
	call printsf
%endmacro

; Let's create a function that can print a string.
printsf:
	pusha ; Push all registers onto the stack
contPrintsf:
	mov al, [bx] ; Move primitive bx into al
	cmp al, 0 ; Is al == 0?
	je endPrintf ; If al == 0, jump to endPrint. Basically a "while (true)" loop with a break.
	int 0x10 ; Print the character in al
	inc bx ; Move 1 byte, next character
	jmp contPrintsf ; Recursive call to print.

; Now let's create a function that can print a hex number.
printhf:
	pusha
	mov bx, hexPrefix ; Print the hex prefix
	call printsf
	mov ax, cx ; Move cx into ax
	and ax, 0xF000 ; Select byte 3
	shr ax, 12 ; Shift right by 12 (byte 3 now in position 0x000F)
	call bytePrintf
	mov ax, cx
	and ax, 0x0F00 ; Select byte 2
	shr ax, 8 ; Shift right by 8 (byte 2 now in position 0x000F)
	call bytePrintf
	mov ax, cx 
	and ax, 0x00F0 ; Select byte 1
	shr ax, 4 ; Shift right by 4 (byte 1 now in position 0x000F)
	call bytePrintf
	mov ax, cx
	and ax, 0x000F ; Select byte 0, no need to shift
	call bytePrintf
	jmp endPrintf

bytePrintf:
	cmp al, 0xa
	jl ifNumf ; If al < 10 (is first digit 0-9), jump to ifNum
	add al, 'A' ; Else, add 'A' to al
	sub al, 10 ; Subtract 10 from al
	jmp endHexf
ifNumf:
	add al, '0' ; Add '0' to al
endHexf:
	mov ah, 0xe 
	int 0x10
	ret

endPrintf:
	popa ; Pop all registers off the stack
	ret ; Return from the function

newLine: db 0x0a, 0x0d, 0 ; New line, Carriage return, null terminator
hexPrefix: db '0x', 0 ; Hex prefix - purely for visual, null terminator