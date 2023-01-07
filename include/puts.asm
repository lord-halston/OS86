;; Prints strings of characters

puts:							; Print string
	pusha						; Push all register values onto the stack

putc:							; Print character
	mov al, [bx]				; Move ASCII chat value at BX into AL
	cmp al, 0					; Check if we reached a NUL character
	je puts_end					; If character value in AL is 0, jump to puts_end
	int 0x10					; BIOS Video Interrupt
	add bx, 1					; Move one byte forward/get next char
	jmp putc					; Loop until full string is printed

puts_end:
	popa						; Pop all register values off the stack
	ret