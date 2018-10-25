clc
clear
dir = 'data_PCA.txt';
data=pcaRead(dir);
%dataOrigin=data;
[dataOrigin,m,sigma]=zscore(data);
%标准化
%Y1=PCA(dataOrigin,2);
d=2;
Sx=cov(dataOrigin);
[V,D]=eig(Sx);
%v是特征向量，D是由特征值组成的对角矩阵
eigValue=diag(D);
%eigValue是从对角矩阵
[eigValue,IX]=sort(eigValue,'descend');
%ix是按照从高到低的顺序排列得到的索引
eigVector=V(:,IX);
%按照特征值给特征向量排序

norm_eigVector=sqrt(sum(eigVector.^2));
eigVectorRepmat=eigVector./repmat(norm_eigVector,size(eigVector,1),1);
%将矩阵A复制m*n块，即把A视为B的元素，B 由 m*n 个A平铺而成。
%B 的维数是 [size(A,1)*m,size(A,2)*n]
eigVectorRepmatd=eigVectorRepmat(:,1:d);
%d为要选的维数
Y1=dataOrigin*eigVectorRepmatd;


figure;
hold on;
%plot(dataOrigin(1:end,1),dataOrigin(1:end,2),'ro');
%plot(Y1(1:end,1),Y1(1:end,2),'b*');
plot(Y1(1:128,1),Y1(1:128,2),'ro');
plot(Y1(129:end,1),Y1(129:end,2),'b*');