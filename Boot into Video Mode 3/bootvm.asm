; Video Mode - Text
; Made by Kaiden Bird
; 13/06/2023

use16 ; Use 16-bit mode
org 0x7c00 ; Set the origin to 0x7c00

mov ax, 0x3 ; 80x25 @ 16 color mode
int 10h ; Video BIOS interrupt

; Legacy boot bios expects the boot sector to be 512 bytes long.
times 510-($-$$) db 0 ; Fills 510 bytes of the boot sectors to 0.
dw 0xaa55 ; Last two bytes are so the BIOS knows it's a boot sector.