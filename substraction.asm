section .data
    num1 dd 25
    num2 dd 15

section .text
global _start

_start:
    mov eax, [num1]
    mov ebx, [num2]
    sub eax, ebx


    mov eax, 1
    mov ebx, 0
    int 0x80