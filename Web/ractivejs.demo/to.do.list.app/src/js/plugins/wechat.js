define(function(){
	var baseUrl="http://www.baidu.com";
	//var baseUrl = location.href.replace(/basketball_game\/.+/g,'basketball_game');

	var imgUrl=baseUrl+'/img/thumb.png';
	var appid='';
	var link=baseUrl;

	return {
		enableShare: function(title,desc){
			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
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
		}
	};
});


