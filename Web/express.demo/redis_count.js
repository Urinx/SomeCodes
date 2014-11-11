#! /usr/bin/env node

var express=require('express');
var redis=require('redis');
var db=redis.creareClient();
var app=express();

app.use(function(req,res,next){
	var ua=req.headers['user-agent'];
	db.zadd('omline',Date.now(),ua,next);
});

app.use(function(req,res,next){
	var min=60*1000;
	var ago=Date.now()-min;
	db.zrevrangebyscore('online','+inf',ago,function(err,user){
		if(err) return next(err);
		req.online=users;
		next();
	});
});

app.get('/',function(req,res){
	res.send(req.online.length+' users online');
});

app.listen(1024);