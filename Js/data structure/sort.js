function CArray(numElements){
	this.dataStore = [];
	this.pos = 0;
	this.numElements = numElements;
	this.gaps = [5,3,1];
}

CArray.prototype = {
	setData: function(){
		for (var i = 0; i < this.numElements; i++) {
			this.dataStore[i] = Math.floor(Math.random() * (this.numElements + 1));
		};
	},
	clear: function(){
		this.dataStore = [];
	},
	insert: function(element){
		this.dataStore[this.pos++] = element;
	},
	toString: function(){
		console.log(this.dataStore.join(' '));
	},
	swap: function(arr, a, b){
		var tmp = arr[a];
		arr[a] = arr[b];
		arr[b] = tmp;
	},
	bubbleSort: function(){
		var temp;
		for (var outer = this.numElements; outer >= 2; --outer) {
			for (var inner = 0; inner < outer -1; inner++) {
				if (this.dataStore[inner] > this.dataStore[inner+1]) {
					this.swap(this.dataStore,inner,inner+1);
				}
			}
		}
	},
	selectionSort: function(){
		var min;
		for (var outer = 0; outer < this.dataStore.length-2; outer++) {
			min = outer;
			for (var inner = outer + 1;inner <= this.dataStore.length - 1; ++inner){
				if (this.dataStore[inner] < this.dataStore[min]) {
					min = inner;
				}
			}
			this.swap(this.dataStore, outer, min);
		};
	},
	insertionSort: function(){
		var temp,inner;
		for (var outer = 1; outer < this.dataStore.length; ++outer){
			temp = this.dataStore[outer];
			inner = outer;
			while(inner > 0 && this.dataStore[inner - 1] >= temp){
				this.dataStore[inner] = this.dataStore[inner - 1];
				--inner;
			}
			this.dataStore[inner] = temp;
		}
	},
	shellSort: function(){
		for (var g = 0; g < this.gaps.length; g++){
			for (var i = this.gaps[g]; i < this.dataStore.length; i++) {
				var temp = this.dataStore[i];
				for (var j = i; j >= this.gaps[g] && this.dataStore[j-this.gaps[g]] > temp; j -= this.gaps[g]){
					this.dataStore[j] = this.dataStore[j - this.gaps[g]];
				}
				this.dataStore[j] = temp;
			}
		}
	},
	dynamicShellSort: function(){
		var N = this.dataStore.length;
		var h = 1;
		while(h < N/3){
			h = 3 * h + 1;
		}
		while(h >= 1){
			for (var i = h; i < N; i++){
				for (var j = i; j >= h && this.dataStore[j] < this.dataStore[j-h]; j -= h){
					this.swap(this.dataStore, j, j-h);
				}
			}
			h = (h-1)/3;
		}
	},
	mergeSort: function(){
		var step = 1;
		var left, right;
		while(step < this.dataStore.length){
			left = 0;
			right = step;
			while(right + step <= this.dataStore.length){
				this.mergeArrays(this.dataStore,left,left+step,right,right+step);
				left = right + step;
				right = left + step;
			}
			if (right < this.dataStore.length){
				this.mergeArrays(this.dataStore,left,left+step,right,right+this.dataStore.length);
			}
			step *= 2;
		}
	},
	mergeArrays: function(arr, startL, stopL, startR, stopR){
		var rightArr = new Array(stopR - startR + 1);
		var leftArr = new Array(stopL - startL + 1);
		var k = startR;
		for (var i = 0; i < (rightArr.length - 1); i++){
			rightArr[i] = arr[k];
			k++;
		}
		k = startL;
		for (var i = 0; i < (leftArr.length - 1); i++){
			leftArr[i] = arr[k];
			k++;
		}
		rightArr[rightArr.length-1] = Infinity;
		leftArr[leftArr.length-1] = Infinity;
		var m = 0;
		var n = 0;
		for (var k = startL; k < stopR; k++){
			if (leftArr[m] <= rightArr[n]) {
				arr[k] = leftArr[m];
				m++;
			}
			else{
				arr[k] = rightArr[n];
				n++;
			}
		}
	},
	quickSort: function(){
		this.dataStore = this.qSort(this.dataStore);
	},
	qSort: function(arr){
		if (arr.length <= 1) return arr;
		var left = [];
		var right = [];
		var pivot = arr[0];
		for (var i = 1; i < arr.length; i++) {
			if (arr[i] < pivot) {
				left.push(arr[i]);
			}
			else{
				right.push(arr[i]);
			}
		}
		return this.qSort(left).concat(pivot, this.qSort(right));
	},
	test: function(method){
		var start,stop;
		this.setData();
		start = new Date().getTime();
		this[method]();
		stop = new Date().getTime();
		console.log(method + ': ' + (stop - start) + 'ms');
	},
};

var myNums = new CArray(10000);
// myNums.setData();
// myNums.toString();
// myNums.bubbleSort();
// myNums.selectionSort();
// myNums.insertionSort();
// myNums.shellSort();
// myNums.dynamicShellSort();
// myNums.quickSort();
// myNums.mergeSort();
// myNums.toString();

// when array num is 100000
myNums.test('bubbleSort'); // 17675ms
myNums.test('selectionSort'); // 5054ms
myNums.test('insertionSort'); // 2547ms
myNums.test('shellSort'); // 1227ms
myNums.test('dynamicShellSort'); //17ms
myNums.test('quickSort'); //128ms

