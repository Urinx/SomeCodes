define(
	['text!../template/ul.template','text!../template/li.template','wechat','jquery','ractive','dragMove'],
	function(ul_template,li_item,wechat){
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
								this.addItem(ev.node.value);
								ev.node.value='';
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


				var ractive= new ToDoList({
					el:'todolist',
					data:{
						items:[
							{done:true,  description: 'Add a todo item' },
							{done:false, description: 'Add some more' },
							{done:false, description: 'Complete tutorials'}
						],
						placeholder: 'What needs to be done?',
					}
				});

			},

			enableDrag: function(id){
				$.dragMove(id);
			},

			wechatShare: function(title,desc){
				wechat.enableShare(title,desc);
			}
		}
});