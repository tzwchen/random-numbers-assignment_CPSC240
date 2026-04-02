;****************************************************************************************************************************
; Program name: "Random Numbers"
; Purpose: This module manages the flow of the program, user input, and calls to sub-modules.
; Copyright (C) 2026 Tristan Chen
;
; Author information
;   Author name: Tristan Chen
;   Author email: tchen2006@csu.fullerton.edu
;
; File information
;   File name: executive.asm
;   Language: X86 with Intel syntax (64-bit).
;   Assemble: nasm -f elf64 -o executive.o executive.asm
;****************************************************************************************************************************

; Purpose: Orchestrates the input of name/title and calls the generation, normalization, and sorting modules.


extern printf
extern scanf
extern fgets
extern stdin
extern fill_random_array
extern show_array
extern normalize_array
extern quickSort

global executive

segment .data
    ;prompt strings
    prompt_name  db "Please enter your name: ", 0
    prompt_title db "Please enter your title (Mr,Ms,Sargent,Chief,Project Leader,etc): ", 0
    greet_fmt    db "Nice to meet you %s %s", 10, 0
    
    info_msg     db "This program will generate 64-bit IEEE float numbers.", 10, 0
    prompt_count db "How many numbers do you want.  Today’s limit is 100 per customer. ", 0
    count_fmt    db "%ld", 0  ; format for scanning a long integer
    
    stored_msg   db "Your numbers have been stored in an array. Here is that array.", 10, 0
    norm_msg     db "The array will now be normalized to the range 1.0 to 2.0. Here is the normalized array", 10, 0
    sort_msg     db "The array will now be sorted", 10, 0
    
    goodbye_fmt  db "Good bye %s. You are welcome any time.", 10, 10, 0
    
    header       db "IEEE754             Scientific Decimal", 10, 0

segment .bss
    ;buffers for input
    name_buf  resb 64
    title_buf resb 64
    num_count resq 1
    array     resq 100  ;reserve space for 100 doubles

segment .text
executive:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push rbx
    pushf

    ;get name
    mov rdi, prompt_name
    xor al, al
    call printf
    
    mov rdi, name_buf
    mov rsi, 64
    mov rdx, [stdin]  
    call fgets
    ;remove newline from fgets if necessary 

    ;get title
    mov rdi, prompt_title
    xor al, al
    call printf
    
    mov rdi, title_buf
    mov rsi, 64
    mov rdx, [stdin]
    call fgets

    ;greet
    mov rdi, greet_fmt
    mov rsi, title_buf
    mov rdx, name_buf
    xor al, al
    call printf

    ;get num count
    mov rdi, info_msg
    xor al, al
    call printf

    mov rdi, prompt_count
    xor al, al
    call printf

    mov rdi, count_fmt
    mov rsi, num_count
    xor al, al
    sub rsp, 8
    call scanf
    add rsp, 8 

    ;arr stuff
    mov r12, array      ;pointer to array
    mov r13, [num_count] ;number of elements

    ;fill
    mov rdi, r12
    mov rsi, r13
    call fill_random_array

    ;show initial
    mov rdi, stored_msg
    xor al, al
    call printf
    mov rdi, header
    xor al, al
    call printf
    mov rdi, r12
    mov rsi, r13
    call show_array

    ;normalize
    mov rdi, r12
    mov rsi, r13
    call normalize_array

    ;show normalized
    mov rdi, norm_msg
    xor al, al
    call printf
    mov rdi, header
    xor al, al
    call printf
    mov rdi, r12
    mov rsi, r13
    call show_array

    ;sort
    mov rdi, r12        ; array
    mov rsi, 0          ; low index
    mov rdx, r13
    sub rdx, 1          ; high index (count - 1)
    call quickSort

    ;show sorted
    mov rdi, sort_msg
    xor al, al
    call printf
    mov rdi, header
    xor al, al
    call printf
    mov rdi, r12
    mov rsi, r13
    call show_array

    ;bye
    mov rdi, goodbye_fmt
    mov rsi, title_buf
    xor al, al
    call printf

    ;end
    xor rax, rax
    popf
    pop rbx
    pop r14
    pop r13
    pop r12
    pop rbp
    ret
