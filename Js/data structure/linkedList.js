function Node(element){
	this.element = element;
	this.next = null;
}

function LList(){
	this.head = new Node('head');
}

LList.prototype = {
	find: function(item){
		var currNode = this.head;
		while(currNode.element != item){
			currNode = currNode.next;
		}
		return currNode;
	},
	findPrevious: function(item){
		var currNode = this.head;
		while(currNode.next != null && currNode.next.element != item){
			currNode = currNode.next;
		}
		return currNode;
	},
	insert: function(newElement, item){
		var newNode = new Node(newElement),
			current = this.find(item);
		newNode.next = current.next;
		current.next = newNode;
	},
	remove: function(item){
		var preNode = this.findPrevious(item);
		if(preNode.next != null){
			preNode.next = preNode.next.next;
		}
	},
	display: function(){
		var currNode = this.head;
		while(currNode.next != null){
			console.log(currNode.next.element);
			currNode = currNode.next;
		}
	},
};

var cities = new LList();
cities.insert('Conway', 'head');
cities.insert('Russellville', 'Conway');
cities.insert('Carlisle', 'Russellville');
cities.insert('Alma', 'Carlisle');
cities.display();
cities.remove('Carlisle');
cities.display();