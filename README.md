# Computer Architecture and Organization

A repository for learning computer architecture and assembly programming.

## What's Inside

- Assembly language programs
- System call examples
- Basic computer architecture concepts

## Getting Started

### What You Need

```bash
# Install these on Ubuntu/Linux
sudo apt install nasm gcc
```

### Run Your First Program

1. Clone this repo:
   ```bash
   git clone https://github.com/Theek237/computer-architecture.git
   cd computer-architecture
   ```

2. Compile and run:
   ```bash
   nasm -f elf32 hello.asm -o hello.o
   ld -m elf_i386 hello.o -o hello
   ./hello
   ```

## Basic Assembly Example

```assembly
section .data
    msg db 'Hello World!', 0x0A
    msg_len equ $ - msg

section .text
    global _start

_start:
    ; Print message
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg        ; message
    mov edx, msg_len    ; length
    int 0x80

    ; Exit program
    mov eax, 1          ; sys_exit
    mov ebx, 0          ; success
    int 0x80
```

## System Calls Reference

### Common System Calls (32-bit Linux)

| EAX | System Call | EBX | ECX | EDX | Description |
|-----|-------------|-----|-----|-----|-------------|
| 1 | sys_exit | exit_status | - | - | End the program |
| 3 | sys_read | file_descriptor | buffer | count | Read from file/keyboard |
| 4 | sys_write | file_descriptor | buffer | count | Write to file/screen |
| 5 | sys_open | filename | flags | mode | Open a file |
| 6 | sys_close | file_descriptor | - | - | Close a file |
| 20 | sys_getpid | - | - | - | Get process ID |
| 39 | sys_mkdir | pathname | mode | - | Create directory |
| 40 | sys_rmdir | pathname | - | - | Remove directory |

### File Descriptors

| Number | Name | Description |
|--------|------|-------------|
| 0 | stdin | Standard input (keyboard) |
| 1 | stdout | Standard output (screen) |
| 2 | stderr | Standard error (screen) |

### File Open Flags

| Flag | Value | Description |
|------|-------|-------------|
| O_RDONLY | 0 | Read only |
| O_WRONLY | 1 | Write only |
| O_RDWR | 2 | Read and write |
| O_CREAT | 64 | Create if doesn't exist |
| O_TRUNC | 512 | Clear file content |
| O_APPEND | 1024 | Add to end of file |

### File Permissions

| Permission | Number | Description |
|------------|--------|-------------|
| rwxrwxrwx | 777 | Everyone can read/write/execute |
| rwxr-xr-x | 755 | Owner: all, Others: read+execute |
| rw-rw-rw- | 666 | Everyone can read+write |
| rw-r--r-- | 644 | Owner: read+write, Others: read only |

## CPU Registers (32-bit)

### General Purpose Registers

| Register | Name | Common Use |
|----------|------|------------|
| EAX | Accumulator | System call number, return values |
| EBX | Base | System call parameter 1 |
| ECX | Counter | System call parameter 2, loop counter |
| EDX | Data | System call parameter 3 |
| ESI | Source Index | Source pointer for string operations |
| EDI | Destination Index | Destination pointer for string operations |
| ESP | Stack Pointer | Points to top of stack |
| EBP | Base Pointer | Points to base of current stack frame |

### Instruction Examples

| Instruction | Example | Description |
|-------------|---------|-------------|
| mov | `mov eax, 4` | Copy value to register |
| add | `add eax, 5` | Add values |
| sub | `sub eax, 3` | Subtract values |
| int | `int 0x80` | System call interrupt |
| cmp | `cmp eax, 0` | Compare values |
| jmp | `jmp label` | Jump to label |
| je | `je label` | Jump if equal |
| jne | `jne label` | Jump if not equal |

## Assembly Directives

| Directive | Example | Description |
|-----------|---------|-------------|
| db | `msg db 'Hello'` | Define byte(s) |
| dw | `num dw 1234` | Define word (2 bytes) |
| dd | `val dd 12345678` | Define double word (4 bytes) |
| equ | `len equ $ - msg` | Define constant |
| global | `global _start` | Make label visible to linker |
| section | `section .data` | Define program section |

## Number Systems

| Decimal | Binary | Hexadecimal | Octal |
|---------|--------|-------------|-------|
| 0 | 0000 | 0x0 | 0o0 |
| 1 | 0001 | 0x1 | 0o1 |
| 10 | 1010 | 0xA | 0o12 |
| 15 | 1111 | 0xF | 0o17 |
| 16 | 10000 | 0x10 | 0o20 |
| 255 | 11111111 | 0xFF | 0o377 |

## Error Codes

| Code | Name | Description |
|------|------|-------------|
| 0 | Success | No error |
| -1 | EPERM | Permission denied |
| -2 | ENOENT | File not found |
| -9 | EBADF | Bad file descriptor |
| -13 | EACCES | Access denied |
| -22 | EINVAL | Invalid argument |



---
