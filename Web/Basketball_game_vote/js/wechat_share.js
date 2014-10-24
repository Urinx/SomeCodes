document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {

	var l=location;
	var s=l.pathname.split('/');
	s.pop();
	var baseUrl = l.protocol + "//" + l.host + s.join('/');

	var imgUrl=baseUrl+'/img/thumb.png';
	var appid='';
	var link=baseUrl;
	var title=document.title;
	var desc='比赛火热进行中，大家快来投票吧！';

	// 发送给好友
	WeixinJSBridge.on('menu:share:appmessage', function(argv){
		WeixinJSBridge.invoke('sendAppMessage',{
			"appid": appid,
			"img_url": imgUrl,
			"img_width": "200",
			"img_height": "200",
			"link": link,
			"desc": desc,
			"title": title
		}, function(res) {
			//alert(res.err_msg);
		});
	});

	// 分享到朋友圈
	WeixinJSBridge.on('menu:share:timeline', function(argv){
		WeixinJSBridge.invoke('shareTimeline',{
			"img_url": imgUrl,
			"img_width": "200",
			"img_height": "200",
			"link": link,
			"desc": desc,
			"title": title
		}, function(res) {
			//alert(res.err_msg);
		});
	});

});