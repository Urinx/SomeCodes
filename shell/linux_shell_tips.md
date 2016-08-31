# 统计并显示前十常用命令
```
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
```

# 使用 ^old^new 换掉输错或输少的部分
```
> cat myflie
> ^li^il
> cat myfile
```

# 使用 !:gs/old/new 将 old 全部换成 new
```
> ansible nginx -m command -a 'which nginx'
> !:gs/nginx/squid
> ansible squid -m command -a 'which squid'
> ^nginx^squid^:G # zsh
```

# 使用 !foo 执行以 foo 开头的命令
```
> !his
history
```

# 使用 !-n 执行倒数第 n 个命令
```
> !-2
htop
```

# 使用 !# 引用当前行
```
> cp filename filename.old
> cp filename !#:1.old
```

# 通过 !$ 得到上一条命令的最后一位参数
```
> mkdir videos
> cd !$
```

# 通过 !^ 得到上一条命令的第一个参数
```
> ls /usr/share/doc /usr/share/man
> cd !^
```

# 通过 !:n 得到上一条命令第 n 个参数
```
> touch foo.txt bar.txt baz.txt
> vim !:2
```

# 通过 !:x-y 得到上一条命令从 x 到 y 的参数
```
> touch foo.txt bar.txt baz.txt
> vim !:1-2
```

# 通过 !:n* 得到上一条命令从 n 开始到最后的参数
```
> cat /etc/resolv.conf /etc/hosts /etc/hostname
> vim !:2*
```

# 通过 !* 得到上一条命令的所有参数
```
> ls code src
> cp -r !*
```

# 利用 :h 选取路径开头
```
> ls /usr/share/fonts/truetype
> cd !$:h
cd /usr/share/fonts
```

# 利用 :t 选取路径结尾
```
> wget http://nginx.org/download/nginx-1.4.7.tar.gz
> tar zxvf !$:t
tar zxvf nginx-1.4.7.tar.gz
```

# 利用 :r 选取文件名
```
> unzip filename.zip
> cd !$:r
cd filename
```

# 利用 :e 选取扩展名
```
> echo abc.jpg
> echo !$:e
echo .jpg # bash
echo jpg  # zsh
```

# 利用 :p 打印命令行
```
> echo *
README.md css img index.html js
> !:p
echo *
```

# 利用 :u 将其更改为大写 (zsh)
```
> echo $histchars
> echo !$:u
echo $HISTCHARS
```

# 利用 :l 将其更改为小写 (zsh)
```
> echo !$:l
echo $histchars
```

# 使用 alias -s 定义后缀别名 (zsh)
```
> alias -s pl=perl
> script.pl
perl script.pl
```

# 使用 {} 构造字符串
```
> cp file.c file.c.bak
> cp file.c{,.bak}

> vim {a,b,c}file.c
vim afile.c bfile.c cfile.c

> wget http://linuxtoy.org/img/{1..5}.jpg
1.jpg  2.jpg  3.jpg  4.jpg  5.jpg

> touch {01..5}.txt
01.txt  02.txt  03.txt  04.txt  05.txt

> touch {1..10..2}.txt
1.txt  3.txt  5.txt  7.txt  9.txt

> echo {1..10..-2} # zsh
9 7 5 3 1

> echo {9..1..2}   # bash
9 7 5 3 1

> mkdir -p 2014/{01..12}/{baby,photo}
```

# 使用 `` 或 $() 做命令替换
```
> grep -l error *.pm
TunePage.pm
> vim TunePage.pm

> vim `grep -l error *.pm`
> vim $(grep -l error *.pm)
```

# 嵌套时，$() 可读性更清晰，而 `` 则较差
```
> vim $(grep -l failed $(date +'%Y%m%d').log)
> vim `grep -l failed \`date +'%Y%m%d'\`.log`
```

# 使用 for ... in 重复执行命令
```
> for dev in /dev/sd{a..d}
> do
>   hdparm -t $dev
> done
```
