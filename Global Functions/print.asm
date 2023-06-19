; Let's create a function that can print a string recursively, character by character.
print:
    mov al, [bx] ; Move primitive bx into al
    cmp al, 0 ; Is al == 0?
    je endPrint ; If al is equal to 0, jump to endPrint. "Early return."
    int 0x10 ; Print the character in al
    add bx, 1 ; Move 1 byte, next character
    jmp print ; Recursive call to print.
    
endPrint:
    ret ; Return from the function