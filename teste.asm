;Fill Again
;==========================================================
;CRIA UM EFEITO DE PISCADA NA TELA

screenadress	equ &C000
screensize 	equ &4000

org &8200	
	ld a,%00001111
FillAgain:
	ld hl,screenadress
	ld de,screenadress+1 
	ld bc,screensize-1
	ld (hl),a
	ldir 
	dec a
	cp 255
	jp nz,FillAgain ; COMPARACAO COM FLAGS 
			; Z=ZERO
			; NZ=NONZERO
			; C=CARRY
			; NC=NONCARY
ret
 