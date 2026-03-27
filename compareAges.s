.global compareAges
.text
compareAges:
    # 【函数签名】 int compareAges(CUSTOMER* a, CUSTOMER* b);
    # 传入的参数 a 和 b 都是 64 位的内存指针。
    # 参数 a 存放在 %rdi 中，参数 b 存放在 %rsi 中。
    #
    # 【结构体内存布局分析】
    # typedef struct Customer {
    #     int id;          // 占用 4 字节，起始偏移量为 0
    #     int age;         // 占用 4 字节，起始偏移量为 4
    #     int payments[5]; // 占用 20 字节，起始偏移量为 8
    # } CUSTOMER;
    # 
    # 【工作流示例】
    # 假设 a 的内存地址是 0x1000。a->age 就是在 0x1000 + 4 的位置。
    # 假设 a->age = 25，b->age = 30。
    
    movl 4(%rdi), %eax  # 访问 a->age。使用带偏移量的基址寻址：读取 %rdi 加上 4 字节偏移处的内存值。
                        # 示例：读取 0x1004 处的数据放入 %eax。此时 %eax = 25。
    
    cmpl 4(%rsi), %eax  # 访问 b->age（读取 %rsi 加上 4 字节处的内存），并与 %eax(a->age) 比较。
                        # 示例：后台执行 25 - 30。结果不为 0，零标志位 (Zero Flag, ZF) 被设置为 0。
    
    sete %al            # Set if Equal (sete)。如果比较结果相等 (ZF == 1)，把 %al（%eax最低的1字节）设为 1，否则为 0。
                        # 示例：因为 25 != 30，所以 %al = 0。如果是 a->age 和 a3->age (均为25)，%al 就是 1。
    
    movzbl %al, %eax    # 将 8 位的 %al 零扩展 (Zero-extend) 为 32 位的 %eax。
                        # 这一步非常关键，它能清空 %eax 高 24 位中可能残留的垃圾数据，确保返回纯净的 1 或 0。
    ret                 # 将比对结果 %eax 传递回 C 程序。