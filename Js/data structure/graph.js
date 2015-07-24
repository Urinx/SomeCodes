function Vertex(label){
	this.label = label;
}

function Graph(v){
	this.vertices = v;
	this.edges = 0;
	this.adj = [];
	this.marked = [];
	this.edgeTo = [];
	for (var i = 0; i < this.vertices; i++) {
		this.adj[i] = [];
		this.marked[i] = false;
	}
}

Graph.prototype = {
	addEdge: function(v, w){
		this.adj[v].push(w);
		this.adj[w].push(v);
		this.edges++;
	},
	showGraph: function(){
		for (var i = 0; i < this.vertices; i++) {
			console.log(i+' -> '+this.adj[i].join(' '));
		}
	},
	// 深度优先搜索
	dfs: function(v, func){
		this.marked[v] = true;
		func && func(v);
		for (var w of this.adj[v]) {
			if (!this.marked[w]) {
				this.dfs(w, func);
			}
		}
	},
	// 广度优先搜索
	bfs: function(s, func){
		var queue = [];
		this.marked[s] = true;
		queue.push(s);
		while(queue.length > 0){
			var v = queue.shift();
			func && func(v);
			for (var w of this.adj[v]){
				if (!this.marked[w]) {
					this.edgeTo[w] = v;
					this.marked[w] = true;
					queue.push(w);
				}
			}
		}
	},
	pathTo: function(s, v){
		if (!this.hasPathTo(v)) {
			return undefined;
		}
		var path = [];
		for (var i = v; i != s; i = this.edgeTo[i]) {
			path.push(i);
		}
		path.push(s);
		return path.reverse();
	},
	hasPathTo: function(v){
		return this.marked[v];
	},
	clear: function(){
		this.edgeTo = [];
		for (var i = 0; i < this.vertices; i++) {
			this.marked[i] = false;
		}
	},
	topSort: function(){
		var stack = [];
		var visited = [];
		for (var i = 0; i < this.vertices; i++) {
			visited[i] = false;
		}
		for (var i = 0; i < this.vertices; i++) {
			if (visited[i] == false){
				this.topSortHelper(i, visited, stack);
			}
		}
	},
	topSortHelper: function(v, visited, stack){
		visited[v] = true;
		for (var w of this.adj[v]){
			if (!visited[w]){
				this.topSortHelper(visited[w], visited, stack);
			}
		}
		stack.push(v);
	},
};

var g = new Graph(5);
g.addEdge(0,1);
g.addEdge(0,2);
g.addEdge(1,3);
g.addEdge(2,4);
g.showGraph();
g.dfs(0, function(v){
	console.log('dfs visit '+v);
});
g.clear();

g.bfs(0, function(v){
	console.log('bfs visit '+v);
});
var paths = g.pathTo(0, 4);
console.log(paths.join('->'));
