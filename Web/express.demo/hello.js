#! /usr/bin/env node
// http://www.expressjs.com.cn/guide.html

var express=require('express');
var app=express();

app.set('views','./views');
app.set('view engine','jade');
app.engine('jade',require('jade').__express);

app.get('/',function(req,res){
	res.render('index',{title:'My first app',message:'Hello World'});
});

var server=app.listen(1024,function(){
	console.log('Listening on port %d',server.address().port);
});