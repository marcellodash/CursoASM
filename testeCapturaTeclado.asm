CHPUT 		equ &bb5a 			; imprime um caracter na tela 
CHGET		equ &bb06			; aguarda a digitacao de um caracter
posX:           db 128
posY:           db 96


org &8000

startProgram:

loopUntilSpace:
                push af
                  call CHGET
                  cp 97             ;esquerda
                  jp z, moveLeft
                  cp 100            ;direita
                  jp z, moveRight
                  cp 115            ;baixo
                  jp z, moveDown
                  cp 119            ;cima
                  jp z, moveUp
                  cp 32             ;espaco
                  jp z, EndProgram 
                pop af
                jr loopUntilSpace

moveLeft:                           ; diminuir em um pos x
                push af
                  ld a, (posX)
                  cp 1
                  ret z
                  dec a
                  ld (posX), a 
                pop af
                ret
moveRight:                          ; aumentar em um pos x
                push af
                  ld a, (posX)
                  cp 255
                  ret z
                  inc a
                  ld (posX), a
                pop af
                ret
moveUp:                             ; aumentar em um pos y
                push af
                  ld a, (posY)
                  cp 191
                  ret z
                  inc a
                  ld (posY),a 
                pop af
                ret

moveDown:                           ; diminuir em um pos y
                push af
                  ld a, (posY)
                  cp 1
                  ret z
                  dec a
                  ld (posY),a 
                pop af
                ret

EndProgram:
		endp

