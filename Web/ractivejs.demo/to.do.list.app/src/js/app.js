define(
	['text!../template/ul.template','text!../template/li.template','wechat','jquery','ractive','dragMove','tap'],
	function(ul_template,li_item,wechat){
		var ractive;
		return {
			build: function(){

				var ToDoList=Ractive.extend({
					template: ul_template,
					partials: { item : li_item },

					init: function(){
						// proxy event handlers
						this.on({
							remove: function(ev){
								this.removeItem(ev.index.i);
							},
							newTodo: function(ev){
								if (this.data.items.length>=5) {
									alert('人生不留遗憾，少写一点吧。');
								} else{
									this.addItem(ev.node.value);
									ev.node.value='';
								};
								ev.node.blur();
							},
							/*
							edit: function(ev){
								this.editItem(ev.index.i);
							},
							stop_editing: function(ev){
								this.set( ev.keypath+'.editing',false );
							},
							*/
						})
					},

					addItem: function(description){
						this.push('items',{
							done: false,
							description: description
						});
						
					},
					removeItem: function(i){
						this.splice('items',i,1);
					},
					/*
					editItem: function(i){
						this.set('items.'+i+'.editing',true);
					},
					*/
				});

				var default_item=[
					{done:true,  description: 'Add a todo item' },
					{done:false, description: 'Add some more' },
					{done:false, description: 'Complete tutorials'}
				];

				ractive= new ToDoList({
					el:'todolist',
					data:{
						items: this.getItem() || default_item,
						placeholder: 'What needs to be done?',
					}
				});
			},

			enableDrag: function(id){
				$.dragMove(id);
			},

			getItem: function(){
				return location.search?location.search.split('&from')[0].slice(1).split('&').map(function(str){
					var a=str.split('=');
					return {description:unescape(a[0]),done:a[1]=='true'?true:false};
				}):null;
			},

			setWechatShareUrl: function(){
				var baseUrl=location.href.split('?')[0]+'?';
				return ractive.data.items.reduce(function(url,item){
					return url+escape(item['description'])+'='+item['done']+'&';
				},baseUrl).slice(0,-1);
			}
		}
});