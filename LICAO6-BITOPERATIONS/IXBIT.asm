; ==============================================
; USO DE IX E BIT
; 
; 
; CALL &8000
; ==============================================
ORG &8000
	
	CP 1 
	RET NZ		; COMPARA SE O PARAMETRO FOI ENVIADO
	LD B,(IX+1)	; BIT MAIS SIGNIFICANTE DO PARAMETRO B
	LD C,(IX+0)	; BIT MENO SIGNIFICANTE DO PARAMETRO B
	LD HL, &C000 	; ENDERECO DA MEMORIA DE VIDEO AMSTRAD
Again:
	LD A, HL 
	BIT 7,B         ; CP SEMPRE COMPARA COM O ACUMULADOR
	JR Z, NoAnd	; BIT PERMITE COMPARAR OUTROS REGISTARDORES
	AND C
NoAnd:
	bit 6,b
	jr z,NoOr
	or c
NoOr:	
	inc 1
	jp nz,Again
	inc h
	jp nz, Again
ret



