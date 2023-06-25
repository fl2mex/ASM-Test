; Global BIOS Print Functions
; Made by Kaiden Bird
; Created: 18/06/2023
; Last updated: 26/06/2023
; Changelog: Refactors, renamed functions.

; Macro to print a string, then print a new line.
%macro sprintLn 1 
	mov bx, %1
	call sprintf
	mov bx, newLine
	call sprintf
%endmacro
; Alternative, no new line.
%macro sprint 1 
	mov bx, %1
	call sprintf
%endmacro

; Macro to print a hex number, then print a new line.
%macro hprintLn 1
	mov cx, %1
	call hprintf
	mov bx, newLine
	call sprintf
%endmacro
; Alternative, no new line.
%macro hprint 1 
	mov cx, %1
	call hprintf
	mov bx, 0x0a
	call sprintf
%endmacro

; Let's create a function that can print a string.
sprintf:
	push bx

.sprintfLoop:
	mov al, [bx] ; Move primitive bx into al
	cmp al, 0 ; Is al == 0?
	je .sprintfEnd ; If al == 0, jump to endPrint. Basically a "while (true)" loop with a break.
	int 0x10 ; Print the character in al
	inc bx ; Move 1 byte, next character
	jmp .sprintfLoop ; Recursive call to print.

.sprintfEnd:
	pop bx
	ret

; Now let's create a function that can print a hex number.
hprintf:
	push bx
	push cx

	mov bx, hexPrefix ; Print the hex prefix
	call sprintf

	mov ax, cx ; Move cx into ax
	and ax, 0xF000 ; Select byte 3
	shr ax, 12 ; Shift right by 12 (byte 3 now in position 0x000F)
	call .hprintfByte
	mov ax, cx
	and ax, 0x0F00 ; Select byte 2
	shr ax, 8 ; Shift right by 8 (byte 2 now in position 0x000F)
	call .hprintfByte
	mov ax, cx 
	and ax, 0x00F0 ; Select byte 1
	shr ax, 4 ; Shift right by 4 (byte 1 now in position 0x000F)
	call .hprintfByte
	mov ax, cx
	and ax, 0x000F ; Select byte 0, no need to shift
	call .hprintfByte

	jmp .hprintfEnd

.hprintfByte:
	cmp al, 0x0a
	jl .hprintfIfNum ; If al < 10 (is first digit 0-9), jump to ifNum
	add al, 'A' ; Else, add 'A' to al
	sub al, 10 ; Subtract 10 from al
	jmp .hprintfEndByte

.hprintfIfNum:
	add al, '0' ; Add '0' to al

.hprintfEndByte:
	mov ah, 0x0e 
	int 0x10
	ret

.hprintfEnd:
	pop cx
	pop bx
	ret

newLine: db 0x0a, 0x0d, 0 ; New line, Carriage return, null terminator
hexPrefix: db '0x', 0 ; Hex prefix - purely for visual, null terminator