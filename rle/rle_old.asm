	global main
	extern printf
	section .text
rle_start:
	default rel
	mov rax, arr
rle_loop:
	mov al, [rax]
	mov [chr], al
	cmp byte [chr], 0
	jle rle_end
	add rax, 2
	mov al, [rax]
	mov [reps], al
	add rax, 2
	sub byte [reps], '0'
	cmp byte [reps], 0
	jle rle_loop
	dec byte [reps]
	mov rax, [output_offset]
	mov rsi, result
	mov al, [rsi + rax]
	mov [chr], al
	inc byte [output_offset]
	jmp rle_loop
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
arr db "1,3,2,2",0
reps db 0
result db "hola",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
input_offset db 0
output_offset db 0
chr db 0
