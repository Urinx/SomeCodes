function Queue(){
	this.dataStore = [];
	this._first = 0;
	this._end = 0;
	Object.seal(this);
}
Queue.prototype = {
	push: function(el){
		this.dataStore[this._end++] = el;
	},
	shift: function(){
		if (this.length() == 0) {
			return null;
		}
		return this.dataStore[this._first++];
	},
	length: function(){
		return this._end - this._first;
	},
	isEmpty: function(){
		return this.length() == 0;
	}
}

var q = new Queue();
q.push("123");
q.push("456");
q.push("789");