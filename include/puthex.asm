;; Prints hexadecimal values

puthex:					; Print hexadecimal
	pusha				; Push all register values on the stack
	mov cx, 0			; Initialize loop counter (CX)

puthex_loop:
	cmp cx, 4			; Check if we are at the end of the loop
	je puthex_loop_end	; Jump to end of the loop

	mov ax, dx			; Move hex value into AX
	and ax, 0x000F		; Make first three hex digits 0s and keep final digit to convert to ASCII
	add al, 0x30		; Get ASCII number value
	cmp al, 0x39		; Check if hex value is 0-9 or A-F
	jle puthex_mov_bx
	add al, 0x7			; Get ASCII 'A'-'F'

puthex_mov_bx:			; Move ASCII char into string stored in BX
	mov bx, hexStr + 5	; Base address of string + string length
	sub bx, cx			; Subtract loop counter
	mov [bx], al		; Move character value into address at BX
	ror dx, 4			; Rotate right four bits

	add cx, 1			; Increment loop counter
	jmp puthex_loop		; Loop for next hex digit

puthex_loop_end:		; End of puthex loop
	mov bx, hexStr
	call puts

	popa				; Pop all register values off stack
	ret

hexStr: db '0x0000', 0