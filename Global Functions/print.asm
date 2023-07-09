; Global BIOS Print Functions
; Made by Kaiden Bird
; Created: 18/06/2023
; Last updated: 10/07/2023
; Changelog: Added a decimal print function, refactored hex print function.

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

%macro newLine 0
	mov bx, newLine
	call sprintf
%endmacro

; Macro to print a hex number, then print a new line.
%macro hprintLn 1
	mov cx, word [%1]
	call hprintf
	mov bx, newLine
	call sprintf
%endmacro
; Alternative, no new line.
%macro hprint 1 
	mov cx, word [%1]
	call hprintf
	mov bx, 0x0a
	call sprintf
%endmacro

; Macro to print a decimal number, then print a new line.
%macro dprintLn 1
	mov cx, word [%1]
	call dprintf
	mov bx, newLine
	call sprintf
%endmacro
; Alternative, no new line.
%macro dprint 1
	mov cx, word [%1]
	call dprintf
%endmacro

; Let's create a function that can print a string.
sprintf:
	pusha
.sprintfLoop:
	mov al, [bx] ; Move primitive bx into al
	cmp al, 0 ; Is al == 0?
	je .sprintfEnd ; If al == 0, jump to endPrint. Basically a "while (true)" loop with a break.
	mov ah, 0x0e ; Tell BIOS to print character in al
	int 0x10 ; BIOS Interrupt
	inc bx ; Move 1 byte, next character
	jmp .sprintfLoop ; Recursive call to print.
.sprintfEnd:
	popa
	ret

; Now let's create a function that can print a hex number.
hprintf:
	pusha
	sprint hexPrefix ; Print the hex prefix
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
	popa
	ret
.hprintfByte:
	cmp al, 0x0a ; Is al < 10? (Is al a number?)
	jl .hprintfIfNum ; If al < 0x0a, jump to .hprintfIfNum
	add al, 0x37 ; If al is a letter, (Number is >9) Convert to ASCII
	jmp .hprintfEndByte
.hprintfIfNum:
	add al, '0' ; Convert to ASCII
.hprintfEndByte:
	mov ah, 0x0e ; Tell BIOS to print character in al
	int 0x10 ; BIOS Interrupt
	ret

; Now let's create a function that can print a decimal number.
dprintf:
	pusha
    mov bx, 10000 ; Divisor, will print up to 5 digits.
.dprintfLoop:
    xor dx, dx
    mov ax, cx 
    mov cx, bx
    div cx ; Divide ax by cx, remainder in dx, quotient in ax.
    mov ah, 0x0e ; Tell BIOS to print character in al
    add al, '0' ; Convert to ASCII
    int 0x10 ; BIOS Interrupt
	mov cx, dx
	xor dx, dx
	push cx ; Push cx onto stack to preserve it.
    mov ax, bx
    mov cx, 10
    div cx ; Divide ax by cx, remainder in dx, quotient in ax.
	mov bx, ax ; Move quotient into bx, divisor for next loop.
	pop cx ; Pop cx off stack, restore it.
	cmp bx, 0 ; While the divisor is not 0, keep looping.
	jne .dprintfLoop
	popa
	ret

newLine: db 0x0a, 0x0d, 0 ; New line, Carriage return, null terminator
hexPrefix: db '0x', 0 ; Hex prefix - purely for visual