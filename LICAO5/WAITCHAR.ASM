PrintChar 	equ &bb5a 			; imprime um caracter na tela 
WaitChar	equ &bb06			; aguarda a digitacao de um caracter

org &8000
		call WaitChar
		call PrintChar
		push af
			ld a,'|'
			push af
				call PrintChar
				ld a,'x'
				call PrintChar
			pop af
			call PrintChar
		pop af
		call PrintChar
ret
				