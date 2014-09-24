assume cs:code

code segment
start:
	;1.修改中断向量表
	;中断向量表:0000:0000->0000:03FE,每个表项2字(4字节,偏移+段址)
	;修改零号中断表项，指向自定义中断处理程序的入口地址
	;没有其他程序使用的内存:0000:0200->0000:0300
	mov ax,0
	mov ds,ax
	mov word ptr ds:[0],200h
	mov word ptr ds:[2],0
	
	;3.将自定义中断程序复制到内存0000:0200
	;此时cs为当前代码段地址
	mov ax,cs
	mov ds,ax
	mov si,offset int0
	mov ax,0
	mov es,ax
	mov di,200h
	;传送指定地址的字符串
	;设置长度
	mov cx,offset int0end-offset int0
	;指定复制方向，向下
	cld
	;ds:si->es:di
	rep movsb
	
	;4.引发零号中断
	mov ax,1000h
	mov bl,1
	div bl
	
	;2.自定义零号中断
int0:
	jmp short int0start ; 地址:0200h
	db "What the fuck!" ; 地址:0202h
int0start:
	;载入显存
	mov ax,0b800h
	mov es,ax
	;显示字符
	;此时cs:0000h
	mov ax,cs
	mov ds,ax
	;si->字符串
	mov si,202h
	;80x24屏幕中间偏移
	mov di,12*80*2+32*2
	mov cx,14
s:
	mov al,ds:[si]
	mov es:[di],al
	inc si
	add di,2
	loop s
	
	;PressAnyKey中断
	mov ax,4c00h
	int 21h
int0end:nop

code ends
	end start
