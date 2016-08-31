function ajax(url,data){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onreadystatechange=function(){
		if (xmlhttp.readyState==4 && xmlhttp.status==200) {
			//foo(xmlhttp.responseText);
		};
	};
	xmlhttp.open('POST',url,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send(data);
}

function playSound(src){
	var au=document.querySelector('audio');
	if (src) {au.src=src};
	au.play();
}

function setLayout(b,str){
	if (b=='b1') {
		var b1=document.querySelector('#b1');
		var bubble=document.createElement('div');
		bubble.setAttribute('class','lightpink_box lightpink_font');
		bubble.innerHTML=str;
		b1.insertBefore(bubble,b1.childNodes[0]);
		Move(b1.childNodes[0],{height:94},function(){
				b1.removeChild(b1.childNodes[1]);
		})
	}
	else if(b=='b2'){
		var b2=document.querySelector('#b2');
		if(tmp=document.querySelector('#b2 div')){
			Move(tmp,{width:0,height:0},function(){
				b2.removeChild(tmp);
			})
		}
		var bubble=document.createElement('div');
		bubble.setAttribute('class','lightblue_box');
		bubble.innerHTML=str;
		b2.appendChild(bubble);
	}
}

function keyProcess(ev){
	var input=document.querySelector('input');
    var uname=document.querySelector('#name');
	if (ev.keyCode==13 && to) {
		var data='to='+to+'&message='+input.value;
		ajax('http://smartqq.sinaapp.com/channel.php',data);
		setLayout('b2',uname.innerHTML+":<br>"+input.value);
		input.value='';
	};
}

window.addEventListener('load',function(){
    var uname=document.querySelector('#name');
	var tmp=prompt('Please enter your name:\n(less than 6 chars)');
	uname.innerHTML=tmp;
	var input=document.querySelector('input');
	input.focus();
	input.addEventListener('keypress',keyProcess);
});