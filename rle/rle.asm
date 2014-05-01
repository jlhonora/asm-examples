	global main
	extern printf
	section .text
rle_start:
	default rel
	mov rax, arr
rle_loop:
	mov bl, [rax]
	mov [chr], bl
	cmp byte [chr], 0
	jle rle_end
	add rax, 2
	mov bl, [rax]
	add rax, 2
	mov [reps], bl
	sub byte [reps], 48
rle_repeat:
	cmp byte [reps], 0
	jle rle_loop
	mov rcx, [output_offset]
	mov rsi, result
	mov bl, [chr]
	mov [rsi + rcx], bl
	add qword [output_offset], 1
	sub byte [reps], 1
	jmp rle_repeat
rle_end:
	ret

	
; Prints the string stored
; in rdi register
printstr:
	mov rsi, rax
	mov rdi, message ; Pass format
	mov rax, 0
	call printf
	ret

main:
	call rle_start
	mov rax, result
	call printstr
	ret

message:
	db "Result: %s", 0x0A, 0x0D, 0

	section .data
arr db "1,3,2,6",0
reps db 0
result db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
output_offset dq 0
chr db 0
