function dynFib(n){
	var val = [];
	val[1] = 1;
	val[2] = 1;
	for (var i = 3; i <= n; i++) {
		val[i] = val[i-1] + val[i-2];
	}
	return val[n];
}

function lcs(word1, word2){
	var max = 0;
	var index = 0;
	var lcsarr = new Array(word1.length+1);
	for (var i = 0; i <= word1.length + 1; i++){
		lcsarr[i] = new Array(word2.length + 1);
		for (var j = 0; j <= word2.length + 1; j++){
			lcsarr[i][j] = 0;
		}
	}

	for (var i = 0; i <= word1.length; i++) {
		for (var j = 0; j <= word2.length; j++){
			if (i == 0 || j == 0) {
				lcsarr[i][j] = 0;
			}
			else{
				if (word1[i-1] == word2[j-1]) {
					lcsarr[i][j] = lcsarr[i-1][j-1] + 1;
				}
			}
			if (max < lcsarr[i][j]) {
				max = lcsarr[i][j];
				index = i;
			}
		}
	}

	var str = '';
	for (var i = index - max; i <= max; i++) {
		str += word2[i];
	}
	return str;
}

// 递归
function knapsack(capacity, size, value, n){
	function max(a, b){
		return a>b ? a:b;
	}

	if (n == 0 || capacity == 0){
		return 0;
	}
	if (size[n-1] > capacity){
		return knapsack(capacity, size, value, n-1);
	}
	else{
		return max(value[n-1]+knapsack(capacity-size[n-1],size,value,n-1), knapsack(capacity, size, value, n-1));
	}
}
// 动态规划
function dKnapsack(capacity, size, value, n){
	function max(a, b){
		return a>b ? a:b;
	}

	var K = [];
	for (var i = 0; i <= n; i++){
		K[i] = [];
	}
	for (var i = 0; i <= n; i++) {
		for (var w = 0; w <= capacity; w++){
			if (i == 0 || w == 0) {
				K[i][w] = 0;
			}
			else if(size[i-1] <= w){
				K[i][w] = max(value[i-1]+K[i-1][w-size[i-1]], K[i-1][w]);
			}
			else{
				K[i][w] = K[i-1][w];
			}
		}
	}
	return K[n][capacity];
}
// 贪心算法
function gKnapsack(capacity, size, value, n){
	var load = 0;
	var i = 0;
	var w = 0;
	while(load < capacity && i < n){
		if (size[i] <= (capacity - load)) {
			w += value[i];
			load += size[i];
		}
		else{
			var r = (capacity-load)/size[i];
			w += r * value[i];
			load += size[i];
		}
		i++;
	}
	return w;
}
var value = [4, 5, 10, 11, 13];
var size = [3, 4, 7, 8, 9];
var capacity = 16;
var n = 5;
knapsack(capacity, size, value, n);
dKnapsack(capacity, size, value, n);
gKnapsack(capacity, size, value, n);

// 贪心算法
function makeChange(origAmt, coins){
	var remainAmt = 0;
	var coinNum = [];
	for (var i = 0; i < coins.length; i++) {
		coinNum[i] = 0;
		if (origAmt % coins[i] < origAmt) {
			coinNum[i] = parseInt(origAmt / coins[i]);
			remainAmt = origAmt % coins[i];
			origAmt = remainAmt;
		}
	}
	return coinNum;
}
var origAmt = .63;
var coins = [.25, .1, .05, .01];
makeChange(origAmt, coins);


