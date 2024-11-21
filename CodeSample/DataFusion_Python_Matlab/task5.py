# -*- coding: utf-8 -*-
"""
Created on Sun Jun  6 21:21:27 2021

@author: hazelxxz
"""

    import numpy as np
    import pandas as pd
    import math
    data = pd.read_excel("task5.xlsx") # 读取excle
    x = data.values
    x.tolist() 
    X= np.delete(x,0,axis=1)
    X=np.delete(X,0,axis=1)
    #0-5线圈 6-11浮动车 12avi 13全程干线 14-19正确1-6
#    x1=X[:,0]
#    x2=X[:,1]
#    x3=X[:,2]
#    x4=X[:,3]
#    x5=X[:,4]
#    x6=X[:,5]
#    f1=X[:,6]
#    f2=X[:,7]
#    f3=X[:,8]
#    f4=X[:,9]
#    f5=X[:,10]
#    f6=X[:,11]
#    r1=X[:,14]
#    r2=X[:,15]
#    r3=X[:,16]
#    r4=X[:,17]
#    r5=X[:,18]
#    r6=X[:,19]
#    avi=X[:,12]
#    QG=X[:,13]
    N=168 #样本数
    x1=0
    x2=0
    x3=0
    x4=0
    x5=0
    x6=0
    f1=0
    f2=0
    f3=0
    f4=0
    f5=0
    f6=0
    avi=0
    for i in range(168):
       x1=x1+(X[i,0]-X[i,14])**2
       x2=x2+(X[i,1]-X[i,15])**2
       x3=x3+(X[i,2]-X[i,16])**2
       x4=x4+(X[i,3]-X[i,17])**2
       x5=x5+(X[i,4]-X[i,18])**2
       x6=x6+(X[i,5]-X[i,19])**2
       f1=f1+(X[i,6]-X[i,14])**2
       f2=f2+(X[i,7]-X[i,15])**2
       f3=f3+(X[i,8]-X[i,16])**2
       f4=f4+(X[i,9]-X[i,14])**2
       f5=f5+(X[i,10]-X[i,15])**2
       f6=f6+(X[i,11]-X[i,16])**2
       avi=avi+(X[i,12]-X[i,13])**2
    RMSE=[]                 
    RMSE.append(math.sqrt(x1/N))
    RMSE.append(math.sqrt(x2/N))
    RMSE.append(math.sqrt(x3/N))
    RMSE.append(math.sqrt(x4/N))
    RMSE.append(math.sqrt(x5/N))
    RMSE.append(math.sqrt(x6/N))
    RMSE.append(math.sqrt(f1/N))
    RMSE.append(math.sqrt(f2/N))
    RMSE.append(math.sqrt(f3/N))
    RMSE.append(math.sqrt(f4/N))
    RMSE.append(math.sqrt(f5/N))
    RMSE.append(math.sqrt(f6/N))
    RMSE.append(math.sqrt(avi/N))
    print(RMSE)
    

    MAPE=[]
    x1=0
    x2=0
    x3=0
    x4=0
    x5=0
    x6=0
    f1=0
    f2=0
    f3=0
    f4=0
    f5=0
    f6=0
    avi=0
    for i in range(168):
       x1=x1+abs((X[i,0]-X[i,14])/X[i,14])
       x2=x2+abs((X[i,1]-X[i,15])/X[i,15])
       x3=x3+abs((X[i,2]-X[i,16])/X[i,16])
       x4=x4+abs((X[i,3]-X[i,17])/X[i,17])
       x5=x5+abs((X[i,4]-X[i,18])/X[i,18])
       x6=x6+abs((X[i,5]-X[i,19])/X[i,19])
       f1=f1+abs((X[i,6]-X[i,14])/X[i,14])
       f2=f2+abs((X[i,7]-X[i,15])/X[i,15])
       f3=f3+abs((X[i,8]-X[i,16])/X[i,16])
       f4=f4+abs((X[i,9]-X[i,14])/X[i,17])
       f5=f5+abs((X[i,10]-X[i,15])/X[i,15])
       f6=f6+abs((X[i,11]-X[i,16])/X[i,16])
       avi=avi+abs((X[i,12]-X[i,13])/X[i,13])              
    MAPE.append(x1/N)
    MAPE.append(x2/N)
    MAPE.append(x3/N)
    MAPE.append(x4/N)
    MAPE.append(x5/N)
    MAPE.append(x6/N)
    MAPE.append(f1/N)
    MAPE.append(f2/N)
    MAPE.append(f3/N)
    MAPE.append(f4/N)
    MAPE.append(f5/N)
    MAPE.append(f6/N)
    MAPE.append(avi/N)
    print(MAPE)