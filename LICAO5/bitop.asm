org &8000
	ld hl, &c000 	; pega a memoria de video do cpc 
AgainE:
	ld a, (hl)
	xor %11110000   ; inverte bits 
	and %11110000	; faz o and logico 
	or %11110000	; faz o or logico 
	set 0,a 	; or  %00000001
	res 7,a 	; and %01111111
	ld (hl), a
	inc l
	jp nz, AgainE
	inc h 
	jp nz, AgainE
ret