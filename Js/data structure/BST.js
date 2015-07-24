function Node(data,left,right){
	this.data = data;
	this.count = 1;
	this.left = left;
	this.right = right;
}

function BST(){
	this.root = null;
}

BST.prototype = {
	insert: function(data){
		var n = new Node(data, null, null);
		if (this.root == null) {
			this.root = n;
		}
		else{
			var current = this.root;
			var parent = null;
			while(true){
				parent = current;
				if (data < current.data) {
					current = current.left;
					if (current == null) {
						parent.left = n;
						break;
					}
				}
				else{
					current = current.right;
					if (current == null) {
						parent.right = n;
						break;
					}
				}
			}
		}
	},
	// 遍历二叉查找树
	// 中序遍历
	inOrder: function(node,func){
		if (node!=null) {
			this.inOrder(node.left,func);
			func(node);
			this.inOrder(node.right,func);
		}
	},
	// 先序遍历
	preOrder: function(node,func){
		if (node!=null) {
			func(node);
			this.preOrder(node.left,func);
			this.preOrder(node.right,func);
		}
	},
	// 后序遍历
	postOrder: function(node,func){
		if (node!=null) {
			this.postOrder(node.left,func);
			this.postOrder(node.right,func);
			func(node);
		}
	},
	min: function(){
		return this.getMin(this.root);
	},
	getMin: function(node){
		while(node.left != null){
			node = node.left;
		}
		return node.data;
	},
	max: function(){
		return this.getMax(this.root);
	},
	getMax: function(node){
		while(node.right != null){
			node = node.right;
		}
		return node.data;
	},
	find: function(data){
		var current = this.root;
		while(current!=null){
			if (data == current.data) {
				return current;
			}
			else{
				if (data < current.data) {
					current = current.left;
				}
				else{
					current = current.right;
				}
			}
		}
		return null;
	},
	remove: function(data){
		this.root = this.removeNode(this.root,data);
	},
	removeNode: function(node,data){
		if (node == null) {
			return null;
		}
		if (data == node.data) {
			// 没有子节点的节点
			if (node.left == null && node.right == null) {
				return null;
			}
			// 没有左子节点的节点
			if (node.left == null) {
				return node.right;
			}
			// 没有右子节点的节点
			if (node.right == null) {
				return node.left;
			}
			// 有两个子节点的节点
			var tempNodeData = this.getMin(node.right);
			node.data = tempNodeData;
			node.right = this.removeNode(node.right,tempNodeData);
			return node;
		}
		else if (data < node.data) {
			node.left = this.removeNode(node.left,data);
			return node;
		}
		else{
			node.right = this.removeNode(node.right,data);
			return node;
		}
	},
	update: function(data){
		var node = this.find(data);
		node.count++;
		return node;
	},
	nodeNum: function(){
		var count = 0;
		this.inOrder(this.root,function(){
			count++;
		});
		return count;
	},
}

var bst = new BST();
bst.insert(23);
bst.insert(45);
bst.insert(16);
bst.insert(37);
bst.insert(3);
bst.insert(99);
bst.insert(22);
console.log('Inorder traversal:');
bst.inOrder(bst.root,function(node){
	console.log(node.data);
});
console.log('min: '+bst.min());
console.log('max: '+bst.max());
console.log('find: '+bst.find(37));
bst.remove(37);
bst.update(99);
console.log('nodeNum: '+bst.nodeNum());