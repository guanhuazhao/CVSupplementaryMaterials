# -*- coding: utf-8 -*-
"""
Created on Sun Jun  6 18:10:45 2021

@author: hazelxxz
"""
    import numpy as np
    import pandas as pd
    import math
    #读取数据
    data = pd.read_excel("task4.xlsx") # 读取excle
    x = data.values
    x.tolist() 
    X= np.delete(x,0,axis=1)
    X=np.delete(X,0,axis=1)
    #数据分割成数组
    x3=X[:,0]
    f3=X[:,1]
    r3=X[:,2]
    x6=X[:,3]
    f6=X[:,4]
    r6=X[:,5]
    xr3= [[0]*2 for i in range(168)]
    fr3= [[0]*2 for i in range(168)]
    xr6= [[0]*2 for i in range(168)]
    fr6= [[0]*2 for i in range(168)]
    for i in range(168):
        xr3[i][0]=X[i,0]
        xr3[i][1]=X[i,2]
        fr3[i][0]=X[i,1]
        fr3[i][1]=X[i,2]
        xr6[i][0]=X[i,3]
        xr6[i][1]=X[i,5]
        fr6[i][0]=X[i,4]
        fr6[i][1]=X[i,5]
        
    #欧几里得距离
    rxr3= [[0]*168 for i in range(168)]
    rfr3= [[0]*168 for i in range(168)]
    rxr6= [[0]*168 for i in range(168)]
    rfr6= [[0]*168 for i in range(168)]
    for i in range(168):
        for j in range(168):
             rxr3[i][j]=math.sqrt(((xr3[i][0]-xr3[j][0])**2+(xr3[i][1]-xr3[j][1])**2))
             rfr3[i][j]=math.sqrt(((fr3[i][0]-fr3[j][0])**2+(fr3[i][1]-fr3[j][1])**2))
             rxr6[i][j]=math.sqrt(((xr6[i][0]-xr6[j][0])**2+(xr6[i][1]-xr6[j][1])**2))
             rfr6[i][j]=math.sqrt(((fr6[i][0]-fr6[j][0])**2+(fr6[i][1]-fr6[j][1])**2))
    #outpot
    output = open('ojld.xls','w',encoding='gbk')
    for i in range(len(rxr3)):
    	for j in range(len(rxr3[i])):
    		output.write(str(rxr3[i][j]))    #write函数不能写int类型的参数，所以使用str()转化
    		output.write('\t')   #相当于Tab一下，换一个单元格
    	output.write('\n')       #写完一行立马换行
    output.close()
    
    output = open('ojld.xls','w',encoding='gbk')
    for i in range(len(rfr3)):
    	for j in range(len(rfr3[i])):
    		output.write(str(rfr3[i][j]))    #write函数不能写int类型的参数，所以使用str()转化
    		output.write('\t')   #相当于Tab一下，换一个单元格
    	output.write('\n')       #写完一行立马换行
    output.close()
    
        output = open('ojld.xls','w',encoding='gbk')
    for i in range(len(rxr6)):
    	for j in range(len(rxr6[i])):
    		output.write(str(rxr6[i][j]))    #write函数不能写int类型的参数，所以使用str()转化
    		output.write('\t')   #相当于Tab一下，换一个单元格
    	output.write('\n')       #写完一行立马换行
    output.close()
    
        output = open('ojld.xls','w',encoding='gbk')
    for i in range(len(rfr6)):
    	for j in range(len(rfr6[i])):
    		output.write(str(rfr6[i][j]))    #write函数不能写int类型的参数，所以使用str()转化
    		output.write('\t')   #相当于Tab一下，换一个单元格
    	output.write('\n')       #写完一行立马换行
    output.close()

    
    
    ###DTW
    def dtw_distance(ts_a, ts_b, d=lambda x,y: abs(x-y), mww=10000):
        """Computes dtw distance between two time series
        Args:
        ts_a: time series a
        ts_b: time series b
        d: distance function
        mww: max warping window, int, optional (default = infinity)
        Returns:
        dtw distance
        """
        # Create cost matrix via broadcasting with large int
        ts_a, ts_b = np.array(ts_a), np.array(ts_b)
        M, N = len(ts_a), len(ts_b)
        cost = np.ones((M, N))
        # Initialize the first row and column
        cost[0, 0] = d(ts_a[0], ts_b[0])
        for i in range(1, M):
            cost[i, 0] = cost[i-1, 0] + d(ts_a[i], ts_b[0])     
        for j in range(1, N):
            cost[0, j] = cost[0, j-1] + d(ts_a[0], ts_b[j])
        
        # Populate rest of cost matrix within window
        for i in range(1, M):
            for j in range(max(1, i - mww), min(N, i + mww)):
                 choices = cost[i-1, j-1], cost[i, j-1], cost[i-1, j]
                 cost[i, j] = min(choices) + d(ts_a[i], ts_b[j])             
        # Return DTW distance given window 
        return cost[-1, -1]
   dtw=[]
   dtw.append(dtw_distance(x3,r3,d=lambda x,y: abs(x-y), mww=10000))
   dtw.append(dtw_distance(f3,r3,d=lambda x,y: abs(x-y), mww=10000))
   dtw.append(dtw_distance(x6,r6,d=lambda x,y: abs(x-y), mww=10000))
   dtw.append(dtw_distance(f6,r6,d=lambda x,y: abs(x-y), mww=10000))
   print(dtw)
   
   ##协方差
   rcov=[]
   rcov.append(np.cov(x3,r3))
   rcov.append(np.cov(f3,r3))
   rcov.append(np.cov(x6,r6))
   rcov.append(np.cov(f6,r6))
   rcoef=[]
   rcoef.append(np.corrcoef(x3,r3))
   rcoef.append(np.corrcoef(f3,r3))
   rcoef.append(np.corrcoef(x6,r6))
   rcoef.append(np.corrcoef(f6,r6))