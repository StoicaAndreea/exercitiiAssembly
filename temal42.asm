;13. Se da un sir de dublucuvinte. 
;Sa se determine si sa se salveze in sirul D 
;toti octetii care au numarul de biti din reprezentarea binara mai mic decat o valoare k 
;(declarata in segmentul de date).
assume cs:code, ds:data
data segment
a dd 0ABFE273Ah, 9812CE34h, 0AB690145h, 0D2A08250h
la equ ($-a)
r db la dup (?)
k dw 6
contor db ?
data ends

code segment
start:
mov ax, data
mov ds,ax
mov si,0
mov di,0
mov cx,la
repeta:
	mov dx,cx
	mov al,byte ptr a[si]
	mov cx,8
	repeta1:
		mov bl,1
		shl al,1
		mov ah,0
		adc ah,0
		cmp ah,bl
		JE stop1
	loop repeta1
	stop1:
		cmp cx,k
		JLE then
		JG stop
		then:
			mov al,byte ptr a[si]
			mov r[di],al
			add di,1
		stop: 
			add si,1
		mov cx,dx		
loop repeta

mov ax, 4c00h
int 21h
code ends
end start