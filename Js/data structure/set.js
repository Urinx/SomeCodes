function Set(){
	this.dataStore = [];
}

Set.prototype = {
	add: function(data){
		if (this.dataStore.indexOf(data) < 0) {
			this.dataStore.push(data);
			return true;
		}
		else{
			return false;
		}
	},
	remove: function(data){
		var pos = this.dataStore.indexOf(data);
		if (pos > -1) {
			this.dataStore.splice(pos,1);
			return true;
		}
		else{
			return false;
		}
	},
	show: function(){
		console.log(this.dataStore.join(' '));
	},
	contains: function(data){
		if (this.dataStore.indexOf(data) > -1) {
			return true;
		}
		return false;
	},
	union: function(set){
		var tempSet = new Set();
		for (var i = 0; i < this.dataStore.length; i++) {
			tempSet.add(this.dataStore[i]);
		}
		for (var i = 0; i < set.dataStore.length; i++) {
			if (!tempSet.contains(set.dataStore[i])) {
				tempSet.add(set.dataStore[i]);
			}
		}
		return tempSet;
	},
	intersect: function(set){
		var tempSet = new Set();
		for (var i = 0; i < this.dataStore.length; i++) {
			if (set.contains(this.dataStore[i])) {
				tempSet.add(this.dataStore[i]);
			}
		}
		return tempSet;
	},
	subset: function(set){
		if (this.size > set.size()) {
			return false;
		}
		else{
			for (var member of this.dataStore) {
				if (!set.contains(member)) {
					return false;
				}
			}
		}
		return true;
	},
	size: function(){
		return this.dataStore.length;
	},
	difference: function(set){
		var tempSet = new Set();
		for (var i = 0; i < this.dataStore.length; i++) {
			if (!set.contains(this.dataStore[i])) {
				tempSet.add(this.dataStore[i]);
			}
		}
		return tempSet;
	},
};

var names = new Set();
var cis = new Set();
var it = new Set();
names.add('David');
names.add('Cynthia');
names.add('Jonathan');
cis.add('Jennifer');
cis.add('Cynthia');
cis.add('Mike');
cis.add('Raymond');
it = cis.union(names);
it.show();
