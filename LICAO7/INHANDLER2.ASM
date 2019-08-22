;======================================================================================
; LICAO 7 - DI EI, RST x, Custom Interrupts, IM1/IM2, HALT, OTI / OTIR, HALT
;======================================================================================
org &8000

	di			; DESABILITA AS INTERRUPCOES 		
		exx		; troca os labels dos registradores padrao /shadow
		push bc		; faz o BKP de BC' 
		exx		; troca os labels dos registradores padrao /shadow
		ld hl,(&0038)	; faz o BKP do gerenciador de interrupcao padrao(RST7)
		push hl	
		ld hl,(&003A)	; FAZ O BKP DOS PROXIMOS 2 BYTES 
		push hl		
		ld a,&C3	; CODIGO DA INSTRUCAO JP
		ld (&0038),a	; TROCA O HANDLER DE RST7 POR UM JUMP	
		ld hl,InterruptHandler	
		ld (&0039),hl	; COLOCA O CODIGO DA NOSSO HANDLER CUSTOMIZADO NO 
				; DESTINO DO NOSSO JP RST7
	ei			; ATIVA AS INTERRUPCOES

	ld hl,&C000
	ld d,10			; CONTADOR PARA QUANTAS VEZES LIMPAREMOS A TELA
	ld c,%11111111		; MASCARA PARA O XOR
InfLoop:
	ld a,(hl)		; TROCA OS BITS NO BYTE DA TELA
	xor c
	ld (hl),a
	inc hl
	ld a,h			; VERIFICA SE H=0
	or a			; VERIFICA SE H=0
	jp z,PageDone		; SE SIM RESETA E DECREMENTA O CONTADOR
jp InfLoop

PageDone:
	ld hl,&C000		; REINICIA A TELA
	dec d			; DECREMENTA O CONTADOR
jp nz,InfLoop			; PREENCHE A TELA 10 VEZES

	; FIZEMOS NOSSA TAREFA, HORA DE RESTAURAR O GERENCIADOR DE INTERRUPCAO 
	; DEFAULT DO CPC
	di			; DESABILITA AS INTERRUPCOES 				
		pop hl		; PEGA O HANDLER ORIGINAL DA PILHA
		ld (&003A),hl	; JOGA O HANDLER NO RST7
		pop hl		; PEGA O CODIGO DO HANDLER ORIGINAL DA PILHA
		ld (&0038),hl   ; JOGA O CODIGO DO HANDLER NO RST7
		exx		; TROCA OS LABELS DOS REGISTRADORES PADRAO/SHADOW
		pop bc		; RESTAURA BC' 
		exx		; TROCA OS LABELS DOS REGISTRADORES PADRAO/SHADOW
	ei			; ATIVA AS INTERRUPCOES
ret

InterruptHandler:
	; On the CPC this interrupt handler run 6 times per screen (300hz)
	; On other systems (MSX/ZX/ENT) it runs 1 time per screen (50hz)
	; BUT - we cannot override the spectrum interrupt handler, because 
	; &0000-&3FFF is READ ONLY ROM
	; We can use IM2 instead - but it's more complex, we'll learn about this later!

	exx			; TROCA OS LABELS DOS REGISTRADORES PADRAO/SHADOW
				; FIZEMOS ISSO PARA PRESERVAR OS REGISTRADORES ORIGINAIS
	ex af,af'		; TROCA AF POR AF'
	ld hl,RasterColors :IH_RasterColor_Plus2

	; LE O STATUS DA TELA
	; USAMOS PARA CHECAR SE ESTAMOS NO TOPO DA TELA 
	ld b,&f5
	in a,(c)		; IN NESSE CASO EH 16 BITS, LOGO LE-SE IN A,(B)
	rra     		; POE O BIT MAIS A DIREITA NO VAI UM 
	jp nc,InterruptHandlerOk; SE VAI UM = 0, DA O OK NO HANDLER
	ld hl,RasterColors

InterruptHandlerOk:

	ld bc,&7f00		; DEFINE A COR DA CANETA COMO 0
				; B=&7F	Gate Array port
				; C=0 COR 
	out (c),c   		; EQUIVALE A Out (B),C
	outi			; OUTI EH BUGADO NO CPC ENTAO
	inc b			; PRECISAMOS INCREMENTAR B NA MAO	

	inc c			; AUMENTA C PARA MUDAR A COR DA PEN
	out (c),c		; SETA A COR 1
	outi			; OUTI EH BUGADO NO CPC ENTAO
	inc b			; PRECISAMOS INCREMENTAR B NA MAO	

	inc c			; AUMENTA C PARA MUDAR A COR DA PEN
	out (c),c		; SETA A COR 2
	outi			; OUTI EH BUGADO NO CPC ENTAO
	inc b			; PRECISAMOS INCREMENTAR B NA MAO	

	inc c			; AUMENTA C PARA MUDAR A COR DA PEN
	out (c),c		; SETA A COR 3
	outi			

	ld (IH_RasterColor_Plus2-2),hl
	ex af,af'		; RESTAURA OS REGISTRADORES AO VALOR NORMAL
	exx			; RESTAURA OS REGISTRADORES AO VALOR NORMAL
	ei			; TERMINAMOS DE GERENCIAR A INTERRUPCAO
ret


RasterColors:
	;These are hardware color numbers - they are not the same 
	;as the color numbers used by basic.
	db &4C,&43,&52,&5C	;Change 1
	db &52,&5C,&4C,&43	;Change 2
	db &4C,&43,&52,&5C	;Change 3
	db &52,&5C,&4C,&43	;Chance 4
	db &4C,&43,&52,&5C	;Change 5
	db &52,&5C,&4C,&43	;Change 6
