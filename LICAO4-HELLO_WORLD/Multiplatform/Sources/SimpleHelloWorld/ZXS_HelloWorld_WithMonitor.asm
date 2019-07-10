	;Unrem this if building with vasm
	include "\SrcALL\VasmBuildCompat.asm"

	Org &8000				;Code Origin

	ld hl,Message			;Address of string
	Call PrintString		;Show String to screen

	;Monitor tests
	
	call Monitor				;Show Register contents
	
	call newline
	
	ld hl,&8000					;Address to show
	ld c,32						;Bytes to show
	call Monitor_MemDumpDirect	;Show memory to screen

	ret
	
NewLine:
	ld a,13			;Carriage return only - Spectrum doesn't like CHR(10)
	jr PrintChar
	
	
PrintChar:
	push hl
	push bc
	push de			
	push af
		ld a,2		;Select Stream 2 = topscreen
		call &1601	;CHAN_OPEN
	pop af
	push af
		rst 16		;call &0010	;PRINT_A_1
	pop af
	pop de
	pop bc			
	pop hl
	ret	

PrintString:
	ld a,(hl)	;Print a '255' terminated string 
	cp 255
	ret z
	inc hl
	call PrintChar
	jr PrintString

Message: db 'Hello World 323!',255



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Bonus! Monitor/Memdump

;These are needed only for the Monitor/Memdump

;BuildZXS equ 1										;Enable this if you don't use my scripts
SimpleBuild equ 1
	read "\SrcALL\Multiplatform_Monitor_RomVer.asm"
	read "\SrcALL\Multiplatform_ShowHex.asm"
	read "\SrcALL\Multiplatform_MonitorMemdump.asm"
	