; ==========================================
; LICAO 4 PRINTSTRING
; ==========================================
PrintChar	EQU &BB5A		; referencia a uma funcao do firmware 
					; imprime o codico ascii no acumulador para tela
WaitChar	EQU &BB06		; referencia a uma funcao do firmware 
					; aguarda a digitacao de um caracter
;ThinkPositive 	EQU 1			; Diretiva de compilacao exemplo 

ORG &8000
	LD HL, Introduction 
	CALL PrintString
	CALL NewLine
	LD HL, Message
	CALL PrintString
RET 

PrintString:
	LD A, (HL)
	CP 255
	RET Z
	INC HL
	CALL PrintChar
JR PrintString

Introduction:
	DB 'Durante o dia...', 255

ifdef ThinkPositive
Message:
	DB 'Vai fazer sol. :-)', 255
else
Message:
	DB 'Vai Chover. :-(', 255
endif

NewLine:
	LD A, 13
	CALL PrintChar
	LD A, 10 
	CALL PrintChar
RET 
	