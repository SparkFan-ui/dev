.global findPaymentsSum
.text
findPaymentsSum:
    # 【函数签名】 int findPaymentsSum(CUSTOMER* c, int num_of_pamyments);
    # 第一个参数 c (指针) 在 %rdi，第二个参数 num_of_pamyments (32位整型) 在 %esi。
    # 
    # 【结构体内存布局分析】
    # 回顾上面的 CUSTOMER 结构体，payments 数组从偏移量 8 的位置开始。
    # 因为它是一个 int 数组，每个元素大小是 4 字节。
    # 所以 payments[i] 的精确地址公式是：%rdi (基址) + 8 (起始偏移) + i * 4。
    #
    # 【工作流示例】
    # 测试用例中，数组总长度是 5。当我们要找 payment[2] (即 2000) 时：
    # 地址为 %rdi + 8 + 2 * 4 = %rdi + 16。
    
    movl $0, %eax       # %eax 用作返回的总和 sum，初始化为 0。
                        # 示例：sum = 0
    xor %rcx, %rcx      # 用 64位寄存器 %rcx 做索引 (i)，用 xor 指令清零比 mov 高效，同时保证高位干净。
                        # 示例：i = 0
    
.L_pay_loop:
    cmpl %esi, %ecx     # 将索引 i (%ecx的低32位) 与数组长度 num_of_pamyments (%esi) 进行比较。
    jge .L_pay_done     # 如果 i >= num_of_pamyments (Jump if Greater or Equal)，数组遍历结束，跳出。
                        # 示例：当 i=5 时，循环结束。
    
    # 【复杂内存寻址】：8(%rdi, %rcx, 4) 代表 地址 = %rdi + %rcx * 4 + 8
    # 这条指令一步到位完成了：数组基址定位 + 元素跨度计算 + 结构体字段偏移
    addl 8(%rdi, %rcx, 4), %eax 
                        # 取出计算出来的内存地址中的 32位数据，并累加到 %eax 里。
                        # 示例：第一轮 i=0 时，读取 8(%rdi)，把 payments[0] 的 1500 加上去，sum = 1500。
                        # 示例：第三轮 i=2 时，读取 16(%rdi)，把 payments[2] 的 2000 加上去，sum = 5000。
    
    incl %ecx           # 索引递增：i++。
    jmp .L_pay_loop     # 无条件跳回循环开始处，检查是否满足终止条件。
    
.L_pay_done:
    ret                 # 循环跑完，%eax 里保存着 5800。返回给 C 函数打印 [cite: 22]。