;13. Se da un sir de dublucuvinte. 
;Sa se determine si sa se salveze in sirul D 
;toti octetii care au numarul de biti din reprezentarea binara mai mic decat o valoare k 
;(declarata in segmentul de date).
assume cs:code, ds:data
data segment
a dd 11111110000000010000001000000011b, 00000000000000010000001000000011b, 00000001000000100000001100000100b
la equ ($-a)
r db la dup (?)
k dw 3
contor db ?
data ends

code segment
start:
mov ax, data
mov ds,ax
mov si,offset a
mov di,offset r
mov cx,la
repeta:
	mov dx,cx
	cld
	lodsb
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
			dec si
			lodsb
			mov r[di],al
			add di,1
		stop: 
		mov cx,dx		
loop repeta

mov ax, 4c00h
int 21h
code ends
end start
