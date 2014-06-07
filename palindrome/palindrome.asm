	global main
	extern printf

; Using Intel syntax
section .text

is_palindrome:
	push rbp
	mov rbp, rsp
	; Input string
	mov rdi, qword [rbp + 24]
	; Length of string
	mov rdx, qword [rbp + 16]
	; Length / 2 for easier handling
	mov rcx, rdx
	shr rcx, 1
	mov rax, 1
palindrome_start:
	cmp rcx, 0
	jl palindrome_end
	; The index is len - idx - 1
	mov rbx, rdx
	sub rbx, rcx
	sub rbx, 1
	mov bl, byte [rdi + rbx]
	cmp byte [rdi + rcx], bl
	jne palindrome_failed
	dec rcx
	jmp palindrome_start
palindrome_failed:
	mov rax, 0
palindrome_end:
	pop rbp
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
	; Pass the values through the stack
	push qword input
	push qword [len]
	call is_palindrome
	; Restore pushed values
	add rsp, 16
	mov rdi, rax
	call printnum
	ret
	
section .data

input db 'aacbcaa', 0
len dq 7
message db 'Result: %d', 0x0A, 0x0D, 0
