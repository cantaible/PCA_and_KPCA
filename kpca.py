# -*- coding: utf-8 -*-
"""
Created on Sun Oct 21 15:32:30 2018

@author: 11854
"""

import numpy as np
import matplotlib.pyplot as plt
from sklearn import preprocessing
import math
#读取数据
filename='data_PCA.txt'

data=[]
featurevector_sort_normal=np.zeros((256,2))
data_mean=np.zeros((256,2))
data_mapped=np.zeros((256,2))
distance_maxtrix_sigma=np.zeros((256,256))
c=np.zeros((256,2))
with open(filename,'r') as file_to_read:
    while True:
        lines=file_to_read.readline()
        if not lines:
            break
            pass
        p_tmp=[float(i) for i in lines.split(',')]
        data.append(p_tmp)
        pass
    data=np.array(data)
    pass


#定义核函数
def kernel(data_mean):
    nun_of_data=data_mean.shape[0]
    distance_maxtrix=np.zeros([nun_of_data,nun_of_data])
    K=np.zeros([nun_of_data,nun_of_data])
    #k是kernel矩阵
    x=np.sum(np.square(data_mean),axis=1)
    distance_maxtrix=x+x.T+np.multiply(-2,np.dot(data_mean,data_mean.T))
    distance_maxtrix_sigma=distance_maxtrix
    distance_maxtrix_sigma[distance_maxtrix_sigma==0]=float('inf') 
    sigma_kernel=5*np.mean(distance_maxtrix_sigma.min(axis=0))
    
    #算距离矩阵
    K=math.exp(distance_maxtrix/sigma_kernel^2/2)
    #将矩阵中的零元素替换为无穷大
    return K
    
    
    

#修改数据使得u=0
data_mean=preprocessing.scale(data)
#data_mean=data-np.mean(data,axis=0)
#data_mean=data_mean.T

#计算k矩阵    
#K=data_mean.T.dot(data_mean)
#K=kernel(data_mean)
nun_of_data=data_mean.shape[0]
distance_maxtrix=np.zeros([nun_of_data,nun_of_data])
K=np.zeros([nun_of_data,nun_of_data])
#k是kernel矩阵
x=np.sum(np.square(data_mean),axis=1)
distance_maxtrix=np.add(x.reshape(1,len(x)),x.reshape(len(x),1))+np.multiply(-2,np.dot(data_mean,data_mean.T))
distance_maxtrix_sigma=np.copy(distance_maxtrix)
distance_maxtrix_sigma[distance_maxtrix_sigma==0]=float('inf') 
sigma=5*np.mean(distance_maxtrix_sigma.min(axis=0))
sigma_kernel=1/np.square(sigma)/2
    
#算距离矩阵
K0=np.exp(-distance_maxtrix*sigma_kernel)
oneN=np.ones_like(K0)
K=K0-oneN.dot(K0)-K0.dot(oneN)+(oneN.dot(K0)).dot(oneN)
#计算K的特征值特征矩阵
eigenvalue,featurevector=np.linalg.eig(K)
featurevector=featurevector.real
eigenvalue=eigenvalue.real
eigenvalue_index=np.argsort(-eigenvalue)
eigenvalue_index=eigenvalue_index[0:2]
#按照降序排列，返回索引
eigenvalue_sort=eigenvalue[eigenvalue_index[0:2]]
featurevector_sort=featurevector[:,eigenvalue_index[0:2]]

for i in range(len(eigenvalue_index)):
    featurevector_sort_normal[:,i]=featurevector_sort[:,i]/np.sqrt(eigenvalue_sort[i])



data_mapped=K.dot(featurevector_sort_normal)
print('pca变换后')
plt.scatter(data_mapped[0:127,0], data_mapped[0:127,1], s=5,c='g')
plt.scatter(data_mapped[128:255,0], data_mapped[128:255,1], s=5,c='b')
plt.show() 




















