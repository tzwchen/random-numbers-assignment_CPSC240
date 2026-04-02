
segment .data
    ;%llX = 64-bit Hex, %e = Scientific Float, 10 = Newline
    format_str db "0x%llX    %.14e", 10, 0


segment .text
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
    cmp rcx, r13            
    jge done          

    ;get value for hex
    mov rsi, [r12 + rcx*8]  ;load into rsi

    ;get value for float
    push rsi                
    movsd xmm0, [rsp]       
    pop rdi                

    ;printf
    mov rdi, format_str     
    mov al, 1               
    

    sub rsp, 8              
    call printf             
    add rsp, 8

    inc rcx           
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
