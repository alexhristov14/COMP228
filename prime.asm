section .data
    number db 5; the input value to evaluate if prime or not
    answer db 1; prime or not (1 = prime, 0 = not prime)
    prime_msg db "Number is prime", 0x0a;
    not_prime_msg db "Number is not prime", 0x0a;

section .text
    global _start

_start:
    mov al, [number]; al = number
    cmp al, 2;
    jl not_prime_fun; if al < 2, we know automatically not prime (base case)
    mov bl, 2; bl = divisor
    jmp check_if_prime_loop; subroutine for checking if our number is prime

check_if_prime_loop:
    mov dl, 0; will be used for remainder
    div bl; al / bl, dl = remainder
    cmp dl, 0;
    je not_prime_fun; if the remainder != 0, the number is not prime (not only divadable by 1 and itself only)
    inc bl; we try the next one, divisor++
    cmp bl, [number];
    je prime_fun;
    mov al, [number]; we put the number back, al = number
    jmp check_if_prime_loop;

not_prime_fun:
    mov dl, 19; The length of our string message
    mov cl, not_prime_msg; Our string buffer
    mov bl, 1; STDOUT (Screen)
    mov al, 4; syscall num for writing
    int 0x80; call the kernel
    jmp exit; we jump to the exit since it is no more prime

prime_fun:
    mov dl, 15; The length of our string message
    mov cl, prime_msg; Our string buffer
    mov bl, 1; STDOUT (Screen)
    mov al, 4; syscall num for writing
    int 0x80; call the kernel

exit:
    mov al, 1; set syscall to exit
    xor bl, bl; exit status -> 0
    int 0x80; call the kernel