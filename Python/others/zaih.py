#!/usr/bin/env python
# coding: utf-8

import requests, urllib, json, time, os, re
from openpyxl import Workbook
import cPickle as pickle
from itertools import *

def pickleSave(data, file):
    """
    @brief      Use pickle to save python object into file
    @param      data  The pyhton data
    @param      file  The file
    """
    with open(file, 'wb') as f:
        pickle.dump(data, f, pickle.HIGHEST_PROTOCOL)


def pickleLoad(file):
    """
    @brief      Use pickle to load python object from file
    @param      file  The file
    @return     python data
    """
    if os.path.isfile(file):
        with open(file, 'rb') as f:
            return pickle.load(f)
    return None

def Log(dict):
    for (key, value) in dict.items():
        print key,':',value
    print '='*30

def get_topics(category, city, page):
    url = 'http://apis.zaih.com/v1/topics'
    params = {
        'category_id': category['id'],
        'city': city,
        'sort': 'comprehensive',
        'page': page,
        'per_page': 100, # max value
    }

    while True:
        try:
            r = requests.get(url, params = params)
            break
        except Exception, e:
            print '[*] error:', e
            time.sleep(5)
    
    js = json.loads(r.content)
    
    if not js:
        return None

    result = []
    for j in js:
        tutor = {
            'tutor_id': j['tutor_id'],
            'category': category['name'],
            'realname': j['tutor_info']['realname'],
            'city': j['tutor_info']['city'],
            'title': j['tutor_info']['title'],
            'url': j['tutor_info']['url'],
        }

        # 获取头像
        tutor['avatar'] = 'avatar/'+str(j['tutor_id'])+'.jpg'
        # if not os.path.exists(tutor['avatar']):
        #     try:
        #         data = requests.get(j['tutor_info']['avatar'])
        #         with open(tutor['avatar'], 'wb') as f:
        #             f.write(data.content)
        #     except Exception, e:
        #         pass

        # 获取讲座者信息
        d = get_tutors(j['tutor_id'], j['id'])
        for (key, value) in d.items():
            tutor[key] = value
        result.append(tutor)

    return result

def get_categories():
    url = 'http://apis.zaih.com/v1/categories'
    r = requests.get(url)
    js = json.loads(r.content)

    result = []
    for j in js:
        if j['parent_id'] == None:
            result.append({
                'name': j['name'],
                'id': j['id'],
            })

    return result

def get_citys():
    url = 'http://apis.zaih.com/apis/open/custom_board/city'
    r = requests.get(url)
    js = json.loads(r.content)

    result = []
    for j in js['values']:
        result.append(j['name'])

    return result

def get_tutors(tutor_id, topic_id):
    url = 'http://apis.zaih.com/apis/open/tutors/' + str(tutor_id)
    r = requests.get(url)
    j = json.loads(r.content)

    d = {
        'meet_location': j['meet_location'],
        'introduction': j['introduction'], # html
        'join_days': j['join_days'],
        'followers': j['followers_count'],
        'meets_count': j['meets_count'],
        'nickname': j['nickname'],
        'mobile': j['mobile'],
        'summary': j['summary'],
    }

    for topic in j['topics']:
        if topic_id == topic['id']:
            d['topic_id'] = topic['id']
            d['topic_title'] = topic['title']
            d['topic_price'] = topic['price']
            d['topic_summary'] = topic['summary']
            d['topic_introduction'] = topic['introduction']
            d['topic_met_count'] = topic['met_count']

    return d

def save_to_excel(data_arr, file_name):
    ILLEGAL_CHARACTERS_RE = re.compile(r'[\000-\010]|[\013-\014]|[\016-\037]')
    col = data_arr[0].keys()
    wb = Workbook()
    ws = wb.active
    ws.append(col)

    def check_str(s):
        if s:
            if type(s) == unicode:
                t = re.sub(r'(<[^>]+>)', '', s.strip())
                return ILLEGAL_CHARACTERS_RE.sub(r'', t)
            else: return s
        else: return ''

    for data in data_arr:
        values = [check_str(data[c]) for c in col]
        try:
            ws.append(values)
        except:
            for v in values:
                print v
            exit()

    wb.save(file_name)

def main():
    categories = get_categories()
    citys = get_citys()[1:]
    items = list(product(citys, categories))

    data_arr = []
    print '[*] All count:',len(items)
    count = -1
    for (city, category) in items:
        count += 1
        print '[*] item:', count

        page = 0
        while True:
            page += 1
            d = None

            while True:
                try:
                    print '[*] %s %s, p: %d' % (city, category['name'], page)
                    d = get_topics(category, city, page)
                    break
                except Exception, e:
                    print '[*] error:', e
                    time.sleep(5)

            if d:
                data_arr.append(d)
            else:
                break

        print '[*] save pickle'
        pickleSave(data_arr, 'data'+str(count)+'.pkl')
        data_arr = []

    print '[*] done'

def process_data(data_arr):
    t = {}
    for d in data_arr:
        tid = d['tutor_id']
        if tid in t:
            t[tid].append(d)
        else:
            t[tid] = [d]

    r = []
    for ds in t.values():
        if len(ds) == 1:
            r.append(ds[0])
        else:
            category = []
            city = []
            topic = []
            tid = []
            for d in ds:
                if d['category'] not in category:
                    category.append(d['category'])
                if d['city'] not in city:
                    city.append(d['city'])
                if d['topic_id'] not in tid:
                    tid.append(d['topic_id'])
                    topic.append(d)
            
            category = ', '.join(category)
            city = ', '.join(city)
            for tp in topic:
                tp['category'] = category
                tp['city'] = city
                r.append(tp)

    return r

def load_data():
    data_arr = []
    for i in range(81):
        file = 'data/data'+str(i)+'.pkl'
        data = pickleLoad(file)
        for d_arr in data:
            data_arr.extend(d_arr)

    data_arr = process_data(data_arr)
    save_to_excel(data_arr, '在行.xlsx')

# main()
load_data()


