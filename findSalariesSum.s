.global findSalariesSum
.text
findSalariesSum:
    movl $0, %eax       # store the total salary SUM
    xor %rcx, %rcx
    
.L_sal_loop:
    cmpl %esi, %ecx
    jge .L_sal_done     # jump if Greater or Equal
    
    movq %rcx, %r8

    imulq $12, %r8      #  calculate the byte stride for array
    
    addl 8(%rdi, %r8), %eax 
                        
    incq %rcx           # increment the loop index variable by 1
    jmp .L_sal_loop     # jump back to the start of the loop
    
.L_sal_done:
    ret                 # loop finished