importScripts('script1.js');
self.addEventListener('message', function(e){
	self.postMessage(e.data+aa);
}, false);