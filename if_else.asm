section .data   
    equal_msg db 'Equals!', 0x0A
    equal_len equ $ - equal_msg

    unequal_msg db 'Not Equal!', 0x0A
    unequal_len equ $ - unequal_msg

section .text
    global _start

_start:
    mov eax, 10
    mov ebx, 10
    cmp eax, ebx ;ZF set eax-ebx=0

    jne not_equal_label


equal_label:
    mov eax, 4 ;sys_write
    mov ebx, 1 ;stdout
    mov ecx, equal_msg
    mov edx, equal_len
    int 0x80
    jmp exit_program

not_equal_label:
    mov eax, 4
    mov ebx, 1
    mov ecx, unequal_msg
    mov edx, unequal_len
    int 0x80
    jmp exit_program

exit_program:
    mov eax, 1
    mov ebx, 0
    int 0x80