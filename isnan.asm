;****************************************************************************************************************************
; Program name: "Random Numbers"
; Purpose: This module checks if a 64-bit float bit pattern is a Not-a-Number (NaN).
; Copyright (C) 2026 Tristan Chen
;
; Author information
;   Author name: Tristan Chen
;   Author email: tchen2006@csu.fullerton.edu
;
; File information
;   File name: isnan.asm
;   Language: X86 with Intel syntax (64-bit).
;   Assemble: nasm -f elf64 -o isnan.o isnan.asm
;****************************************************************************************************************************

; Purpose: Uses ucomisd to determine if a value is unordered (NaN)[cite: 45].


;check if is a nan
;nans have a property where if they are compared to each other like f != f it will be true
global isnan

segment .data

segment .bss

segment .text


isnan:
    ; argument is passed in xmm0 for x86-64 calling conventions
    ucomisd xmm0, xmm0   ; compare value to itself
    jp .is_nan           ; unordered means NaN
    xor rax, rax           ; false: not NaN
    ret

.is_nan:
    mov rax, 1   
    ret


 
