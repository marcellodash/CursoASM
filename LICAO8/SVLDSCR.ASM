;======================================================================
; SAVE/LOAD SCREEN
;======================================================================
; Os comandos de leitura e gravacao de paginas de video sao 
; especificas para cada tipo de computador, esse exemplo e para o 
; Amstrad CPC
;
; Ao rodar esse exemplo, ative o mode 1 para ter o scroll correto
;======================================================================
org &8000
	jp SaveScreen ;&8000
	jp LoadScreen ;&8003	

SaveScreen:
	cp 1
	ret nz
	ld a,(ix+0)		; recebe banco de memoria como 
				; parametro
	cp &c0			; checa se eh um banco valido
	ret c
	di
		call BankSwitch
		ld hl, &c000	; inicio da memoria de video
		ld de, &4000	; posicao da memoria onde fica 
				; o banco extra do amstrad cpc 
		ld bc, &4000	; tamanho aproxido da memoria de video
		ldir		; copia para o banco extra de memoria
				; que comeca em &4000
		ld a,&c0	; retorna para pagina 0
		call BankSwitch
	ei 
ret

LoadScreen:
	cp 1
	ret nz
	ld a,(ix+0)
	cp &c0
	ret c
	di
		call BankSwitch
		ld de, &c000 	; Grava na memoria de video
		ld hl, &4000	; Le do banco auxiliar
		ld bc, &4000
		ldir
		ld a,&c0
		call BankSwitch
	ei 
ret

BankSwitch:
	ld b,&7f 		; endereco de memoria do gateway	
	out (c), a		; troca o banco de memoria
ret 
;======================================================================