;check if is a nan
;nans have a property where if they are compared to each other like f != f it will be true
global isnan

segment .text

isnan:
    ucomisd xmm0, xmm0   ; compare value to itself
    jp .is_nan           ; unordered means NaN
    xor eax, eax         ; false: not NaN
    ret

.is_nan:
    mov eax, 1           ; true: is NaN
    ret
