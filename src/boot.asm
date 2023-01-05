;; OS86 Bootloader

jmp $                       ; Jump to current address (loop indefinitely)

times 510-($-$$) db 0		; Pad out 0s until 510th byte
dw 0xAA55					; Magic number for BIOS boot