function seqSearch(arr, data){
	for (var i = 0; i < arr.length; i++) {
		if (arr[i] == data && i > (arr.length*0.2)) {
			var tmp = arr[0];
			arr[0] = arr[i];
			arr[i] = tmp;
			return true;
		}
		else if(arr[i] == data){
			return true;
		}
	}
	return false;
}

function binSearch(arr, data){
	var upperBound = arr.length - 1;
	var lowerBound = 0;
	while(lowerBound <= upperBound){
		var mid = Math.floor((upperBound + lowerBound)/2);
		if (arr[mid] < data) {
			lowerBound = mid + 1;
		}
		else if(arr[mid] > data){
			upperBound = mid - 1;
		}
		else{
			return mid;
		}
	}
	return -1;
}