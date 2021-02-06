;1. Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1
;astfel incat elementele din D sa reprezinte produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S. 
;Exemplu:
;S: 1, 2, 3, 4
;D: 2, 6, 12
assume cs:code, ds:data
data segment
a db 1,2,3,4
l equ $-a
d dw l-1 dup (?)
data ends

code segment
start:
mov ax, data
mov ds,ax

mov si,0
mov di,0
mov cx,l-1
repeta:
	mov al,a[si]
	imul a[si+1]
	mov d[di],ax
	add si,1
	add di,2

loop repeta

mov ax, 4c00h
int 21h
code ends
end start