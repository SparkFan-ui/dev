.global compareAges
.text
compareAges:
    # access a->age
    # read the 4-byte value at the memory address
    movl 4(%rdi), %eax  
    
    # b->age access and compare it with %eax
    cmpl 4(%rsi), %eax  
    
    # Set byte if equal
    sete %al            
    
    # move with zero-extend from the 8-bit %al register to the 32-bit %eax register
    movzbl %al, %eax    
    
    # return to the caller
    ret
    