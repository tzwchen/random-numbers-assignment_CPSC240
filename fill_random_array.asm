;****************************************************************************************************************************
; Program name: "Random Numbers"
; Purpose: This module populates a 64-bit array with random bits from the hardware.
; Copyright (C) 2026 Tristan Chen
;
; Author information
;   Author name: Tristan Chen
;   Author email: tchen2006@csu.fullerton.edu
;
; File information
;   File name: fill_random_array.asm
;   Language: X86 with Intel syntax (64-bit).
;   Assemble: nasm -f elf64 -o fill.o fill_random_array.asm
;****************************************************************************************************************************

; Purpose: Uses RDRAND to generate high-entropy bits and validates them via isnan.asm[cite: 71].

global fill_random_array
extern isnan

segment .text
fill_random_array:
push rbp                                        
    mov  rbp, rsp                                    
    push rdi          
    push rsi         
    push r12          
    push r13          
    push r14
    push r11        
    push rbx                                          
    pushf             

    ;back up array and its max sign, and create a loop counter
    mov r12, rdi  ;arr
    mov r13, rsi  ;max sign
    xor r14, r14  ;loop counter


loop:
    cmp r14, r13 ;checks loop counter to arr
    jge done

random:
    rdrand rax ;generates number
    jnc random ;if cf =0 (hardware busy) retries again
    
    mov r11, rax 

    ;checks if number is nan
    push r11 ;put the random number into rbx so i dont lose it to the isnan return in rax
    movsd xmm0, [rsp]
    pop r10

    call isnan

    ;if nan generate new number
    cmp rax, 0
    jne random

    ;not a nan
    mov [r12 + r14*8], r11 ;stores number
    inc r14
    jmp loop

done:
popf                                    
    pop rbx                                 
    pop r11
    pop r14
    pop r13
    pop r12
    pop rsi
    pop rdi
    pop rbp       
    ret




