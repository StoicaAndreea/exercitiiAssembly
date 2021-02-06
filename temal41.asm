;13. Se dau 2 siruri de octeti A si B. Sa se construiasca sirul R 
;care sa contina elementele lui B in ordine inversa urmate de elementele pare ale lui A. 
;Exemplu:
;A: 2, 1, 3, 3, 4, 2, 6
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, 2, 4, 2, 6
assume cs:code, ds:data
data segment
a db 2, 1, 3, 3, 4, 2, 6
la equ $-a
b db 4, 5, 7, 6, 2, 1
lb equ $-b
r db la+lb dup (?)
data ends

code segment
start:
mov ax, data
mov ds,ax

mov si,lb-1
mov di,0
mov cx,lb
repeta:
	mov al,b[si]
	mov r[di],al
	sub si,1
	add di,1
loop repeta
mov si,0
mov cx,la
repeta1:
	mov al, a[si]
	cbw
	mov bl,2
	idiv bl
	cmp ah,0
	JE then
	JNE fin
	then:
		mov al,a[si]
		mov r[di],al
		add di,1
	fin:
		add si,1
loop repeta1

mov ax, 4c00h
int 21h
code ends
end start