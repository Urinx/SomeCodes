<?php
require_once($_SERVER['DOCUMENT_ROOT'].'/init.php');
?>

<head>
	<title>Smart QQ</title>
	<link rel="stylesheet" type="text/css" href="smartqq.css">
	<script src="move.js"></script>
	<script src="smartqq.js"></script>
	<script src="http://channel.sinaapp.com/api.js"></script>
	<script>
	    var url='<?=$url?>';
	    var name='<?=$name?>';
	    var to='<?=$to?>';
	    var channel = sae.Channel(url);
	    channel.onopen = function(){
	    	if (to) {
	    		setLayout('b1','Someone');
	    		var data='to='+to+'&message='+name;
	    		ajax('http://smartqq.sinaapp.com/channel.php',data);
	    	}
	    	else{
	    		setLayout('b1','Nobody');
	    	}
	    }
	    channel.onmessage = function (message) {
	    	if (!to) {
	    		to=message.data;
	    		setLayout('b1','Someone is online');
	    		playSound('res/incoming.mp3');
	    	}
	    	else{
	    		setLayout('b1',message.data);
	    		playSound('res/'+Math.floor(Math.random()*4)+'.m4a');
	    	}
	    }
	</script>
</head>

<qq class="lightblue_font lightblue_box">
	<div id="b1"></div>
	root&gt;&nbsp;&nbsp;<input class="lightblue_font">
	<div id="b2"></div>
</qq>
<audio src="res/gulugulu.m4a"></audio>