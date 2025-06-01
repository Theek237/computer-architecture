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

### Common System Calls (32-bit)

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

### Status Flags Register (EFLAGS)

| Flag | Bit | Name | Set When | Description |
|------|-----|------|----------|-------------|
| CF | 0 | Carry Flag | Carry/borrow occurs | Unsigned overflow |
| ZF | 6 | Zero Flag | Result is zero | Last operation = 0 |
| SF | 7 | Sign Flag | Result is negative | Most significant bit = 1 |
| OF | 11 | Overflow Flag | Signed overflow | Result too big for register |
| PF | 2 | Parity Flag | Even number of 1s | Low byte has even parity |
| AF | 4 | Auxiliary Flag | Carry from bit 3 | BCD arithmetic |

## Instructions and Flags

### Arithmetic Instructions

| Instruction | Example | Flags Affected | Description |
|-------------|---------|----------------|-------------|
| add | `add eax, 5` | CF, ZF, SF, OF, PF, AF | Add values |
| sub | `sub eax, 3` | CF, ZF, SF, OF, PF, AF | Subtract values |
| mul | `mul ebx` | CF, OF | Multiply (unsigned) |
| div | `div ebx` | undefined | Divide (unsigned) |
| inc | `inc eax` | ZF, SF, OF, PF, AF | Increment by 1 |
| dec | `dec eax` | ZF, SF, OF, PF, AF | Decrement by 1 |
| neg | `neg eax` | CF, ZF, SF, OF, PF, AF | Negate (two's complement) |

### Comparison Instructions

| Instruction | Example | Flags Affected | Description |
|-------------|---------|----------------|-------------|
| cmp | `cmp eax, 5` | CF, ZF, SF, OF, PF, AF | Compare (subtract without storing) |
| test | `test eax, eax` | CF=0, OF=0, ZF, SF, PF | Bitwise AND (without storing) |

### Logical Instructions

| Instruction | Example | Flags Affected | Description |
|-------------|---------|----------------|-------------|
| and | `and eax, 0xFF` | CF=0, OF=0, ZF, SF, PF | Bitwise AND |
| or | `or eax, 0x10` | CF=0, OF=0, ZF, SF, PF | Bitwise OR |
| xor | `xor eax, eax` | CF=0, OF=0, ZF, SF, PF | Bitwise XOR |
| not | `not eax` | none | Bitwise NOT |
| shl | `shl eax, 2` | CF, ZF, SF, OF, PF | Shift left |
| shr | `shr eax, 2` | CF, ZF, SF, OF, PF | Shift right |

## Conditional Jumps

### Jump Instructions Based on Flags

| Instruction | Full Name | Condition | Flags Checked | Description |
|-------------|-----------|-----------|---------------|-------------|
| je / jz | Jump if Equal/Zero | ZF = 1 | ZF | Jump if last result was zero |
| jne / jnz | Jump if Not Equal/Not Zero | ZF = 0 | ZF | Jump if last result was not zero |
| js | Jump if Sign | SF = 1 | SF | Jump if last result was negative |
| jns | Jump if Not Sign | SF = 0 | SF | Jump if last result was positive |
| jc | Jump if Carry | CF = 1 | CF | Jump if carry occurred |
| jnc | Jump if Not Carry | CF = 0 | CF | Jump if no carry |
| jo | Jump if Overflow | OF = 1 | OF | Jump if overflow occurred |
| jno | Jump if Not Overflow | OF = 0 | OF | Jump if no overflow |

### Conditional Jumps for Signed Numbers

| Instruction | Full Name | Condition | Flags Checked | Use Case |
|-------------|-----------|-----------|---------------|----------|
| jg / jnle | Jump if Greater | ZF=0 AND SF=OF | ZF, SF, OF | if (a > b) |
| jge / jnl | Jump if Greater or Equal | SF = OF | SF, OF | if (a >= b) |
| jl / jnge | Jump if Less | SF ≠ OF | SF, OF | if (a < b) |
| jle / jng | Jump if Less or Equal | ZF=1 OR SF≠OF | ZF, SF, OF | if (a <= b) |

### Conditional Jumps for Unsigned Numbers

| Instruction | Full Name | Condition | Flags Checked | Use Case |
|-------------|-----------|-----------|---------------|----------|
| ja / jnbe | Jump if Above | CF=0 AND ZF=0 | CF, ZF | if (a > b) unsigned |
| jae / jnb | Jump if Above or Equal | CF = 0 | CF | if (a >= b) unsigned |
| jb / jnae | Jump if Below | CF = 1 | CF | if (a < b) unsigned |
| jbe / jna | Jump if Below or Equal | CF=1 OR ZF=1 | CF, ZF | if (a <= b) unsigned |

## Conditional Jump Examples

### Example 1: Simple Comparison
```assembly
mov eax, 10
mov ebx, 5
cmp eax, ebx        ; Compare eax with ebx (10 - 5)
jg greater_label    ; Jump if eax > ebx (jump taken)
mov ecx, 1          ; This won't execute
jmp end
greater_label:
    mov ecx, 2      ; This will execute
end:
```

### Example 2: Loop with Counter
```assembly
mov ecx, 5          ; Counter
loop_start:
    ; Do something here
    dec ecx         ; Decrement counter
    jnz loop_start  ; Jump if not zero (continue loop)
    ; Loop finished
```

### Example 3: Checking for Zero
```assembly
mov eax, 0
test eax, eax       ; Check if eax is zero
jz is_zero         ; Jump if zero flag is set
mov ebx, 1         ; eax is not zero
jmp end
is_zero:
    mov ebx, 0     ; eax is zero
end:
```

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
