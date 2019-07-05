; ===============================================================
; LICAO 3 - ASM Z80 
; ===============================================================
ORG &8000
		LD A,(&9000)
		LD BC,(&9001)	
		OR A;  = CP 0
		JR Z, MATHADD
		CP 1
		JR Z, MATHSUB
		CP 2
		JR Z, MATHMULT
		CP 3
		JR Z, MATHDIV
		XOR A; = LD A,0
SAVERESULT:
		LD (&9003), A
		RET

MATHSUB:
		LD A,C
		SUB B
		JR SAVERESULT
MATHADD:
		LD A,C
		ADD B
		JR SAVERESULT
MATHMULT:
		LD A,B
		CP 0
		JR SAVERESULT
		LD A,0
MATHMULTAGAIN:
		ADD C
		DJNZ MATHMULTAGAIN
		JR SAVERESULT
MATHDIV:
		LD A,C
		CP 0
		JR Z, SAVERESULT
		LD D,0
MATHDIVAGAIN:
		SUB B
		INC D
		JR NC, MATHDIVAGAIN
		DEC D
		LD A, D
		JR SAVERESULT


 	