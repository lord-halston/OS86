;; OS86 Bootloader
org 0x7C00						; Start at memory address 0x7C00

mov ah, 0x00					; AH = 0x00/INT 0x10 - Set Video Mode
mov al, 0x03					; 80x25 16-color text mode
int 0x10						; BIOS Video Interrupt

mov ah, 0x02					; AH = 0x02/INT 0x10 - Set Cursor Position
mov dh, 1						; Set row
mov dl, 35						; Set column
int 0x10						; BIOS Video Interrupt

mov ah, 0x0B					; AH = 0x0B/INT 0x10 - Set Color Palette
mov bh, 0x00					; Set background color
mov bl, 0x04					; Red
int 0x10						; BIOS Video Interrupt

mov ah, 0x0E					; AH = 0x0E/INT 0x10 - BIOS Teletype Output
mov bx, osName					; Move memory address at osName into BX register

call puts						; Print string stored in BX
jmp end_pgm						; Jump to end of program

puts:							; Print string
	mov al, [bx]				; Move ASCII chat value at BX into AL
	cmp al, 0					; Check if we reached a NUL character
	je puts_end					; If character value in AL is 0, jump to puts_end
	int 0x10					; BIOS Video Interrupt
	add bx, 1					; Move one byte forward/get next char
	jmp puts					; Loop until full string is printed

puts_end:
	ret

osName:	db 'OS86', 0			; Null-terminated string to print

end_pgm:						; End of program
	jmp $                       ; Jump to current address (loop indefinitely)

	times 510-($-$$) db 0		; Pad out 0s until 510th byte
	dw 0xAA55					; Magic number for BIOS boot