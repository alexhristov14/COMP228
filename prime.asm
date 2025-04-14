; Group Members
; Alexander Hristov ID 40278983


; TERMINAL COMMANDS USED
; nasm -f elf32 prime.asm -o prime.o
; ld -m elf_i386 prime.o -o prime   
; ./prime

section .data
    number dd 10; the input value to evaluate if prime or not
    answer db 1; prime or not (1 = prime, 0 = not prime)
    prime_msg db "Number is prime", 0x0a;
    not_prime_msg db "Number is not prime", 0x0a;

section .text
    global _start

_start:
    mov eax, [number]; eax = number
    cmp eax, 2; eax - 2 (Basically if eax < 2)
    jl not_prime_fun; if eax < 2, we know automatically not prime (base case)
    mov ebx, 2; ebx = divisor
    jmp check_if_prime_loop; function for checking if our number is prime

check_if_prime_loop:
    mov eax, [number]; we put the number (back) to test the next ith number (al = number)
    xor edx, edx; reset the remainder to 0
    div ebx; eax / ebx, edx = remainder
    cmp edx, 0; we check if its divisible by ebx
    je not_prime_fun; if the remainder != 0, the number is not prime (not only divisble by 1 and itself only)
    inc ebx; we try the next one, divisor++
    cmp ebx, [number]; We check if we have reached the number itself 
    je prime_fun; if we have reached, we know it's prime
    jmp check_if_prime_loop; we loop again until either we reach our initial number, or we find a divisor

not_prime_fun:
    mov edx, 21; The length of our string message
    mov ecx, not_prime_msg; Our string buffer
    mov ebx, 1; STDOUT (Screen)
    mov eax, 4; syscall num for writing
    int 0x80; call the kernel
    jmp exit; we jump to the exit since it is no more prime

prime_fun:
    mov edx, 15; The length of our string message
    mov ecx, prime_msg; Our string buffer
    mov ebx, 1; STDOUT (Screen)
    mov eax, 4; syscall num for writing
    int 0x80; call the kernel

exit:
    mov eax, 1; set syscall to exit
    xor ebx, ebx; exit status -> 0
    int 0x80; call the kernel