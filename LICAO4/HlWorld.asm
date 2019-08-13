PrintChar	equ &BB5A		; referencia a uma funcao do firmware 
					; imprime o codico ascii no acumulador para tela

		ORG &1200
		LD HL, MESSAGE 		; ENDERECO DA MENSAGEM
		CALL PrintString	; SHOW STRING TO SCREEN 
		call NewLine		; PULA LINHA 
		LD HL, MESSAGE 		; ENDERECO DA MENSAGEM
		CALL PrintString	; SHOW STRING TO SCREEN 
		call NewLine		; PULA LINHA 
		RET 

PrintString:
		ld a, (hl)		; printa uma string terminada em 255 (espaco)
		cp 255
		ret z
		inc hl 
		call PrintChar
		jr PrintString
Message:
		db 'Ola Mundo!',255
NewLine:
		ld a,13			; retorno do carro
		call PrintChar
		ld a,10			; pular linha
		jp PrintChar
