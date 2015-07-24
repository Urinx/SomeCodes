function List(){
	this.listSize = 0;
	this.pos = 0;
	this.dataStore = [];
}

List.prototype = {
	clear: function(){
		delete this.dataStore;
		this.dataStore = [];
		this.listSize = 0;
		this.pos = 0;
	},
	append: function(el){
		this.dataStore[this.listSize++] = el;
	},
	find: function(el){
		for (var i = 0; i < this.listSize; i++) {
			if (this.dataStore[i]==el) return i;
		}
		return -1;
	},
	remove: function(el){
		var foundAt = this.find(el);
		if (foundAt > -1) {
			this.dataStore.splice(foundAt,1);
			--this.listSize;
			return true;
		}
		return false;
	},
	length: function(){
		return this.listSize;
	},
	toString: function(){
		return this.dataStore.join(' ');
	},
	insert: function(el,after){
		var insertPos = this.find(after);
		if (insertPos > -1) {
			this.dataStore.splice(insertPos+1, 0, el);
			++this.listSize;
			return true;
		}
		return false;
	},
	contains: function(el){
		for (var i = 0; i < this.listSize; i++) {
			if (this.dataStore[i] == el) {
				return true;
			}
		}
		return false;
	},
	front: function(){
		this.pos = 0;
	},
	end: function(){
		this.pos = this.listSize-1;
	},
	prev: function(){
		if (this.pos >0) {
			--this.pos;
		}
	},
	next: function(){
		if (this.pos < this.listSize-1) {
			++this.pos;
		}
	},
	currPos: function(){
		return this.pos;
	},
	moveTo: function(position){
		this.pos = position;
	},
	getElement: function(){
		return this.dataStore[this.pos];
	},
};