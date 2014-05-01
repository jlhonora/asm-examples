; Multiply two numbers stored as
; registers
; @author Jose L. Honorato
; @date May 1st, 2014

	global main
	extern printf
	section .text
mult:
	push rbp
	mov rbp, rsp
	mov eax, 0
mult_loop:
	cmp edi, 0
	je mult_end
	add eax, esi
	sub edi, 1
	jmp mult_loop
mult_end:
	pop rbp
	ret
	
main:
	push rbp
	mov rbp, rsp
	mov edi, 7
	mov esi, 5
	call mult
	mov esi, eax
	call printnum
	pop rbp
	ret

printnum:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	mov rdi, message
	mov esi, esi
	mov dword [rbp - 4], 0
	mov al, 0
	call printf
	mov esi, 0
	mov dword [rbp - 8], eax
	mov eax, esi
	add rsp, 8
	pop rbp
	ret
	
message:
	db "%d", 0x0A, 0x0D, 0
