define(['app'],function(app){
	return {
		share: function(title,desc,fn){
			document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
				var baseUrl = 'http://blablabla.com/';
				var imgUrl=baseUrl+'img/thumb.png';
				var appid='';
				
				// 发送给好友
				WeixinJSBridge.on('menu:share:appmessage', function(argv){
					var link=fn();
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
					var link=fn();
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