;****************************************************************************************************************************
; Program name: "Random Numbers"
; Purpose: This module displays the array in Hexadecimal and Scientific Decimal formats.
; Copyright (C) 2026 Tristan Chen
;
; Author information
;   Author name: Tristan Chen
;   Author email: tchen2006@csu.fullerton.edu
;
; File information
;   File name: show_array.asm
;   Language: X86 with Intel syntax (64-bit).
;   Assemble: nasm -f elf64 -o show.o show_array.asm
;****************************************************************************************************************************

; Purpose: Loops through the array and calls printf using a stack bridge for XMM0 values[cite: 98, 137].

global show_array
extern printf

segment .data
    ;%llX = 64-bit Hex, %e = Scientific Float, 10 = Newline
    format_str db "0x%llX    %.14e", 10, 0


segment .text

show_array:
    push rbp                                        
    mov  rbp, rsp                                    
    push rdi          
    push rsi         
    push r12          
    push r13          
    push r14
    push rbx                                          
    pushf             

    mov r12, rdi
    mov r13, rsi
    xor r14, r14
    
print:
    cmp r14, r13            
    jge done          

    ;get value for hex
    mov rsi, [r12 + r14*8]  ;load into rsi

    ;get value for float
    push rsi                
    movsd xmm0, [rsp]       
    pop rax               

    ;printf
    mov rdi, format_str     
    mov al, 1               
    

    sub rsp, 8              
    call printf             
    add rsp, 8

    inc r14           
    jmp print     

done:
    popf                                    
    pop rbx                                 
    pop r14
    pop r13
    pop r12
    pop rsi
    pop rdi
    pop rbp       
    ret   
