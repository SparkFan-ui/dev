.global sumOfPowers
.text
sumOfPowers:
    # 【函数签名】 int sumOfPowers(int n);
    # 在 x86-64 Linux 调用约定中，第一个参数 n (32位整型) 存放在 %edi 寄存器中。
    # 返回值将被放置在 %eax 寄存器中。
    #
    # 【工作流示例】
    # 假设 C 语言调用 sumOfPowers(3) [cite: 15, 16]。此时 %edi 初始值为 3。
    # 我们需要计算 1*1 + 2*2 + 3*3 = 14，并将 14 放入 %eax。
    
    movl $0, %eax       # %eax 用作累加器 (sum)。将其初始化为 0。
                        # 示例：当前 sum = 0
    movl $1, %ecx       # %ecx 用作循环的计数器变量 (i)。从 1 开始计算。
                        # 示例：当前 i = 1
    
.L_loop_start:
    cmpl %edi, %ecx     # 比较计数器 %ecx (i) 和目标值 %edi (n)。
    jg .L_loop_end      # 如果 i > n (Jump if Greater)，说明计算完毕，跳出循环。
                        # 示例：当 i 增加到 4，而 n 是 3 时，4 > 3，跳转到结束。
    
    movl %ecx, %r8d     # 将当前的计数器 i 复制到一个临时寄存器 %r8d 中，准备进行乘法。
                        # 示例：在 i=3 的那一轮，%r8d = 3。
    imull %ecx, %r8d    # 执行乘法：%r8d = %r8d * %ecx (计算 i 的平方)。
                        # 示例：此时 %r8d = 3 * 3 = 9。
    
    addl %r8d, %eax     # 将平方后的结果累加到总和 %eax 中。
                        # 示例：如果之前的 sum 是 5 (即 1+4)，现在的 sum = 5 + 9 = 14。
    
    incl %ecx           # 计数器递增：i++。
    jmp .L_loop_start   # 无条件跳转回循环的起点，进行下一次判定。
    
.L_loop_end:
    ret                 # 循环结束返回。此时 %eax 里存着 14，完美的符合 C 语言的 return 规范。