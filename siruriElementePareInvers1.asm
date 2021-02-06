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

mov si,offset b
add si,lb-1
mov di,offset r
mov cx,lb
repeta:
	std
	lodsb
	;movsb ;r[di]=b[si]
	;add di,2
	cld
	;stosb
	mov [di],al
	inc di
loop repeta
mov si,offset a
mov cx,la
repeta1:
	cld
	lodsb
	cbw
	mov bl,2
	idiv bl
	cmp ah,0
	JE then
	JNE fin
	then:
		dec si
		cld
		lodsb
		;stosb
		mov [di],al
		inc di
		;movsb
	fin:
loop repeta1

mov ax, 4c00h
int 21h
code ends
end start
