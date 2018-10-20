# -*- coding: utf-8 -*-
"""
Created on Fri Oct 19 22:24:06 2018

@author: 11854
"""

import numpy as np
import matplotlib.pyplot as plt
#读取数据
filename='data_PCA.txt'

data=[]
data_mean=np.zeros((265,2))
data_mapped=np.zeros((265,2))
c=np.zeros((265,2))
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

#修改数据使得u=0
data_mean=data-np.mean(data,axis=0)

#计算c矩阵
c=data_mean.T.dot(data_mean)

#求c的特征值和特征向量
eigenvalue,featurevector=np.linalg.eig(c)
#featurevector=featurevector.T
#featurevector的每一行为一个特征向量
#featurevector=[[-0.7071067812,-0.7071067812],[0.7071067812,-0.7071067812]]

#映射到新的空间
for i in range(len(data_mean)):
    data_mapped[i]=data_mean[i].dot(featurevector)
    
#画图
print('pca变换前')
plt.scatter(data[:,0], data[:,1], s=5) 
plt.show()    
print('pca变换后')
plt.scatter(data_mapped[:,0], data_mapped[:,1], s=5)
plt.show() 