assume cs:code,ds:data

data segment
	msg db "Hello world"
data ends

code segment
start:
	;数据段地址->ds
	mov ax,data
	mov ds,ax
	;显存地址->es
	mov bx,0b800h
	mov es,bx
	;数据段偏移si,附加段偏移bx
	mov si,0
	mov bx,0
	;终端字符RGB显示模式
	mov ah,00000111b
	;字符串长度
	mov cx,11
  s:mov al,ds:[si]
	mov es:[bx],ax
	inc si
	add bx,2
	loop s
	;PressAnyKey DOS中断
	mov ax,4c00h
	int 21h
code ends
	end start
