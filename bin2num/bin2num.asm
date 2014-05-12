; Transforms a string of ones and zeros
; into an unsigned number
	global main
	extern printf
	section .text
bin2num:
	push rbp
	mov rbp, rsp
	mov rax, 0 ; Result
	mov rdi, 0 ; index
	mov rdx, qword [rbp + 24] ; count
	mov rcx, qword [rbp + 16] ; input
bin2num_loop:
	cmp rdi, rdx    ; Check if there are characters left
	jge bin2num_end ; If not, jump to the end
	shl rax, 1      ; Multiply the result by two
	cmp byte [rcx + rdi], '0' ; Check if next char is a zero
	jz bin2num_no_add         ; If '0', no add
	add rax, 1                ; If '1', add and go to loop
bin2num_no_add:
	inc rdi         ; Increment the index
	jmp bin2num_loop
bin2num_end:
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
	push rbp
	mov rbp, rsp
	push qword [len]
	push input
	call bin2num
	mov rdi, rax
	call printnum
	mov rax, 0
	add rsp, 16
	pop rbp
	ret

message:
	db "Result: %u", 0x0A, 0x0D, 0

	section .data
input db "001101",0
len dq 6
