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