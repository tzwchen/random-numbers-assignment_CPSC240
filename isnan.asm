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
    mov eax, 1           ; false: not NaN
    ret

.is_nan:
    xor eax, eax         ; true: is NaN
    ret
