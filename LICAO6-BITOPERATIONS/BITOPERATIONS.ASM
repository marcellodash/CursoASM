; ==============================================
; inverte os pixels da tela usando xor
; entre no modo 2 para visualizar o efeito 
; MODE 2
; CALL &8000
; ==============================================
ORG &8000
	
	ld hl, &C000 	; CARREGA A TELA 
AgainE: 
	ld a, (hl)
	;xor %11111111   ; INVERTE OS BITS
	;and %11110000   ; FAZ O AND DOS BITS (SE TODOS LIGADOS, LIGADO)
	;or %11110000     ; FAZ O OR DOS BITS (SE UM LIGADO, LIGADO)

	or %00000001 	 ; SETA O ULTIMO BIT PARA 1 
			 ; SET 0,A
	and %01111111    ; SETA O PRIMEIRO BIT PARA 0 
			 ; RES 7,A
			 ; OPERADORES LOGICOS FUNCIONAM APENAS NO ACUMULADOR
			 ; SET E RES FUNCIONAM EM QUALQUER REGISTRADOR.
	ld (hl), a
	inc l
	jp nz, AgainE
	inc h
	jp nz, AgainE
ret 	
	
