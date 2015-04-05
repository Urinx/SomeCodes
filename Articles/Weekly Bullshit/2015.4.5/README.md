Mac党入坑小记
=============

### Preface
话说愚人节那天我也开了个玩笑，表示一个战五渣的机子上长年黑苹果终于不能忍，于是忍疼咬牙坐等nmb出来后果断入手rmbp。当然更头疼的是接下来如何从那台寿终就寝的跑着Win10，Kali Linux和Mac OSX三系统的本本迁移各种奇妙的数据。本文就是这么一个折腾的过程，也许你们只是看热闹，可我只想说，不作死就不会死，换电脑真麻烦。

### Yosemite
![Alt text](screenshot/0.png)

鉴于自己对Yosemite零熟悉的陌生程度，小白先从界面开始。

![Alt text](screenshot/4.png)

顶部是菜单栏，底部是Dock，双指向左滑可以调出通知中心，三指向右滑动则切换到Dashboard：

![Alt text](screenshot/5.png)

四指捏合则进入Lanchpad：

![Alt text](screenshot/6.png)

三指向上滑动则是Mission Control，其实就是多桌面：

![Alt text](screenshot/7.png)

回过头来再看看他的文件系统，毕竟是基于Unix的，目录结构其实都差不多。

![Alt text](screenshot/8.png)

### Touch Gesture Operation
第一件事必须是熟悉那极度方便的手势操作。苹果很人性化的自带了演示教程供用户熟悉和体验，可以在设置>触控板中看到：

![Alt text](screenshot/1.png)

2015年苹果春季发布会上推出一项新的Force Touch触控板，搭载于最新的13寸 MacBook Pro和12寸MacBook之上。Force Touch可以配合最新的OS X Yosemite系统，感知用户指尖的轻压以及重压的力度，来实现对电脑下达命令，调出不同的对应功能。

例如，用户通过重压可以调出OS X中的Quick Look视窗。用户改变之间按压的力度便可以让Quick Look视窗放大或缩小，只要按压的足够用力就能够激活force click输入，Quick Look视窗便会完全展示出来。

另外，Force Touch还可以控制QuickTime。触控力度将调整前进或后退的速度，苹果还专门为这种输入法起了个名字——Accelerators。

OS X地图中，按压力度大小控制了缩放的速度，force click输入还支持用户在地图上设定标记。

其他的一些快捷操作，例如force click支持用户调出特定的对话框以及媒体；在Finder中，force click可以重命名文档。

然而可惜的是，目前设置里的触控板的演示操作里没有关于Force Touch的手势，可以上官网了解或是官方演示视屏中看到。

### Shortcuts
当掌握这些手势后，基本上从此以后你可以不再依赖windows下养成的使用鼠标的坏习惯了。当然，第二个要掌握的就是Mac下的各种快捷键了。

系统的各种快捷键可以在设置>键盘>快捷键中看到，你也可以更改：

![Alt text](screenshot/2.png)

苹果又很人性化的帮你分类好了，方便于查找。不过这么多快捷键，不可能每次记不住了就跑到设置里去找吧，对于像作者这种小白来说，我们可以将下图设置成壁纸，没事就看看。

![Alt text](screenshot/3.jpg)

当然一开始这些快捷键的符号我是没看懂的。。下面是快捷键中的常用符号：
⌘（command）、⌥（option）、⇧（shift）、⇪（caps lock）、⌃（control）、↩（return）、⌅（enter）

### Typewriting
说到输入问题，先熟悉下键盘，下图是标准的英式和美式键盘：

![Alt text](screenshot/9.jpg)

只有command上面有一个符号，而其他的按键上都没有符号。但实际上在其他非英式键盘比如russian、german类型的键盘上，option、shfit、caps lock、tab、delete、return（enter）等分别都是用符号表示。

