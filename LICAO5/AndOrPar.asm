;===================================================
; And or Or com parametros
; chamada => call &8000, &40FC
; &40 = 10000000 (AND ou OR)
; &FC = 11111100 (Mascara)
;===================================================

org &8000
	cp 1		; se nao recebeu parametro, 
	ret nz		; retorna 
	ld b,(ix+1)	; le a parte mais significativa do parametro
	ld c,(ix)	; le a parte menos significativa do parametro
	ld hl, &c000 	; pega a memoria de video do cpc 

Again:
	ld a,(hl)	; le a memoria de video do cpc
	bit 7,b 	; compara o bit 7 do registrador b
	jr z, NoAnd	; se for zero nao faz o and
	and c
NoAnd:
	bit 6,b		; compara o bit 6 do registrador b 
	jr z, NoOr	; se for zero nao faz o or
	or c
NoOr:
	ld (hl), a
	inc l
	jp nz, Again
	inc h
	jp nz, Again 
ret