;check if is a nan
;nans have a property where if they are compared to each other like f != f it will be true
global isnan

segment .data

segment .bss

segment .text


;Block that backs up almost all GPRs
;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
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
push xmm0                                          
push xmm1                                                
push rbx                                          
pushf                                            

;pass value to xmm0
mov xmm0, rdi

check:
ucomisd xmm0, xmm0 ;comp with each other
jp .is_nan ;jump if parity
mov rax, 0 ;return false

is_nan:
mov rax, -1 ;return true

popf                                    
pop rbx                                 
pop xmm1
pop xmm0
pop r11                                 
pop r10                                 
pop r9                                 
pop r8                                  
pop rcx                                 
pop rdx                                 
pop rsi                                 
pop rdi                                 
pop rbp                                 


