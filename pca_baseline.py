# -*- coding: utf-8 -*-
"""
Created on Sat Oct 20 00:17:10 2018

@author: 11854
"""
import numpy as np
x=np.array([2.5,0.5,2.2,1.9,3.1,2.3,2,1,1.5,1.1])
y=np.array([2.4,0.7,2.9,2.2,3,2.7,1.6,1.1,1.6,0.9])
data=np.matrix([[scaled_x[i],scaled_y[i]] for i in range(len(scaled_x))])

#求均值以及做normalization
mean_x=np.mean(x)
mean_y=np.mean(y)
scaled_x=x-mean_x
scaled_y=y-mean_y
data=np.matrix([[scaled_x[i],scaled_y[i]] for i in range(len(scaled_x))])

#画图
import matplotlib.pyplot as plt
plt.plot(scaled_x,scaled_y,'o')

#求协方差矩阵
cov=np.cov(scaled_x,scaled_y)

#
np.dot(np.transpose(data),data)







