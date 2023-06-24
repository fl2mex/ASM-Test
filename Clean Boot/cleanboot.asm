; Clean-looking Bootloader
; Made by Kaiden Bird
; Created: 25/06/2023

jmp start
%include "../Global Functions/print.asm"
start:
	use16 ; Use 16-bit mode
	org 0x7c00 ; Set the origin to 0x7c00

	; Set Video Mode
	; AL sets Size & Palette Registers
	; See https://stanislavs.org/helppc/int_10-0.html for AL values
	;
	mov ah, 0x00 ; Tell BIOS Interrupt to set video mode
	mov al, 0x03 ; 80x25 @ 16 colour mode
	int 0x10

	; Set Colours
	; AH sets Colour Palette Registers
	; See https://stanislavs.org/helppc/int_10-b.html for BL & BH values
	; Colour Values:
	; Black         - 0x00 ; Dark Gray     - 0x08
	; Blue          - 0x01 ; Light Blue    - 0x09
	; Green         - 0x02 ; Light Green   - 0x0a
	; Cyan          - 0x03 ; Light Cyan    - 0x0b
	; Red           - 0x04 ; Light Red     - 0x0c
	; Magenta       - 0x05 ; Light Magenta - 0x0d
	; Brown         - 0x06 ; Light Brown   - 0x0e
	; Light Gray    - 0x07 ; White         - 0x0f
	;
	mov ah, 0x0b ; Tell BIOS Interrupt to set colour registers
	mov bh, 0x00 ; Colour Value Select
	mov bl, 0x01 ; Set bacground colour to Blue
	int 0x10

	mov ah, 0x0e ; TTY (TeleTYpewriter) mode

	printsLn lines
	printsLn string
	printsLn lines

	printh 0xabcd
	printsLn hex1
	printh 4660
	printsLn hex2

	mov ah, 0x01 ; Tell BIOS Interrupt to set cursor type
	mov ch, 0x00 ; Cursor start line
	mov cl, 0x0f ; Cursor end line
	int 0x10

loop:
	mov ah, 0x00 ; Tell BIOS Interrupt to read key
	int 0x16 ; Read key from keyboard
	mov ah, 0x0e ; Call print char interrupt
	int 0x10
	
	cmp al, 0xd ; Check if enter key was pressed
	jne loop ; If enter key was pressed, end program
	int 0x19 ; Reboot

lines: db '====================', 0
string: db 'Welcome to My OS!', 0
hex1: db ' is 43981 in decimal', 0
hex2: db ' is 4660 in decimal', 0

endOfProgram:
	jmp $ ; Hang
	times 510 - ($-$$) db 0 ; Fills empty space with 0s
	dw 0xaa55 ; Boot sector sig