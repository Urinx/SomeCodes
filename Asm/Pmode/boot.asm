[BITS 16]
org 0x7c00
jmp main

gdt_table_start:
	;Intel规定段描述表的第一个描述符必须为空0
	gdt_null:
		dd 0h
		dd 0h
	gdt_data_addr equ $-gdt_table_start
	gdt_data:
		dw 07ffh	;段界限
		dw 0h		;段基地址0-18位
		db 0h		;段基地址19-23位
		db 10010010b	;段描述符的第六个字节属性（数据段可读可写）
		db 11000000b	;段描述符的第七个字节属性
		db 0		;段描述符的最后一个字节，也就是段基地址的第二部分
	gdt_video_addr equ $-gdt_table_start
	gdt_video:
		dw 0ffh		;显存段界限1M
		dw 8000h
		db 0bh
		db 10010010b
		db 11000000b
		db 0
	gdt_code_addr equ $-gdt_table_start
	gdt_code:
		dw 07ffh	;段界限
		dw 1h		;段基地址0-18位
		db 80h		;段基地址19-23位
		db 10011010b	;段描述符的第六个字节属性（代码段可读可执行）
		db 11000000b	;段描述符的第七个字节属性
		db 0		;段基地址的第二部分
gdt_table_end:

gdtr_addr:
	dw gdt_table_end-gdt_table_start-1	;段描述表长度
	dd gdt_table_start			;段描述表基地址

main:
	xor eax,eax				;初始化数据段描述符的基地址
	add eax,data_32
	mov word [gdt_data+2],ax
	shr eax,16
	mov byte [gdt_data+4],al
	mov byte [gdt_data+7],ah

	xor eax,eax				;初始化代码段描述符的基地址
	add eax,code_32
	mov word [gdt_code+2],ax
	shr eax,16
	mov byte [gdt_code+4],al
	mov byte [gdt_code+7],ah

	cli
	lgdt [gdtr_addr]			;让cpu读取gdtr_addr所指向内存内容

	enable_A20:				;A20地址线开启
		in al,92h
		or al,00000010b
		out 92h,al
		

	enter_pmode:				;进入保护模式
		mov eax,cr0
		or eax,1
		mov cr0,eax
		;跳转到保护模式中
		jmp gdt_code_addr:0

[BITS 32]
	;在保护模式中打印字符
	data_32:
		msg db 'hello world'

		len equ $-msg
	code_32:
		mov ax,gdt_data_addr
		mov ds,ax
		mov ax,gdt_video_addr
		mov es,ax
		mov cx,len
		mov edi,0
		mov bx,0
		mov ah,0ch
	s:	mov al,[ds:bx]
		mov [es:edi],al
		mov [es:edi+1],ah
		inc bx
		add edi,2
		loop s

		jmp $
		times 510-($-$$) db 0
		dw 0xaa55