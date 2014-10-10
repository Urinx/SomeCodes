#!/usr/bin/env python
# coding:utf-8
from selenium import webdriver

url='http://baidu.com'
browser=webdriver.Firefox()
browser.get(url)
print browser.title
browser.quit()