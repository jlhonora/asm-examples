; Multiply two numbers stored as
; memory variables
; @author Jose L. Honorato
; @date May 1st, 2014

	global main
	extern printf
	section .text
mult:
	push rbp
	mov rbp, rsp
	mov dword [result], 0
mult_loop:
	cmp dword [op1], 0
	jle mult_end
	; We can't do the following: 
	; add [result], [op2]
	mov edi, dword [op2]
	add dword [result], edi
	sub dword [op1], 1
	jmp mult_loop
mult_end:
	pop rbp
	ret
	
main:
	push rbp
	mov rbp, rsp
	call mult
	mov edi, dword [result]
	call printnum
	pop rbp
	ret

printnum:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	mov esi, edi
	mov rdi, message
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

	section .data
op1 dd 6
op2 dd 7
result dd 0
