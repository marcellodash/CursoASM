screensize 	equ &4000
org &8100	
	ld a, %000111
fillAgain:
	ld hl,&C000
	ld de,&C000+1 
	ld bc,screensize-1 
	ld (hl), a
	ldir 
	dec a
	cp 255
	jp nz, fillAgain
ret
	