; "Hello, World!" Bootloader
; Made by Kaiden Bird
; Created: 18/06/2023
; Last updated: 25/06/2023
; Changelog: Update to the print function, changed code.

use16 ; Use 16-bit mode
org 0x7c00 ; Set the origin to 0x7c00

mov ah, 0x0e ; TTY (TeleTYpewriter) mode
mov al, 0x3 ; 80x25 @ 16 colour mode

mov bx, myString ; Move the address of the string into bx.
call printsf ; Call the print function that we've defined in a seperate file.
jmp endOfProgram ; It's cleaner to jump directly to the end of the program from here.

%include "../Global Functions/print.asm" ; Abstracted the print function.

; String	 Text		      New Line	  Null Terminator
myString: db 'Hello, World!', 0x0a, 0x0d, 0

endOfProgram:
    jmp $ ; Hang
    times 510-($-$$) db 0 ; Fills empty space with 0s
    dw 0xaa55 ; Boot sector sig