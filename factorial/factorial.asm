	global main
	extern printf
	section .text

; Calculate the factorial of rdi
fact:
	push rbp
	mov rbp, rsp
	mov rbx, qword [rbp + 16]
	cmp rbx, 1
	jle fact_set_1
	mov rcx, rbx
	dec rcx
	push rcx
	call fact
	mov rbx, qword [rbp + 16]
	mul rbx
	jmp fact_end
fact_set_1:
	mov rax, 1
fact_end:
	pop rbp
	ret 8
	
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
	push qword [num]
	call fact
	mov rdi, rax
	call printnum
	ret

message:
	db "%lu", 0x0A, 0x0D, 0

	section .data
result dq 0
num dq 15
