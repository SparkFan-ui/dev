.global findPaymentsSum
.text
findPaymentsSum:
    
    movl $0, %eax               # initialize %eax to 0
                                
    xor %rcx, %rcx              # initialize the loop index 'i' to 0

    
.L_pay_loop:
    cmpl %esi, %ecx
    
    jge .L_pay_done             # jump if Greater or Equal
    
    addl 8(%rdi, %rcx, 4), %eax 
    
    incl %ecx                   # increment the loop index - i++.
    
    jmp .L_pay_loop             #  jump back to the start of the loop
    
.L_pay_done:
    ret                         # loop finished
    