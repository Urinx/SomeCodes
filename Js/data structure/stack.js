function Stack(){
	this.dataStore = [];
	this.length = 0;
	Object.seal(this);
}

Stack.prototype = {
	push: function(el){
		this.dataStore[this.length++]=el;
	},
	peek: function(){
		return this.dataStore[this.length-1]
	},
	pop: function(){
		if (this.length == 0) {
			return null;
		}
		return this.dataStore[--this.length]
	},
	clear: function(){
		this.length = 0;
	}
};
// -------------------------
// 回文判断
function isPalindrome(str){
	var s = new Stack();
	var rts = '';
	str.split('').map(function(c){
		s.push(c);
	});
	while(s.length>0){
		rts+=s.pop();
	}
	return str == rts;
}

isPalindrome("abcba");
isPalindrome("aabbcbaa");

// 阶乘
function factorial(n){
	var s = new Stack();
	var product = 1;
	while (n>1){
		s.push(n--);
	}
	while (s.length>0){
		product*=s.pop()
	}
	return product;
}