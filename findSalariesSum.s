.global findSalariesSum
.text
findSalariesSum:
    # 【函数签名】 int findSalariesSum(EMPLOYEE e[], int size);
    # 第一个参数 e (数组首地址的指针) 在 %rdi。
    # 第二个参数 size (数组的容量大小) 在 %esi。
    #
    # 【结构体内存布局分析】
    # typedef struct Employee {
    #     char name[8];    // 占用 8 字节，偏移量为 0
    #     int salary;      // 占用 4 字节，偏移量为 8
    # } EMPLOYEE;
    # 整个结构体尺寸为 8 + 4 = 12 字节。
    # 因为 12 字节既没有跨越特殊的内存对齐边界，也不是 2 的幂（2, 4, 8），
    # 我们不能使用 x86 内置的内存缩放因子 (scale factor) 自动乘 12，只能手动算偏移。
    # 
    # e[i] 的基地址 = %rdi + i * 12
    # e[i].salary 的地址 = e[i]的基址 + 8 = %rdi + i * 12 + 8
    #
    # 【工作流示例】
    # 当 i = 1 时（访问 e2 "sara", salary = 3000），计算：
    # 地址 = %rdi + 1 * 12 + 8 = %rdi + 20。
    
    movl $0, %eax       # 准备 %eax 用于存储总薪水 sum。初始化为 0。
    xor %rcx, %rcx      # %rcx 用于循环计数/索引 i。安全清零。
    
.L_sal_loop:
    cmpl %esi, %ecx     # 比较索引 i (%ecx) 与容量 size (%esi)。
    jge .L_sal_done     # 如果 i >= size，遍历完成，退出循环。
    
    movq %rcx, %r8      # 将当前的索引 i 备份到寄存器 %r8 中。
                        # 示例：当 i=1 时，%r8 = 1。
    imulq $12, %r8      # 手动计算跨度：%r8 = %r8 * 12。
                        # 示例：当 i=1 时，%r8 = 1 * 12 = 12。
    
    addl 8(%rdi, %r8), %eax 
                        # 基址 + 索引 + 偏移量 寻址法：
                        # 从地址 (%rdi + %r8 + 8) 处取出薪水值，并累加给 %eax。
                        # 示例：当 i=1 时，从 (%rdi + 12 + 8) 获取 3000 并累加到 sum 里。
                        
    incq %rcx           # 索引变量加一：i++。
    jmp .L_sal_loop     # 返回去处理下一个员工信息。
    
.L_sal_done:
    ret                 # 循环结束，%eax 中保存了总薪水，返回 [cite: 28]。