PrintChar	equ &BB5A		; referencia a uma funcao do firmware 
					; imprime o codico ascii no acumulador para tela
WaitChar	equ &BB06		; referencia a uma funcao do firmware 
					; aguarda a digitacao de um caracter

ORG &8000
	ld a, ';'
	call PrintChar
	call test	; push PC; jp test
ret 

test:
	ld a, ';'
	call PrintChar
ret