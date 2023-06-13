; Booting into 16-bit mode with video mode 3
; Made by Kaiden Bird
; 13/06/2023

mov ax, 0x3 ; Set video mode to 3
int 10h ; Call video subroutine

; Legacy boot bios expects the boot sector to be 512 bytes long.
times 510-($-$$) db 0 ; Fills 510 bytes of the boot sectors to 0.
dw 0xaa55 ; Last two bytes are so the BIOS knows it's a boot sector.