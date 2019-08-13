PrintChar	equ &BB5A		; referencia a uma funcao do firmware 
					; imprime o codico ascii no acumulador para tela
WaitChar	equ &BB06		; referencia a uma funcao do firmware 
					; aguarda a digitacao de um caracter

ORG &8000
	call WaitChar
	call printChar
	push af
		ld a, '|'
		push af
			call PrintChar
			ld a, 'x'
			call PrintChar
		pop af
		call PrintChar
	pop af
	call PrintChar
ret

org &8200 
	call WaitChar
	call printChar
	ld (temp), a
	ld a, '|'
	call PrintChar
	ld (temp2), a
	ld a, 'x'
	call PrintChar
	ld a, (temp2)
	call PrintChar
	ld a, (temp)
	call PrintChar
ret

Temp: db 0
Temp2: db 0
	

