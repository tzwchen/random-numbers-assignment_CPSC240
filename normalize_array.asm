;****************************************************************************************************************************
; Program name: "Random Numbers"
; Purpose: This module normalizes 64-bit bit patterns into the range 1.0 to 2.0.
; Copyright (C) 2026 Tristan Chen
;
; Author information
;   Author name: Tristan Chen
;   Author email: tchen2006@csu.fullerton.edu
;
; File information
;   File name: normalize_array.asm
;   Language: X86 with Intel syntax (64-bit).
;   Assemble: nasm -f elf64 -o normalize.o normalize_array.asm
;****************************************************************************************************************************

; Purpose: Uses btr and bts to hard-code the exponent bits for IEEE 754 compliance[cite: 68, 69].

global normalize_array

segment .text
push rbp                                        
mov  rbp,rsp                                    
push rdi                                          
push rsi                                          
push rdx                                          
push rcx                                         
push r12                                       
push r13
push rbx                                          
pushf               

;back up array and its max sign, and create a loop counter
mov r12, rdi  ;arr
mov r13, rsi  ;max sign
xor rcx, rcx  ;loop counter

loop:
    cmp rcx, r13 ;checks loop counter to arr
    jge done

    ;put value from array into rbx
    mov rbx, [r12 + rcx*8]

normalize:
;pain
btr rbx, 63
btr rbx, 62
bts rbx, 61
bts rbx, 60
bts rbx, 59
bts rbx, 58
bts rbx, 57
bts rbx, 56
bts rbx, 55
bts rbx, 54
bts rbx, 53
bts rbx, 52

;put modified rbx back into array
mov [r12 + rcx*8], rbx

inc rcx
jmp loop


done:
    popf
    pop rbx
    pop r13
    pop r12
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    pop rbp
    ret