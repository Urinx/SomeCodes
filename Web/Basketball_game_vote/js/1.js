	function submit(){

		var input=document.querySelectorAll('input');

		// Check if is voted
		if (getCookie('voted')) {
		//if (0) {
			alert('你已经投过票了,\n一天只能投一次！');
		}
		else{
			var selected=0;
			for (var i = 0; i < input.length; i++) {
				if(input[i].checked){
					selected+=1;
				}
			};
			if(selected>3){
					alert('最多只能选择3个！');
				}
			else if (selected) {
				setCookie();
				// submit
				document.querySelector('form').submit();
			}
			else{
				alert('请至少选择一位！');
			}
		}
	}

	function getCookie(name){
		var arrStr=document.cookie.split("; ");
		for(var i = 0;i < arrStr.length;i ++){
			var temp=arrStr[i].split("=");
			if(temp[0] == name) return unescape(temp[1]);
		}
	}

	function setCookie(){
		// one day expires
		var d = new Date();
		d.setTime(d.getTime() + (24*60*60*1000));
		var expires = "expires="+d.toGMTString();
		document.cookie='voted=true; path=/; '+expires;
	}

	function li_attach_click(){
		var li=document.querySelectorAll('li');
		for (var i = 0; i < li.length; i++) {
			li[i].flag=0;
			li[i].querySelector('input[type=checkbox]').checked='';
			li[i].addEventListener('click',function () {
				if(this.flag){
					this.querySelector('input[type=checkbox]').checked='';
				}
				else{
					this.querySelector('input[type=checkbox]').checked='on';
				}
				this.flag=1-this.flag;
			});
		};
	}

	function create_li(obj,a){
		a=shuffle(a);

		for (var i = 0; i < a.length; i++) {
			var j=a[i],n=j;
			var li=document.createElement('li');
			li.innerHTML="<label style='background-image:url(./img/head_photo/"+j+".png);'></label><div>"+j.replace(/[a-z]/g,'')+"号<input type='checkbox' name='"+j+"'></div>";
			obj.appendChild(li);
		};
	}

	function shuffle(v){ 
		for(var j, x, i = v.length; i; j = parseInt(Math.random() * i), x = v[--i], v[i] = v[j], v[j] = x); 
		return v;
	};

	window.onload=function(){
		var b_ul=document.querySelector('#b_ul');
		var g_ul=document.querySelector('#g_ul');
		create_li(b_ul,['b0','b1','b5','b6','b7','b10','b11','b12','b13','b17','b99','b18','b30','b45']);
		create_li(g_ul,['g3','g7','g8','g10','g11','g13','g15','g21','g23','g33','g68','g84']);
		li_attach_click();
	}