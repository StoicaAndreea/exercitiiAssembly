;Se da cuvântul A. Sa se obtina în B cuvântul obtinut prin rotirea spre dreapta a lui A
;cu atâtea pozitii cât reprezinta numarul binar cuprins între bitii 7-11 ai lui A.
assume cs:code, ds:data
data segment
a dw 0000001000000000b
b dw ?
data ends

code segment
start:
mov ax, data
mov ds,ax
mov ax,a
and ax,0000111110000000b	;izolam bitii 7-11
mov cl,7	;primul bit izolat e 7           (e nr de pozitii pt a avea bitii la dreapta
ror ax,cl	;rotim ax cu cl pozitii, ca sa fie la dreapta

mov cl,al	;ramanem cu nr cu care trebuie sa rotim a la dreapta pt a obtine b
mov bx,a	; punem in bx pe a
ror bx,cl	;rotim cu nr din cl
mov b,bx	;punem rezultatul

mov ax, 4c00h
int 21h
code ends
end start

; rezultatul va fi 20h =>0000 0000 0010 0000