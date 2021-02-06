;10. Sa se citeasca de la tastatura numele unui fisier. Sa se verifice daca dimensiunea fisierului este multiplu de 13, 
;si in caz negativ sa se completeze fisierul cu un numar minim de octeti 0 astfel incat dimensiunea fisierului sa devina multiplu de 13.

assume cs:code, ds:data
data segment
	iden dw ?
	interm db 00000000
	res dw ?
	Mesaj db 'Introduceti numele fisierului: $'
	NumeFis db 12, ?, 12 dup (?) ;in acest sir de caractere se va retine numele fisierului citit de la tastatura
	temp db 100 dup (?), '$'     ;sir de caractere utilizat pentru citirea a cate 100 de caractere din fisier
	;mesaje de eroare
	EroareDeschidere db 10, 13, 'Fisierul nu exista.', 10, 13, '$'
	EroareCitire db 10, 13, 'Nu se poate citi din fisier. ', 10, 13, '$'
	LinieNoua db 10,13,'$'
data ends

code segment
start:

mov ax, data
mov ds, ax

;afisam sirul de caractere Mesaj
	mov ah, 09h 
	mov dx, offset Mesaj 
	int 21h
	
;citirea de la tastatura a numelui fisierului 
	mov ah, 0Ah
	mov dx, offset NumeFis
	int 21h

;transformam in ASCIIZ
	mov al, byte ptr NumeFis[1] 
	mov ah,0 
	mov si, ax 
	mov NumeFis[si+2], 0 
	
	mov ah, 3dh ;deschidem fişierul
	mov al, 2 ;deschidem fişierul pentru citire si scriere
	mov dx, offset NumeFis+2 ;în dx punem offset-ul şirului de caractere care reprezintă numele fişierului
	int 21h ;funcţia 3dh returnează în ax identificatorul fişierului, dacă deschiderea fişierului s-a efectuat cu succes
	mov iden, ax
	jc EtEroareDeschidere ;dacă CF e setat după apelul întreruperii, înseamnă că am avut eroare la deschiderea fişierului

	EtEroareDeschidere: ;afişarea unui mesaj corespunzător apariţiei erorii la deschiderea fişierului
	mov ah, 09h 
	mov dx, offset EroareDeschidere
	int 21h
	jmp Sfarsit
	
	
	InchidereFisier:
	mov ah, 3Eh ;funcţie pentru închiderea unui fişier al cărui identificator se află în registrul bx
	int 21h 
	
	mov al, byte ptr NumeFis[1]
	mov ah, 0
	mov bx, 13
	div bx   
	cmp ah, 0
	JE ram_then
	JNE ram_else
	ram_then:
		JMP Sfarsit
	ram_else:
		mov al, ah
		cbw
		mov res, ax
		cbw
		mov ah, 40h
		mov bx, iden
		mov cx, res    
		mov dx, offset interm
		int 21h		
	Sfarsit:
	JMP InchidereFisier
	mov ax,4c00h ;terminarea programului
	int 21h
	
code ends
end start
