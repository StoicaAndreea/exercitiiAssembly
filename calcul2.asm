;1b) c+(a*a-b+7)/(2+a) =>8
; a-byte; b-doubleword; c-doubleword

assume cs:code, ds:data
data segment
a db 7
b dd 2
c dd 2
rez dd ?
interm dw ? 
data ends

code segment
start:
mov ax, data
mov ds,ax
	;interm =2+a  word
mov al,a
add al,2
cbw
mov interm,ax
	;a*a-b+7
mov al,a	;ax=a*a
imul a
cwd		;dx:ax=a*a	
mov bx, word ptr b+0	;cx:bx=b
mov cx, word ptr b+2
clc
sub ax,bx	;dx:ax=a*a-b+7
sbb dx,cx
;ghjk
mov bx, 7	;cx:bx=7
mov cx,0
clc
add ax,bx
adc dx,cx
	;(a*a-b+7)/(2+a)
idiv interm
cwd
	;c+(a*a-b+7)/(2+a)
mov bx, word ptr c+0	;cx:bx=c
mov cx, word ptr c+2
mov word ptr rez+0,bx	;rez=c
mov word ptr rez+2,cx
clc
add word ptr rez+0,ax	;rez=c+(a*a-b+7)/(2+a)
adc word ptr rez+2,dx

mov ax, 4c00h
int 21h
code ends
end start
;am verificat pt a=7, b=2, c=2
	; rez este 8
