# -*- coding: utf-8 -*-
"""
Created on Sun Aug 14 12:42:10 2022
python预处理：包含分词、去除停用词
@author: hazelxxz
"""

import jieba
import numpy as np
import pandas as pd
import csv
from collections import Counter

#去除非中文字符
def format_str(document):
    content_str=''
    for _char in document:
        if (_char >= u'\u4e00' and _char <= u'\u9fa5') or (_char >= u'A' and _char <= u'\Z'):
            content_str = content_str + _char
        else:
            continue
    
    return content_str 
#词频统计
def counter(txt):
    seg_list = txt
    c = Counter()
    for w in seg_list:
        if w is not ' ':
            c[w] += 1
    return c

#分词
def cut_word(Test):
    # jieba 默认启用了HMM（隐马尔科夫模型）进行中文分词
    seg_list = jieba.lcut(Test,cut_all=False)  # 分词
    #返回一个以分隔符'/'连接各个元素后生成的字符串
    line = "/".join(seg_list)
    word = out_stopword2(line)
    #print(line)
    #列出关键字
#    print("\n关键字：\n"+word)
    return word
def out_stopword2(seg):
#    打开写入关键词的文件
#    keyword = open('D:\\final\\keyword.txt', 'w+', encoding='utf-8')
#    print("去停用词：\n")
    wordlist = []

    #获取停用词表
    stop = open('D:\\final\\both_stopwords.txt', 'r+', encoding='utf-8')
    #用‘\n’去分隔读取，返回一个一维数组
    stopword = stop.read().split("\n")
    station = open('D:\\final\\stationdict.txt', 'r+', encoding='utf-8')
    #用‘\n’去分隔读取，返回一个一维数组
    stationword = station.read().split("\n")
    date = open('D:\\final\\userdict.txt', 'r+', encoding='utf-8')
    #用‘\n’去分隔读取，返回一个一维数组
    dateword = date.read().split("\n")
    num4 = open('D:\\final\\LDAclean.txt', 'r+', encoding='utf-8')
    #用‘\n’去分隔读取，返回一个一维数组
    num4word = num4.read().split("\n")
    #遍历分词表
    for key in seg.split('/'):
        #print(key)
        #去除停用词，去除单字，去除重复词,去除纯数字字符串
        if not(key.strip() in stopword) and not str.isdigit(key) and not(key.strip() in num4word) and not(key.strip() in stationword) and not(key.strip() in dateword) and (len(key.strip()) > 1) and not(key.strip() in wordlist)  :
            wordlist.append(key)
#            print(key)
#            keyword.write(key+"\n")

    #停用词去除END
    stop.close()
#    keyword.close()
    return '/'.join(wordlist)


if __name__ == '__main__':
    df = pd.read_excel(r'title_state_all.xlsx',sheet_name=0)
    content_list = df['state'].tolist()
    title_list = df['title'].tolist()
    content_jieba=[]
    
    ##得到纯中文text
    chinese_list = []
    for i,content in enumerate(content_list):
        content = content + title_list[i]
        chinese_list.append(format_str(content))

    ##导入停用词库
    file_userdict = 'userdict.txt' #包含日期(x年、x月、x日)、时间（x时x分）
    station_dict = 'stationdict.txt' #包含车站 xx xx站
    clean_dict = 'LDAclean.txt' #包含线路
    late1_dict = 'late1.txt' 
    late2_dict = 'late2.txt' 
    jieba.load_userdict(file_userdict)
    jieba.load_userdict(station_dict)
    jieba.load_userdict(clean_dict)
    jieba.load_userdict(late1_dict)
    jieba.load_userdict(late2_dict)
    ##分词
    for i,chinese in enumerate(chinese_list):
        #去除列表每个文本前的空格
        text = chinese.lstrip()
        #去除文本中的数字
        temp = cut_word(text)
        content_jieba.append(temp)
     
#    ##统计词频,保存为csv文件
#    a=''
#    for i in content_jieba:
#        a =  a +''.join(i)#换行
#    a=a.replace('/',' ')    
#     b={}
#     for word in a:
#         if word not in b:
#             b[word]=1
#         else:
#             b[word]=b[word]+1
#    b= counter(a)
#    
#    ##储存为词典，保存为csv
#    dict(b)
#    header=['r-num','count']
#    with open('test.csv','w',newline='')as f:
#        writer=csv.writer(f)
#        writer.writerow(header)
#        for key,value in b.items():
#            writer.writerow([key,value])

    
   
   ##输出为xlxs
    new_col = ['ti_st_clean']
    fenci = pd.DataFrame(content_jieba)
    fenci.columns = new_col
    
    fenci.to_excel('pre.xlsx', sheet_name='result')