这里插播一条趣闻：
> command健实际上是以前的键，最早出现在Apple III上，是一个带有Apple logo图案的按键，而那个时候Apple logo泛滥，甚至有些Apple相关的聚会或者Apple员工参加的聚会上，在卫生间照镜子的时候都可以看到Apple logo，因为Apple的工程师会随身携带一些Apple logo的贴纸，就像是购买苹果的有关设备时会随机赠送Apple贴纸，这是苹果的一种文化。自从Macintosh之后，乔布斯认为Apple logo已经泛滥，失效，就像那个满身都是LV的包，这是一种暴发户的极度自恋的表现，这一现象必须得到遏制，于是受够了满身Apple logo的乔布斯让设计部门重新设计一个按键符号，而设计师Susan Kare（苏珊·凯尔）在一本《国际标志辞典》中找到⌘这个符号，并决定启用它，这一有着神秘主义气质的符号受到乔布斯的喜欢，于是出现在了Apple的键盘上，而为了让这一符号顺利即位，有时候还和⌘还共同出现，而到2007年晚期MacBook Pro 133之后则只有⌘停留在command键上表示这一按键的特殊性。

下面是符号与按键对照表：

![Alt text](screenshot/10.jpg)

讲完了键盘，接下来我们讲讲如何输入这些奇葩特殊字符和符号。

其中一种最简单也是最万能的方法就是通过使用“字符显示程序”输入。通过快捷键⌘⌃空格调出。

![Alt text](screenshot/11.png)

这是一个字符大全集合，几乎包括了所有的字符，比如数学符号，表情符号、箭头、日文、韩文、罗马、拉丁等等都包含在这里，你可以用它来输入任何符号，所以如果你有没法输入的字符，不妨到这里看看。

然而每次这样输入难道不显得太麻烦，而Mac下输入符号的另一种方式，就是用键盘快速输入符号。在Mac的键盘上隐藏了很多的符号，而这些符号就像是“巫师”手底下的那些密码或“魔咒”，而打开魔咒的Key就是那个option键，它将带领你通往符号的哈利波特与魔法室。

先打开显示键盘显示程序，按住option，你会发现键盘按键对应的字符会发生变化，如下图：

![Alt text](screenshot/12.jpg)

按住shift+option，则又会成这样：

![Alt text](screenshot/13.jpg)

现在明白符号是怎么打出来的吧，不过这些符号只能在苹果机上才能看到，windows下则会是乱码。

### 通知中心
通知中心扁平化了，现在长得跟手机iOS8一个样了。

![Alt text](screenshot/14.png)

系统的通知中心自带了几个插件，比如天气，计算器，股票等基本上用不到的插件。

所以咯，接下来给大家推荐一个重量级的插件咯——Today Scripts，一听名字就知道是一款非常geek的插件啦。

