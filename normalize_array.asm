

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