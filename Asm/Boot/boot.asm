;Boot Loader  - Beta 0.0
;Func:
;    Print a string into the center of screen.

;设置程序开始地址->0x7c00（原始地址为0x0000）
org 0x7c00

	;调用10h中断向屏幕输出字符串
	mov ax,cs
	mov es,ax
	;es:bp->&str
	mov bp,msgstr
	
	;字符串长度
	mov cx,26
	;dx->行号 列号
	mov dh,0
	mov dl,0
	;显示的页数
	mov bh,0
	;显示的串结构
	mov al,1
	;字符属性
	mov bl,07h
	msgstr: db "Welcome to my Urinx OS 1.0"
	int 10h
	
	;重复填充数值0
	times 510-($-$$) db 0
	;结束标志最后两个字节，为55AAa
	dw 0xaa55
	;无限循环当前指令
	jmp $