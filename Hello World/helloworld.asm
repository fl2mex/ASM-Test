; "Hello, World!" Bootloader
; Made by Kaiden Bird
; 13/06/2023

use16 ; Use 16-bit mode
org 0x7c00 ; Set the origin to 0x7c00

mov ah, 0x0e ; TTY (TeleTYpewriter) mode
mov al, 0x3 ; 80x25 @ 16 color mode

mov bx, myString ; Move the address of the string into bx.
call print ; Call the print function that we'll define below.
jmp endOfProgram ; It's cleaner to jump directly to the end of the program from here.

; Let's create a function that can print a string recursively, character by character.
print:
    mov al, [bx]
    cmp al, 0 ; Compare al to 0
    je endPrint ; If al is equal to 0, jump to end_print_string. "Early return."
    int 0x10 ; Print the character in al
    add bx, 1 ; Move 1 byte, next character
    jmp print ; Recursive call to print_string.
    
endPrint:
    ret ; Return from the function

myString: db 'Hello, World!', 0 ; 0/Null terminated string

endOfProgram:
    jmp $ ; Jump to current address (forever), saves 1 LOC but its for shits and giggles

    ; Legacy boot bios expects the boot sector to be 512 bytes long.
    times 510-($-$$) db 0 ; Fills 510 bytes of the boot sectors to 0.
    dw 0xaa55 ; Last two bytes are so the BIOS knows it's a boot sector.