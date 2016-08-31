#!/usr/bin/env python
# coding: utf-8

import requests, re
from bs4 import BeautifulSoup
from openpyxl import Workbook

count = 0

def Log(dict):
    for (key, value) in dict.items():
        if key != 'activity':
            print key,':',value
    print '='*30

def get_total_page_num(url):
    n = 1
    r = requests.get(url % n)
    m = re.search('共<span id="numBig">(\d+)</span>页', r.content)
    return int(m.group(1))

def get_subject_list(url, page_num, subject):
    global count
    r = requests.get(url % page_num)
    soup = BeautifulSoup(r.content, "lxml")
    s_list = soup.find('ul', class_='find_main_ul')
    subjects = s_list.select('div.find_main_div')

    arr = []
    for s in subjects:
        count += 1
        d = {
            'id': count,
            'subject': subject,
        }
        div_title = s.select('div.find_main_title')[0]
        div_address = s.find('div', class_='find_main_address')
        a_member = s.find('a', class_='hd_mem_name_A')

        d['link'] = 'http://www.hdb.com' + div_title.a['href']
        d['title'] = div_title.a.h4.text
        d['member'] = a_member.text
        d['location'] = div_address.p.text if div_address else ''

        [activity, tel] = get_subject_details(d['link'])
        d['activity'] = activity
        d['tel'] = tel
        Log(d)
        arr.append(d)

    return arr

def get_subject_details(url):
    r = requests.get(url)
    soup = BeautifulSoup(r.content, "lxml")
    content = soup.find('div', class_='dt_content')
    if not content: return ['', '']

    span = content.find_all('span')

    text = ''
    for s in span:
        text += s.text + '\n'
    activity = text

    # 匹配电话
    reg = r'\s*(?:\+?(\d{1,3}))?([-. (]*(\d{3})[-. )]*)?((\d{3})[-. ]*(\d{2,4})(?:[-.x ]*(\d+))?)\s*'
    m = re.search(reg, activity)
    tel = m.group() if m else ''

    return [activity, tel]

def save_data_to_excel(data_arr, file):
    col = data_arr[0].keys()
    wb = Workbook()
    ws = wb.active
    ws.append(col)
    for data in data_arr:
        ws.append([data[c] for c in col])
    wb.save(file)

def fetch_routine(subject, url, excel):
    print '[*] Subject:', subject
    print '[*] URL:', url
    total_page_num = get_total_page_num(url)
    print '[*] Total page number:', total_page_num
    print '[*] Start Fetch ...'
    data_arr = []
    for i in xrange(total_page_num):
        data_arr.extend(get_subject_list(url, i+1, subject))
    save_data_to_excel(data_arr, excel)

def main():
    url_IT = 'http://www.hdb.com/find/quanguo-fl9r-sjbx-p%d/'
    url_Train = 'http://www.hdb.com/find/quanguo-flmj-sjbx-p%d/'
    # fetch_routine('IT与互联网', url_IT, '1.xlsx')
    fetch_routine('职业与培训', url_Train, '2.xlsx')

main()