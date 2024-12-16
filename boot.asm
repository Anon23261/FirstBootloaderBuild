; boot.asm - A simple x86 bootloader
[BITS 16]            ; We're in Real Mode (16-bit)
[ORG 0x7C00]         ; BIOS loads the bootloader here

start:
    mov ah, 0x0E     ; BIOS teletype function (print character)
    mov si, msg      ; Load address of the message
.print_loop:
    lodsb            ; Load byte at [SI] into AL, increment SI
    cmp al, 0        ; Check if end of string
    je .halt         ; If zero, jump to halt
    int 0x10         ; BIOS interrupt to print character
    jmp .print_loop  ; Repeat

.halt:
    cli              ; Disable interrupts
    hlt              ; Halt CPU

msg db "Hello from your custom bootloader!", 0

times 510-($-$$) db 0 ; Fill remaining space with zeros
dw 0xAA55             ; Boot signature (mandatory)