; ===============================================================
; LICAO 3 - ASM Z80 
; ===============================================================
ORG &8000
		LD A,(&9000)	; variaval para a operacao (1 byte)
		LD BC,(&9001)	; variavel para os operadores (2 bytes)
				; vai utilizar &9001 e &9002
		OR A		;  = CP 0
		JR Z, MATHADD 	; pula para soma
		CP 1            
		JR Z, MATHSUB	; pula para subtracao
		CP 2
		JR Z, MATHMULT  ; pula para multiplicacao
		CP 3
		JR Z, MATHDIV   ; pula para divisao
		XOR A		; = LD A,0
SAVERESULT:
		LD (&9003), A	; salva o resultado em &9003
		RET

MATHSUB:
		LD A,C
		SUB B		; subtrai o valor em b do acumulador
		JR SAVERESULT
MATHADD:
		LD A,C
		ADD B		; adiciona o valor em b no acumulador
		JR SAVERESULT
MATHMULT:
		LD A,B		; a multiplicacao e feita por um loop
		CP 0		; caso b seja zero, nao precisamos multiplicar
		JR Z,SAVERESULT 
		LD A,0		; limpa o acumulador para inicar o loop
MATHMULTAGAIN:
		ADD C			; soma o valor 
		DJNZ MATHMULTAGAIN	; se ainda temos multiplicador 
					; continuamos no loop
		JR SAVERESULT
MATHDIV:
		LD A,C			; a divisao e feita por sucessivas
					; subtracoes
		CP 0			; se o denominador e zero nao precisamos
					; dividir. nao se divide por zero
		JR Z, SAVERESULT
		LD D,0			; zeramos o contador de divisoes
MATHDIVAGAIN:
		SUB B 			; diminuimos b
		INC D			; somamos o contador de divisoes
		JR NC, MATHDIVAGAIN     ; se nao teve carry
		DEC D			; aumenta o contador de divisoes
		LD A, D			; carrega o numemero de divisoes 
					; no resultado 
		JR SAVERESULT


 	