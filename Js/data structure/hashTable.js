function HashTable(){
	this.table = new Array(137);
	this.values = [];
}

HashTable.prototype = {
	simpleHash: function(data){
		var total = 0;
		for (var i = 0; i < data.length; i++) {
			total += data.charCodeAt(i);
		}
		return total % this.table.length;
	},
	betterHash: function(str){
		const H = 37;
		var total = 0;
		for (var i = 0; i < str.length; i++) {
			total += H * total + str.charCodeAt(i);
		}
		total = total % this.table.length;
		if (total < 0) {
			total += this.table.length - 1;
		}
		return parseInt(total);
	},
	// 开链法避免碰撞
	buildChains: function(){
		for (var i = 0; i < this.table.length; i++) {
			this.table[i] = new Array();
		};
	},
	showDistro: function(){
		var n = 0;
		for (var i = 0; i < this.table.length; i++) {
			if(this.table[i][0] != undefined){
				console.log(i+': '+this.table[i].join(','));
			}
		}
	},
	put: function(key, data){
		var pos = this.betterHash(key);
		var index = 0;
		while(this.table[pos][index] != undefined){
			index += 2;
		}
		this.table[pos][index] = key;
		this.table[pos][index+1] = data;
	},
	get: function(key){
		var index = 0;
		var pos = this.betterHash(key);
		while(this.table[pos][index] != key && this.table[pos][index] != undefined){
			index += 2;
		}
		return this.table[pos][index+1];
	},
	// 线性探测法
	put: function(key, data){
		var pos =this.betterHash(key);
		if (this.table[pos] == undefined) {
			this.table[pos] = key;
			this.values[pos] = data;
		}
		else{
			while(this.table[pos] != undefined){
				pos++;
			}
			this.table[pos] = key;
			this.values[pos] = data;
		}
	},
	get: function(key){
		var hash = this.betterHash(key);
		for (var i = hash; this.table[hash] != undefined; i++) {
			if (this.table[hash] == key){
				return this.values[hash];
			}
		}
		return undefined;
	},
};
//--------------------------------
/*
var someNames = [
	"David", "Jennifer", "Donnie", 
	"Raymond", "Cynthia", "Mike", 
	"Clayton", "Danny", "Jonathan"
	];

var hTable = new HashTable();
someNames.forEach(function(name){
	hTable.put(name);
});
hTable.showDistro();

//--------------------------------
function getRandomInt(min,max){
	return Math.floor(Math.random()*(max-min+1)+min);
}
function genStuData(arr){
	for (var i = 0; i < arr.length; i++) {
		var num = '';
		for (var  j= 1; j < 9; j++) {
			num += Math.floor(Math.random()*10);
		}
		num += getRandomInt(50,100);
		arr[i] = num;
	};
}

var students = new Array(10);
genStuData(students);
var hTable2 = new HashTable();
students.forEach(function(num){
	hTable2.put(num);
});
hTable2.showDistro();
*/

