;Se da un sir de octeti in segmentul de date. Sa se afiseze elementele acestui sir la iesirea standard (ecran) in baza 2
assume cs:code, ds:data
data segment
a db '12$'
la equ ($-a)
r db la*9 dup (?)
data ends

code segment
start:
mov ax, data
mov ds,ax
mov si,0
mov di,0
mov cx,la-1
repeta:
	mov dx,cx
	mov al,a[si];caracter
	sub al,'0'	;transform in valoare
	mov cx,8
	repeta1:
		clc
		shl al,1
		mov bl,0
		adc bl,0
		add bl,'0'	;transform in caracter
		mov r[di],bl
		add di,1
	loop repeta1
	mov r[di],' '
	mov cx,dx
	add di,1
	add si,1
loop repeta
mov bl,'$'
mov r[di],bl

mov ah,09h
mov dx,offset r
int 21h

mov ax, 4c00h
int 21h
code ends
end start