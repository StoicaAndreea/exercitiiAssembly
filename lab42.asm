;1. Se da un sir de cuvinte s. Sa se construiasca sirul de octeti d, 
;astfel incat d sa contina pentru fiecare pozitie din s:
;- numarul de biti de 0, daca numarul este negativ
;- numarul de biti de 1, daca numarul este pozitiv
;Exemplu:
;s: -22, 145, -48, 127
;in binary: 
;1111111111101010, 10010001, 1111111111010000, 1111111
;d: 3, 3, 5, 7

assume cs:code, ds:data
data segment
a dw -22, 145, -48, 127
l equ ($-a)/2
d db l dup (?)
inter dw 0
data ends

code segment
start:
mov ax, data
mov ds,ax

mov si,0
mov di,0
mov d[di],0
mov cx,l
repeta:
	mov ax,a[si]
	mov bx,0
	mov d[di],0
	cmp ax,bx
	mov dx,cx
	JL eq_then		;daca nr e mai mic decat 0,adica negativ
	JGE eq_else	 ;daca nr e pozitiv
	
	eq_then:
		mov cx,16
		repeta_repeta1:		;luam fiecare bit si vedem daca e 0
			shl ax,1
			mov inter,0
			adc inter,0
			cmp inter,bx
			JE then_then
			JNE sari
			then_then:
					add d[di],1
			sari:
		loop repeta_repeta1
		mov cx,dx
		jmp final
	
	eq_else:
		mov cx,16
		repeta_repeta2:		;luam fiecare bit si vedem daca e 1
			shl ax,1
			mov inter,0
			adc inter,0
			cmp inter,bx
			JNE else_else
			JE sari2
			else_else:
					add d[di],1
			sari2:
		loop repeta_repeta2
		mov cx,dx
	final:
		add si,2
		add di,1
loop repeta

mov ax, 4c00h
int 21h
code ends
end start