首先去github上下载[压缩包](https://github.com/SamRothCA/Today-Scripts/releases)，解压后点击打开，然后去通知中心编辑，添加进去就行了。

![Alt text](screenshot/15.png)

然后你就会看到上图的画面，这时候什么都没有。接下来就是我们自定义的时候了，点击那个`i`按钮，会出现这个：

![Alt text](screenshot/16.png)

接着就是在这里添加自己的脚本就可以了。

![Alt text](screenshot/17.png)

作者提供了一些脚本，详情看[这里](https://github.com/SamRothCA/Today-Scripts/wiki#)。

这里仅列居一些常用的：

日历
```
cal | grep --before-context 6 --after-context 6 --color -e " $(date +%e)" -e "^$(date +%e)"
```

世界时间
```
echo "Denver `export TZ='US/Mountain';date +'%-l:%M %p';unset TZ`"
echo "London `export TZ='Europe/London';date +'%-l:%M %p';unset TZ`"
echo "Paris `export TZ='Europe/Paris';date +'%-l:%M %p';unset TZ`"
echo "Mumbai `export TZ='Asia/Kolkata';date +'%-l:%M %p';unset TZ`"
echo "Sydney `export TZ='Australia/Sydney';date +'%-l:%M %p';unset TZ`"
```

显示当前剪切板的文本内容
```
pbpaste
```

电量状态信息
```
pmset -g batt | { read; read n status; echo "$status"; }
```

显示占用内存最多的5个程序
```
ps xmo rss=,pmem=,comm= | while read rss pmem comm; ((n++<5)); do

size="$[rss/1024]";
short=$[4-${#size}];
size="(${size}M)";
i=0;
while ((i++ < short)); do size=" $size"; done;

pmem="${pmem%%.*}"
if   (($pmem >= 20)); then color=$'\e[31m';
elif (($pmem >= 10)); then color=$'\e[33m';
else                       color=$'\e[32m ';
fi;

echo "$color$pmem% $size $(basename "$comm")"$'\e[0m'"";
done
```

显示占用 CPU 资源最多的5个程序
```
ps xro %cpu=,comm= | while read cpu comm; ((i++<5)); do echo $cpu% $(basename "$comm"); done
```

硬盘用量
```
df -Hl | {
read keys;
keys="${keys%% on}";
while read ${keys//%}; do
echo "`basename "$Mounted"` – $Used/$Size ($Capacity)";
done
}
```

显示一个网站最新的5篇文章标题
```
curl “RSS_URL_HERE“ 2>/dev/null |
grep -o “<title>[^<]*</title>“ |
grep -v “<title>FIRST_TITLE_REMOVER</title>“ |
sed -e “s/.*\<title\>\(.*\)\<\/title\>.*/\1/g“ |
nl -n rz -s “ » “ -w 2 |
fold -s -w 80 |
awk ‘!/^[0-9]+\ » / {$0=” “$0}1‘ |
awk ‘/^[0-9]+\ » / {$0=”\n”$0}1‘ |
head -10
```

### Screensaver
屏幕保护自带的有很多，可我只认准一家，那就是[Fliqlo](http://fliqlo.com/#about)。

![Alt text](screenshot/45.jpg)

### Safari Extensions

![Alt text](screenshot/46.png)

给个官方[地址](https://extensions.apple.com)，虽然不多，但都不错。

### Homebrew
必备神器之一，Mac OSX上的软件包管理工具，能在Mac中方便的安装软件或者卸载软件， 简单到只需要一个命令。

安装
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
![Alt text](screenshot/18.png)

安装wget
```
brew install wget
```
![Alt text](screenshot/32.png)

其他命令
```
brew list		列出已安装的软件
brew update		更新brew
brew home		用浏览器打开brew的官方网站
brew info		显示软件信息
brew deps		显示包依赖
```

### Git
由于自带git，所以这里就简单的配置一下。

提交代码的log里面会显示提交者的信息：
```
git config --global user.name [username]
git config --global user.email [email]
```

在git命令中开启颜色显示：
```
git config --global color.ui true
```

配置一些git的常用命令alias：
```
sudo git config --system alias.st status
sudo git config --system alias.ci commit
sudo git config --system alias.co checkout
sudo git config --system alias.br branch
```

查看是否有ssh密匙，有则删除：
```
cd ~/.ssh
```

生成密钥：
```
ssh-keygen -t rsa -C "example@xxx.com"
```
![Alt text](screenshot/19.png)

添加密钥到ssh：
```
ssh-add path/to/id_rsa
```
![Alt text](screenshot/20.png)

在github上添加ssh密钥，这要添加的是“id_rsa.pub”里面的公钥：
```
pbcopy < ~/.ssh/id_rsa.pub
```
![Alt text](screenshot/21.png)

测试：
```
ssh -T git@github.com
```
![Alt text](screenshot/22.png)

ok，看到这个就代表添加成功了。

### Vim & Node & Something else
同样自带了Vim，所以我门只管配置.vimrc文件就行了。这里采取最简单的方法，就是用[vgod](https://github.com/vgod/vimrc)已经配置好的。

一键安装：
```
curl -o - https://raw.githubusercontent.com/vgod/vimrc/master/auto-install.sh | sh
```
![Alt text](screenshot/24.png)

Node的话上[官网](http://nodejs.org/)下就是了，pkg文件，一路next下去。

![Alt text](screenshot/23.png)

最后要说的就是，在windows下，我们可以ctrl＋右键打开cmd，linux下也有插件可以右键在当前目录打开terminal，那么mac下呢？

其实不需要任何插件就可以做到，只不过系统默认关闭了此功能。在设置>键盘>快捷键>服务里可以打开此选项：

![Alt text](screenshot/30.png)

然后右键文件夹就可以看到啦：

![Alt text](screenshot/31.png)

当然还有种方法就是将文件夹直接拖到terminal里或是icon上也能打开。

### App
小白表示目前对好多App神器一无了解，所以先用知乎上一文科生大神的图镇楼：

![Alt text](screenshot/33.png)

![Alt text](screenshot/34.png)

![Alt text](screenshot/35.png)

Dock上从左往右分别是iMessage、邮件、Readkit、Omni Focus、Omni Outliner、Mindnode Pro、Stata 13、Papers3、Numbers、Pages、Byword、Mou、Notability、Textastic、Cornerstone、Aperture、Logic Pro、iTunes、网易云音乐、Safari、Day One。手机平板电脑无缝衔接。。

随便一张图就完爆我等屌丝。。

![Alt text](screenshot/36.png)

而我呢，目前本人只用到这些App，日后会不断补充，求各种推荐。先上大图：

![Alt text](screenshot/25.png)

##### AtPill——漂亮的豆瓣电台客户端

![Alt text](screenshot/26.png)

AtPill是由来者制作的豆瓣电台客户端应用程序。界面简洁，很喜欢它的配色，很淳，很纯~不妨一试。

##### Sublime Text 3
这家伙不说了，看着就是美！

![Alt text](screenshot/39.png)

License：
```
----- BEGIN LICENSE -----
K-20
Single User License
EA7E-940129
3A099EC1 C0B5C7C5 33EBF0CF BE82FE3B
EAC2164A 4F8EC954 4E87F1E5 7E4E85D6
C5605DE6 DAB003B4 D60CA4D0 77CB1533
3C47F579 FB3E8476 EB3AA9A7 68C43CD9
8C60B563 80FE367D 8CAD14B3 54FB7A9F
4123FFC4 D63312BA 141AF702 F6BBA254
B094B9C0 FAA4B04C 06CC9AFC FD412671
82E3AEE0 0F0FAAA7 8FA773C9 383A9E18
------ END LICENSE ------
```

Package Control:
```
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

[必备插件](http://ipestov.com/the-best-plugins-for-sublime-text/):
* WebInspector
* Emmet
* Git
* GitGutter & Modific
* BracketHighlighter
* EditorConfig
* Sublimall
* AllAutocomplete
* SublimeREPL
* DocBlockr
* Floobits
* AutoFileName
* ColorPicker
* Colorcoder
* PlainTasks
* MarkdownEditing

其他插件：
* Sublime SFTP
* CTags – 让Sublime Text支持CTags
* SideBarEnhancement – 为侧边栏添加很多额外的功能
* ActualVim – Vim in Sublime – 两个最爱的编辑器合二为一
* SublimeLinter – 行内语法检测插件，支持： C/C++, Java, Python, PHP, JS, HTML, CSS, etc
* CSScomb – CSS代码风格格式化
* FixMyJS, Jsfmt and JsFormat – JS/JSON代码风格格式化
* AStyleFormatter – C/C++/C#/Java 代码风格格式化
* SVG-Snippets – 一套 SVG 代码片段
* Inc-Dec-Value – 增加或减少数字, 日期, 十六进制彩色值等等
* Trailing Spaces – 高亮空白结尾并快速删除它们
* Alignment – Package Control作者写的简单到极致的多行选择和多行选择对齐插件
* Placeholders – 带有文本，图片，列表，表格等的占位用代码片段
* ApplySyntax – 快速语法检测
* StylToken – 允许以不同的颜色高亮特定的一段文本 (类似和notepad++ 的Style token功能)
* EasyMotion – 快速跳转到任何当前激活视图而已看到区域的字符
* ZenTabs 和Advanced New File – 改进默认tab样式和文件创建
* EncodingHelper – 猜测文本的编码方式，在状态栏显示，从不同的编码形式转换到UTF-8
* Gist – 同步GitHub Gist和Sublime (ST2)
* Clipboard History (ST2) – 为的剪切板保存历史记录

主题和配色方案：
* Soda
* Spacegray
* Flatland
* Tomorrow
* Base 16
* Solarized
* Predawn
* itg.flat



##### Xcode
超级IDE，iOS开发神器。

![Alt text](screenshot/27.png)

##### VMware Fusion
绕不过的windows，你说呢？

![Alt text](screenshot/37.png)

![Alt text](screenshot/38.png)

##### 1Password
![Alt text](screenshot/40.png)

接下来就是三大神器：先Feedly浏览，保存到Pocket离线阅读，读完后Evernote做笔记。

##### Feedly
![Alt text](screenshot/44.png)

##### Pocket
![Alt text](screenshot/28.png)

##### Evernote
![Alt text](screenshot/29.png)

微信扣扣安上去从来不用的，略去。

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
这里还有份清单，来自网络

* 开发工具：
	* 纯英文时：TextMate
	* 现在最常使用：Sumlime Text 2（传说中的神器2号，1号现在还是给了TextMate吧，毕竟它先出来）
	* 有时候会用的：BBEdit与TextWrangler
	* 在终端中工作时为了快速有时直接使用 vi（只是为了简单，一般很少用，有桌面应用的时候还在命令行里面写感觉有点装B）
	* 系统自带实用工具：数码测色计，网络实用工具，磁盘工具
	* Coda （非 Coda 2）：HTML、CSS、JavaScript编辑工具，以前用得很多，现在使用少了一些了
	* Tex
	* 心目中的虚拟神器 Parallels Desktop （安装有 FreeBSD、Ubuntu Desktop、Ubuntu Server、OpenSUSE、Salaris、Windows 7/XP/8/2008/2003 等）
	* MindNode Pro
	* Nginx + PHP/Python/Perl + MySQL/SQLite/PostgreSQL 网站程序服务器环境
	* Chrome浏览器（个人从来不做兼容性测试，就算要测试在Mac下也没法测试全），所以就这一个就足够了
	* GITHUB：我学习git 的时候一直都在使用 github 这个工具，不过还是想自己搭建 git
	* NavCat Pro
	* OMniGraffle Pro
* 互联网工具：
	* QQ for Mac
	* Facetime
	* Tunnelblick 配自己在美国的服务器建立的VPN
	* Reeder
* 音乐与视频：
	* iTunes
	* 射手影音（最主要就是那个可以自动匹配字幕的功能）
	* iShowU 与 Stomp：桌面视频录像与视频转换工具
* 文档与图片处理：
	* 圈点：不知道与EverNote有什么关系，以前叫 Skitch，一直使用
	* Adobe Creative Suit 6 ：这个是唯一一个盗版（实在是买不起，不是不支持正版）
	* Lightroom 4
	* Aperture
	* Pages/Numbers/Keynote三大傻
	* Pixelmator
	* ColorStrokes
	* Flare
	* iPhoto
	* Acorn
	* 国产软件：好照片
* 游戏：
	* Trine
	* Mactracker
	* Braid
	* Asphalt 6
	* AngryBirds (Rio, Seasons, Space )
	* Plants vs. Zombies
	* 其它一些游戏都是以前玩过通关了然后现在也没有太多心情去玩的，重装了系统之后也就没有再安装上了，所以这里就不写出来了
* 其它一些不知道怎么归类的软件
	* The Unarchiver ：压缩与解压缩
	* Transmit：文件传输工具（FTP、SFTP等）/以前使用过 RBrowser，不过感觉不太好用，FileZilla 在Mac下面太不好看
	* AppCleaner：用这个来卸载不需要的应用
	* QQ输入法 for Mac：最习惯使用的输入法（以前使用的是 Chinese BP）

### Last
最后，最大的痛楚就是各种数据迁移，虽然大部分代码在github上，然而每个系统里仍残留各种未完成未公开未想要的零零碎碎的代码片段，本地的各种文件各种图片da，以及百度云网盘，360网盘，金山快盘，新浪微盘，Dropbox，Skydrive，blablabla。。

同步是个大问题，云端一点不云端。最可恶的是，网速还捉急，头上一堵墙。

这是别人家的桌面：

![Alt text](screenshot/41.jpg)

![Alt text](screenshot/42.jpg)

![Alt text](screenshot/43.jpg)

这是别人家的桌面~  T_T.....

我的桌面上就只有一个小本本，空无一物没情调，作为有情怀有理想有追求的屌丝一枚，也想天生骄傲霸气四方，望有钱淫移步到万恶的分割线下，动动手指献爱心吧。

＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝

欢迎关注我的微信公众号

![Alt text](screenshot/wechat.jpg)

微信资助

![Alt text](screenshot/wechat_pay.jpg)

支付宝打赏

![Alt text](screenshot/ali_pay.jpg)

好人一生平安