#!/usr/bin/env python
# coding:utf-8
from selenium import webdriver
from selenium.webdriver.common.keys import Keys

url='http://baidu.com'
browser=webdriver.Firefox()
browser.get(url)

elem=browser.find_element_by_id('kw1')
elem.send_keys('urinx')
elem.send_keys(Keys.RETURN)
# or browser.find_element_by_id('su1').click()
#browser.quit()