function notify(t,i,b,tag){
	if (!("Notification" in window)) {
		alert("This browser does not support desktop notification");
	}

	else if (Notification.permission === "granted") {
		var notification = new Notification(t,{
			icon:i,
			body:b,
			tag:tag
		});
	}

	else if (Notification.permission !== 'denied') {
		Notification.requestPermission(function (permission) {
			
			if (!('permission' in Notification)) {
				Notification.permission = permission;
			}

			if (permission === "granted"){
				var notification = new Notification(t,{
					icon:i,
					body:b,
					tag:tag
				});
			}
		});
	}

	setTimeout(function() {
		notification.close();
	}, 5e3);
}