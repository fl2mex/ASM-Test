; Simple Boot Loop
; Made by Kaiden Bird
; 13/06/2023

loop: ; Define "Loop" 
    jmp loop ; Jumps from loop to loop, forever.

; Legacy boot bios expects the boot sector to be 512 bytes long.
times 510-($-$$) db 0 ; Fills 510 bytes of the boot sectors to 0.
dw 0xaa55 ; Last two bytes are so the BIOS knows it's a boot sector.