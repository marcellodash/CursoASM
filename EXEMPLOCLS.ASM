;CLS
;==========================================================
;LIMPA A TELA DO AMSTRAD USANDO LDIR

screenadress	equ &C000
screensize 	equ &4000

org &8100	
	ld hl,screenadress
	ld de,screenadress+1 
	ld bc,screensize-1
	ld (hl),0
	ldir 
ret
 