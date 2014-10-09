;Boot Loader  - Beta 0.0
;Func:
;    Print a string into the center of screen.

;设置程序开始地址->0x7c00（原始地址为0x0000）
org 07c00h
    jmp start
    msg db 'Welcome to Urinx OS ...'
    len equ $-msg
start:
    mov ax,cs
    mov ds,ax
    mov es,ax
    ;要输出的字符串
    mov bp,msg
    ;字符串长度
    mov cx,len
    ;显示的串结构
    mov ax,0x1301
    ;字符属性
    mov bx,0x7
    ;dx->行号 列号
    mov dl,0
    int 10h

    ;无限循环当前指令
    jmp $
    ;重复填充数值0
    times 510-($-$$) db 0
    ;结束标志最后两个字节，为55AA
    dw 0xaa55