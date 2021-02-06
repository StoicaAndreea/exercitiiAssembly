;13. Se citeste de la tastatura un numar. Sa se afiseze acest numar decrementat cu 1.
	;add bl,'0'	;transform in caracter
assume cs:code, ds:data
data segment
a db 10,?,10 dup (?)
linie db 10,13,'$'
stop_sign dw 1
sgn dw 0
data ends

code segment
start:
mov ax, data
mov ds,ax

;citesc
mov ah,0Ah
mov dx, offset a
int 21h

;afisez ce am citit
mov bl,a[1]
mov bh,0
add bx,1	;in caz ca am doar un 0
mov si, bx
add si, 2
mov bl,'$'
mov a[si],bl

mov ah,09h
mov dx, offset a + 2
int 21h

;linie noua
mov ah,09h
mov dx, offset linie
int 21h


;verific daca am doar o cifra, care e 0
cmp a[1],1
JE unul
JNE nueunul
unul:
	cmp a[2],'0'
	JE ezero
	JNE nueunul
	ezero:
		mov a[2],'-'
		mov a[3],'1'
		jmp stop
	
nueunul:

mov dl, a[2]
cmp dl,'-'		;verific daca am numar negativ
je then
jne elsee
then:
	add stop_sign,1		;daca da, am grija sa ma opresc cu scaderea iinainte de minus
	mov sgn,1
elsee:	
mov bl,a[1]
mov bh,0		;retin ultima pozitie din sir pe care se afla o cifra si iau ultimul elem in al
add bx,1
mov si, bx
mov al,a[si];caracter
sub al,'0'	;transform in valoare

mov dl,0
cmp sgn,0
JE pozitiv
JNE negativ

pozitiv:
	cmp al,0		;verific daca am cifra 0
	je then1
	jne else1
	then1:
		mov al,9		;daca am cifra 0, atunci schimb cifra in 9 si simulez eu un CF, in care retin carry-ul
		mov dl,1
		JMP stop1
	else1:
		sub al,1		;daca nu am cifra 0, scad
		mov dl,0
		JMP stop1
		
negativ:
	cmp al,9		;verific daca am cifra 9
	je then1n
	jne else1n
	then1n:
		mov al,0		;daca am cifra 9, atunci schimb cifra in 0 si simulez eu un CF, in care retin carry-ul
		mov dl,1
		JMP stop1
	else1n:
		add al,1		;daca nu am cifra 9, adun
		mov dl,0
stop1:


add al,'0'	;transform in caracter
mov a[si],al
dec si
mov cx,bx
repeta:
	mov al,a[si];caracter
	sub al,'0'	;transform in valoare
	cmp sgn,0
	JE pozitiv1
	JNE negativ1
	
	pozitiv1:
		cmp al,0				;verific daca am cifra 0
		je then2
		jne else2
		then2:
			cmp dl,1			;daca am cifra 0, verific daca am CF
			JE then3
			JNE else3
			then3:
				mov al,9		;daca am cifra 0 si CF, atunci schimb cifra in 9 si simulez eu un CF, in care retin carry-ul
				mov dl,1
			else3:
			JMP stop2
		else2:
			sub al,dl		;daca nu am cifra 0, scad si sterg "CF-ul"
			mov dl,0
			Jmp stop2
			
	negativ1:
		cmp al,9				;verific daca am cifra 9
		je then2n
		jne else2n
		then2n:
			cmp dl,1			;daca am cifra 9, verific daca am CF
			JE then3n
			JNE else3n
			then3n:
				mov al,0		;daca am cifra 9 si CF, atunci schimb cifra in 0 si simulez eu un CF, in care retin carry-ul
				mov dl,1
			else3n:
			JMP stop2
		else2n:
			add al,dl		;daca nu am cifra 9, scad si sterg "CF-ul"
			mov dl,0
	stop2:
	add al,'0'	;transform in caracter
	mov a[si],al
	dec si
	
	cmp si,stop_sign		;daca am ajuns la inceputul numarului,gataaa, daca nu, continui
	JE stop
loop repeta
stop:

mov ah,09h
mov dx,offset a + 2
int 21h

mov ax, 4c00h
int 21h
code ends
end start