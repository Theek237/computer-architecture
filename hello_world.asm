section .data
	; Define a string containing "Hello World!" followed by a newline character (0x0A)
	optext db 'Hello World!',0x0A
	; Calculate the length of the string by subtracting the start address from current address
	optext_length equ $ - optext
	
section .text
	; Declare _start as a global symbol (entry point for the program)
	global _start
	
_start:
	; System call for sys_write (system call number 4)
	mov eax, 4
	; File descriptor 1 (stdout - standard output)
	mov ebx, 1
	; Pointer to the string buffer (optext)
	mov ecx, optext
	; Number of bytes to write (length of the string)
	mov edx, optext_length
	; Invoke system call interrupt
	int 0x80
	
	; System call for sys_exit (system call number 1)
	mov eax, 1
	; Exit status code (0 means successful termination)
	mov ebx, 0
	; Invoke system call interrupt to exit the program
	int 0x80