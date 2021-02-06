;5. z=(a+b+c+1) *(a+b+c+1) /((a-b+d)*(a-b+d))     =>6
assume cs:code, ds:data

data segment
a db 7
b dw 3
c dw 2
d dw 1
interm dw ?
z dw ?
data ends

code segment
start:
mov bx, data
mov ds,bx
	;interm=((a-b+d)*(a-b+d))
mov al,a
mov ah,0
add ax,d
sub ax,b
imul ax
mov interm,ax
	;ax=(a+b+c+1) *(a+b+c+1)
mov al,a
mov ah,0
add ax,b
add ax,c
add ax,1
imul ax
	;z=(a+b+c+1) *(a+b+c+1) /((a-b+d)*(a-b+d))
cwd
idiv interm
mov z,ax

mov ax, 4c00h
int 21h
code ends
end start