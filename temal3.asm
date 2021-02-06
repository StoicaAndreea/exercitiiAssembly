;pb6 Se dau doua cuvinte A si B.
;Sa se obtina un octet C care are pe bitii 0-4 bitii 11-15 ai cuvântului A,
;iar pe bitii 5-7 bitii 2-4 ai cuvântului B.

assume cs:code, ds:data
data segment
a dw 55CAh
b dw 0F0Fh
c db ?		;c= 1111 1111 = FFh =255
data ends

code segment
start:
mov ax, data
mov ds,ax

mov ax,a		;ax= a15a14a13a12a11 a10a9a8a7a6a5a4a3a2a1a0
and ax,1111100000000000b			;izolam bitii 11-15 => ax=a15a14a13a12a11 00000000000	
ror ax,11		;facem o rotire la dreapta pentru a ajunge pe pozitia 0-4
mov bx, b		;bx=b15b14b13b12b11b10b9b8b7b6b5 b4b3b2 b1b0
and bx,0000000000011100b ;izolam bitii 2-4
rol bx,3		;rotim 3 pozitii la stanga => bx=00000000 b4b3b2 0 0000
or ax,bx		;punem la un loc ceea ce avem in ax si bx	;ax=00000000b4b3b2a15a14a13a12a11
mov c,al		;mutam rezultatul (al) in c	

mov ax, 4c00h
int 21h
code ends
end start