global fill_random_array
segment .data



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

random:
    rdrand rax ;generates number
    jnc random ;if cf =0 (hardware busy) retries again
    
    ;checks if number is nan
    mov rdi, rax 
    call isnan

    ;if nan generate new number
    cmp rax, 0
    jne .random

    ;not a nan
    mov [r12 + rcx*8], rbx ;stores number
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




