.global sumOfPowers      
.text  

sumOfPowers:
    
    movl $0, %eax           # initialize the accumulator to 0
    movl $1, %ecx           # initialize the loop to 1
    
.L_loop_start:              # start loop
    cmpl %edi, %ecx        
    jg .L_loop_end  
    
    movl %ecx, %r8d  
    imull %ecx, %r8d
    
    addl %r8d, %eax         # add the squared value to the running total in %eax
    
    incl %ecx               # increment the loop counter 'i' by 1
    jmp .L_loop_start       # jump back to the start of the loop
    
.L_loop_end:                # end of the loop.
    ret 
