;===========================================================
; SAVE/LOAD SCREEN
;===========================================================
org &8000
	jp SaveScreen ;&8000
	jp LoadScreen ;&8003	

SaveScreen:
	cp 1
	ret nz
	la a,(ix+0)
	cp &c0
	ret c
	di
		call BankSwitch
		ld hl, &c000
		ld de, &4000
		ld bc, &4000
		ldir
		ls a,&c0
		call BankSwitch
	ei 
ret

LoadScreen:
	cp 1
	ret nz
	la a,(ix+0)
	cp &c0
	ret c
	di
		call BankSwitch
		ld de, &c000
		ld hl, &4000
		ld bc, &4000
		ldir
		ls a,&c0
		call BankSwitch
	ei 
ret

BankSwitch:
	ld b,&7f 	
	out (c), a
ret 