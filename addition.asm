section .text
global _start
 
_start:
	mov eax, 10
	mov ebx, 5
	add eax, ebx ;addition
 
	mov eax, 1
	mov ebx, 0
	int 0x80