	global main
	extern printf
	section .text
mult:
	; TODO: Use ABI for reg cleanup
	; esi and edi as operands
	; result in eax
	mov rax, 0
mult_loop:
	cmp rdi, 0
	je mult_end
	add rax, rsi
	sub rdi, 1
	jmp mult_loop
mult_end:
	ret

; Calculate the factorial of rdi
; Explicar naked functions
fact:
	mov qword [result], rdi
fact_loop:
	cmp rdi, 1
	jle fact_end
	mov rsi, qword [result]
	sub rdi, 1
	push rdi
	call mult
	pop rdi
	mov qword [result], rax
	call fact_loop
fact_end:
	mov rax, qword [result]
	ret
	
; Prints the number stored
; in rdi register
printnum:
	push rbp
	mov rbp, rsp
	sub rsp, 8
	mov rsi, rdi
	mov rdi, message
	mov qword [rbp - 8], 0
	mov al, 0
	call printf
	mov rsi, 0
	mov rax, rsi
	add rsp, 8
	pop rbp
	ret

main:
	mov rdi, qword [num]
	call fact
	mov rdi, rax
	call printnum
	ret

message:
	db "%d", 0x0A, 0x0D, 0

	section .data
result dq 0
num dq 8
