;; OS86 Bootloader

org 0x7C00						; Start at memory address 0x7C00

mov ah, 0x00					; AH = 0x00/INT 0x10 - Set Video Mode
mov al, 0x03					; 80x25 16-color text mode
int 0x10						; BIOS Video Interrupt

mov ah, 0x02					; AH = 0x02/INT 0x10 - Set Cursor Position
mov dh, 1						; Set row
mov dl, 37						; Set column
int 0x10						; BIOS Video Interrupt

mov ah, 0x0B					; AH = 0x0B/INT 0x10 - Set Color Palette
mov bh, 0x00					; Set background color
mov bl, 0x04					; Red
int 0x10						; BIOS Video Interrupt

mov bx, osName					; Move memory address at osName into BX register
call puts						; Print string stored in BX

mov bx, hexTest
call puts

mov ah, 0x02					; AH = 0x02/INT 0x10 - Set Cursor Position
mov dh, 3						; Set row
mov dl, 1						; Set column
int 0x10						; BIOS Video Interrupt

int 0x12						; BIOS Memory Size Determination

mov dx, ax
call puthex

jmp $							; Jump to current address (loop indefinitely)

include '../include/puts.asm'
include '../include/puthex.asm'

osName:	db 'OS86', 0xA, 0xD, 0			
hexTest: db 'Memory Size: ', 0

times 510-($-$$) db 0			; Pad out 0s until 510th byte
dw 0xAA55						; Magic number for BIOS boot
