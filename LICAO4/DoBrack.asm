SquareBrackets: db '[]'
CurlyBrackets: db '()'
PrintChar	EQU &BB5A		; referencia a uma funcao do firmware 
					; imprime o codico ascii no acumulador para tela

org &8000
	ld ix,SquareBrackets
	ld hl, Message
	ld de, PrintString
	call DoBrackets
	call Newline
	ld ix,CurlyBrackets
	ld hl, Message
	ld de, PrintString
	call DoBrackets
	call Newline
ret 

DoBrackets:
	ld a, (ix+0)
	call PrintChar
	call DoCallDE
	ld a, (ix+1)
	call PrintChar
ret

DoCallDE:
	push de
ret 

PrintString:
	LD A, (HL)
	CP 255
	RET Z
	INC HL
	CALL PrintChar
JR PrintString

NewLine:
	LD A, 13
	CALL PrintChar
	LD A, 10 
	CALL PrintChar
RET 


Message:
	DB 'Mensagem teste', 255