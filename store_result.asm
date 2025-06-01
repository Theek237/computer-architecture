section .data
    addition dd 0
    substraction dd 0
    num1 dd 20
    num2 dd 10

section .text
global _start

_start:
    mov eax, [num1]
    mov ebx, [num2]
    add eax, ebx
    mov [addition], eax
    mov eax, [num1]
    sub eax, ebx
    mov [substraction], eax

    mov eax, 1
    mov ebx, 0
    int 0x80
