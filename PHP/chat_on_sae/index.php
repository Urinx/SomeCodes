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
        var usr='';
        var acc=to?1:0;
	    var channel = sae.Channel(url);
	    channel.onopen = function(){
            if (to) {//B->A
	    		setLayout('b1','Someone');
                var data='to='+to+'&message='+name+':'+document.querySelector('#name').innerHTML;
	    		ajax('http://smartqq.sinaapp.com/channel.php',data);
	    	}
            else{//A wait B
	    		setLayout('b1','Nobody');
	    	}
	    }
	    channel.onmessage = function (message) {
            if (!to) {//A get B send
                arr=message.data.split(':');
                to=arr[0];
                usr=arr[1];
	    		setLayout('b1',usr+' is online');
	    		playSound('res/incoming.mp3');
                //A->B
                var data='to='+to+'&message='+document.querySelector('#name').innerHTML;
                ajax('http://smartqq.sinaapp.com/channel.php',data);
	    	}
	    	else{
                if(acc){//B get A username
                    usr=message.data;
                    setLayout('b1',usr+' is online');
                    playSound('res/incoming.mp3');
                    acc=acc-1;
                }
                else{
                    setLayout('b1',usr+":<br>"+message.data);
                    var n=Math.floor(1+Math.random()*114)+'';
                    var k=n.length;
                    for (var i = 0; i < 3-k; i++) {
                        n='0'+n;
                    };
                    playSound('res/v'+n+'.m4a');
                }
	    	}
	    }
	</script>
</head>

<qq class="lightblue_font lightblue_box">
	<div id="b1"></div>
	&nbsp;<span id="name">root</span>&gt;&nbsp;<input class="lightblue_font">
	<div id="b2"></div>
</qq>
<audio src="res/gulugulu.m4a"></audio>