function Dictionary(){
	this.dataStore = new Array();
}

Dictionary.prototype = {
	add: function(key, value){
		this.dataStore[key] = value;
	},
	find: function(key){
		return this.dataStore[key];
	},
	remove: function(key){
		delete this.dataStore[key];
	},
	showAll: function(){
		for(var key of Object.keys(this.dataStore).sort()){
			console.log(key+' -> '+this.dataStore[key]);
		}
	},
	count: function(){
		var n = 0;
		for(var key of Object.keys(this.dataStore)) ++n;
		return n;
	},
	clear: function(){
		for(var key of Object.keys(this.dataStore)){
			delete this.dataStore[key];
		}
	},
};

var pbook = new Dictionary();
pbook.add('Mike','123');
pbook.add('David','345');
pbook.add('Cynthia','456');
pbook.remove('David');
pbook.showAll();
pbook.count();