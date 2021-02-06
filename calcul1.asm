;1. ((a+b-c)*2 + d-5)*d =>26
;data types: a,b,c -byte, d -word 
assume cs:code, ds:data

data segment
a db 7
b db 3
c db 2
d dw 2
interm dw ?
rez dw ?
data ends

code segment
start:

mov ax, data
mov ds,ax
mov al,a
mov bl,b
	; al=a+b-c
add al,bl
mov bl,c
sub al,bl
	;ax=a+b-c
cbw
	; ax=(a+b-c)*2
mov bx,2
imul bx
	; ax= (a+b-c)*2+d
add ax,d
	; ax= (a+b-c)*2+d-5
sub ax,5
	; rez=((a+b-c)*2 + d-5)*d
imul d
mov rez,ax

mov ax, 4c00h
int 21h
code ends
end start
	;am verificat pt a=7, b=3, c=2, d=2
	; rez este 26
