;check if is a nan
;nans have a property where if they are compared to each other like f != f it will be true
global isnan

segment .data

segment .bss

segment .text

push rbp                                        
mov  rbp,rsp                                    
push rdi                                          
push rsi                                          
push rdx                                          
push rcx                                         
push r8                                           
push r9                                           
push r10                                          
push r11                                          
push r12                                               
push rbx                                          
pushf  


isnan:
    ; argument is passed in xmm0 for x86-64 calling conventions
    ucomisd xmm0, xmm0   ; compare value to itself
    jp .is_nan           ; unordered means NaN
    mov rax, 1           ; false: not NaN
    ret

.is_nan:
    xor rax, rax         
    ret


popf                                    
pop rbx                                 
pop r12
pop r11                                 
pop r10                                 
pop r9                                 
pop r8                                  
pop rcx                                 
pop rdx                                 
pop rsi                                 
pop rdi                                 
pop rbp       
