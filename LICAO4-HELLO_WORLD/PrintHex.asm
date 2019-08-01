;===========================
; Print Hex
;===========================
PrintChar	EQU &BB5A	; referencia a uma funcao do firmware 
				; imprime o codigo ascii no acumulador para tela

org &8000
	cp 1			; o Amstrad CPC recebe o parametro do call no acumulador
	jp nz, ShowUsage	; caso nao exista parametro exibe mensagem de uso

	ld a, '&'		; imprime o indicador de hexadecimal
	call PrintChar
	
	ld a, (ix+1)		; comecamos pelo ix+1 pq lemos o valor mais alto primeiro
	or a 			; cp 0
	call nz, ShowHex	; se nao for zero, imprime
	
	ld a, (ix+0)		; lemos o valor mais baixo
	call ShowHex		; imprime
ret

ShowUsageMessage:
	db "Usage: Call &8000, [16 bit number]",255
ShowUsage:
	ld hl, ShowUsageMessage
	xor a
	call PrintString
ret

ShowHex:
	ld b,16
	call MathDiv
	push af
		ld a,c
		call PrintHexChar
	pop af
	call PrintHexChar
ret

PrintHexChar:
	cp 10 
	jr c,PrintHexCharNotAtoF
	add 7
PrintHexCharNotAtoF:
	add 48 
	jp PrintChar
MathDiv:
	ld c,0
	cp 0
	ret z
MathDivAgain:
	sub b
	inc c
	jp nc, MathDivAgain
	add b
	dec c
ret

PrintString:
	LD A, (HL)
	CP 255
	RET Z
	INC HL
	CALL PrintChar
JR PrintString

NewLine:
	LD A, 13
	CALL PrintChar
	LD A, 10 
	CALL PrintChar
RET 
