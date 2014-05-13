; Prints lines of colors in screen
; Must be compiled in NASM bin format
; and then written to memory
;
; nasm screen.asm -l screen.lst
;
	org 0x0100 ; Not useful in linux
main:
	mov AL, 0x13
	mov AH, 0
	int 0x10 
	mov bx, colores
	mov CX, 10
for1:
	mov AL, byte [bx]
	mov DX, 20
for2:
	mov AH, 0x0C
	int 0x10
	inc DX 
	cmp DX, 100 
	jne for2
	inc bx 
	add CX, 5 
	cmp CX, 40
	jne for1
	ret

colores	db 0b1100, 0b1010, 0b1001, 0b1110, 0b1111, 0b0111
