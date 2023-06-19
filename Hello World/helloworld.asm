; "Hello, World!" Bootloader
; Made by Kaiden Bird
; 18/06/2023

use16 ; Use 16-bit mode
org 0x7c00 ; Set the origin to 0x7c00

mov ah, 0x0e ; TTY (TeleTYpewriter) mode
mov al, 0x3 ; 80x25 @ 16 color mode

mov bx, myString ; Move the address of the string into bx.
call print ; Call the print function that we've defined in a seperate file.
jmp endOfProgram ; It's cleaner to jump directly to the end of the program from here.

%include "../Global Functions/print.asm" ; Abstracted the print function.

; String	 Text		      New Line	  Null Terminator
myString: db 'Hello, World!', 0x0a, 0x0d, 0

endOfProgram:
    jmp $ ; Jump to current address (forever), saves 1 LOC but its for shits and giggles

    ; Legacy boot bios expects the boot sector to be 512 bytes long.
    times 510-($-$$) db 0 ; Fills 510 bytes of the boot sectors to 0.
    dw 0xaa55 ; Last two bytes are so the BIOS knows it's a boot sector.
