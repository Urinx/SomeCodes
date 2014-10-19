#! /usr/bin/env python

import sqlite3

# 使用内存中的数据库
cx=sqlite3.connect(':memory:')
cu=cx.cursor()

sql1='create table test (id integer primary key, pid integer,name varchar(10) UNIQUE)'
sql2="insert into test values(0,0,'name1')"
sql3="insert into test values(1,1,'name2')"
cu.execute(sql1)
cu.execute(sql2)
cu.execute(sql3)
cx.commit()

sql4='select * from test'
cu.execute(sql4)
print cu.fetchall()

sql5="update test set name='haha' where id=0"
cu.execute(sql5)
cx.commit()

cu.execute('select * from test')
print cu.fetchone()

cu.close()