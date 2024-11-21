# -*- coding: utf-8 -*-
"""
Created on Wed Apr  6 16:58:39 2022
LDA优化
@author: hazelxxz
"""


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import codecs
from gensim import corpora 
from gensim import models
from gensim.models import LdaModel
from gensim.corpora import Dictionary
import pyLDAvis.gensim
from pprint import pprint




if __name__ == '__main__':
    #得到空格隔开的N个字符串组成的描述列表
    df = pd.read_excel(r'data_wanhui_guiguangtai.xlsx',sheet_name=0)
    content_list = df['documents'].tolist()
    text_list = []
    for content in content_list:
        temp = content.replace('/',' ')
        text_list.append(temp)
    #结果写入txt
    result=''
    for i in text_list:
        result =  result +''.join(i)+'\n'#换行
    txt = open("data_lda.txt", "w").write(result)    
       
    
    #调用api实现模型
    train = []
    
    fp = codecs.open('data_lda.txt','r',encoding='gbk')
    for line in fp:
        if line != '':
            line = line.split()
            train.append([w for w in line])
    
    dictionary = corpora.Dictionary(train)
    
    corpus = [dictionary.doc2bow(text) for text in train]
    

    

    #可视化
    lda = LdaModel(corpus=corpus, id2word=dictionary, num_topics=10, passes=120)
    d8=pyLDAvis.gensim.prepare(lda, corpus, dictionary)
    pyLDAvis.show(d8)
    

    
#    pyLDAvis.save_html(d, 'lda_pass60_topic18.html')	# 将结果保存为该html文件
    #保存为独立网页
#    http://127.0.0.1:8888/#topic=0&lambda=1&term=
#	pyLDAvis.save_html(d, 'lda_pass10.html')
    #保存模型
   lda.save('lda.model_10')
#    
    lda = models.ldamodel.LdaModel.load('lda.model_10')
    #输出每个文档属于的主题
    output = []
    for i in lda.get_document_topics(corpus)[:]:
        listj=[]
        for j in i:
            listj.append(j[1])
        bz=listj.index(max(listj))
        output.append(bz)
   
    topic_num = pd.DataFrame(output)
    topic_num.to_excel('lda_topic1.xlsx')
    
    num_topic = pd.read_excel(r'lda_topic1.xlsx',sheet_name=1)
    num_list = num_topic['num'].tolist()
    topic_num = pd.read_excel(r'lda_topic1.xlsx',sheet_name=0)
    topic_list = topic_num[0].tolist()
    result=[]
    for i in num_list :
        temp = i
        temp1=temp-2
        result.append(topic_list[temp1])
    result = pd.DataFrame(result)
    result.to_excel('lda_topic2.xlsx')   