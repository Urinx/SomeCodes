function Node(element){
	this.element = element;
	this.next = null;
}

function CLList(){
	this.head = new Node('head');
	this.head.next = this.head;
	this.length = 0;
	this.currNode = this.head;
}

CLList.prototype = {
	find: function(item){
		var currNode = this.currNode;
		while(currNode.element != item){
			currNode = currNode.next;
		}
		return currNode;
	},
	findPrevious: function(item){
		var currNode = this.currNode;
		while(currNode.next.element != item){
			currNode = currNode.next;
		}
		return currNode;
	},
	insert: function(newElement, item){
		var newNode = new Node(newElement),
			current = this.find(item);
		newNode.next = current.next;
		current.next = newNode;
		this.currNode = newNode;
		++this.length;
	},
	remove: function(item){
		var preNode = this.findPrevious(item);
		preNode.next = preNode.next.next;
		this.currNode = preNode.next;
		--this.length;
	},
	display: function(){
		var currNode = this.currNode,
			str = '';
		while(currNode.next != this.currNode){
			str += currNode.element+'->';
			currNode = currNode.next;
		}
		str += currNode.element;
		console.log(str);
	},
	setHead: function(element){
		this.head.element = element;
		++this.length;
	},
	setList: function(arr){
		this.setHead(arr[0]);
		for (var i = 1; i < arr.length; i++) {
			this.insert(arr[i],arr[i-1]);
		}
	},
};

function solveJoseph(n, m, start, rest){
	var people = new CLList(),
		arr = [];
	for (var i = 0; i < n; i++) {
		arr[i] = i+1;
	}
	people.setList(arr);

	var currNode = people.find(start);
	while(people.length > rest){
		for (var i = 0; i < m-1; i++) {
			currNode = currNode.next;
		}
		people.remove(currNode.element);
		currNode = currNode.next;	
	}
	people.display();
}
solveJoseph(40,3,1,2);
