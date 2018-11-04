clc
clear
dir = 'data_PCA.txt';
data=pcaRead(dir);
[data,m,sigma]=zscore(data);
N=size(data,1);
disp('开始计算');


%N为样本的个数
%K0=kernel(data);
X=data;
N = size(X,1); %行数，即为数据个数
DIST=zeros(N,N);
for i=1:N
    for j=1:N
        diff=X(i,:)-X(j,:);
        DIST(i,j)=sqrt(diff*diff');
    end
end
DIST(DIST==0)=inf;
%inf为无穷大
DIST1=min(DIST);
sigma_kernel=5*mean(DIST1);
%sigma_kernel=5
K0 = zeros(N);

tmp = zeros(N,N);
        for i = 1:N
            for j = 1:N
                tmp(i,j) = norm(X(i,:)-X(j,:));
            end
        end   
        K0 = exp(-0.5*(tmp/sigma_kernel).^2);



%K0=data*data';
oneN=ones(N,N)/N;
K=K0-oneN*K0-K0*oneN+oneN*K0*oneN;
%K=K0;
%K即为书上的K矩阵

%获取特征值和特征向量
[V,D]=eig(K/N);
%V=real(V);
%D=real(D);
eigValue=diag(D);
[~,IX]=sort(eigValue,'descend');
%忽略第一个参数
eigVector=V(:,IX);
%重新排序V特征向量组成的矩阵
eigValue=eigValue(IX);
%重新排列特征值

%标准化
norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

eigVector=eigVector(:,1:2);
%d为要选的维数
Y3=K0*eigVector;
figure;
hold on;
%plot(Y3(1:end,1),Y3(1:end,2),'b*');
plot(Y3(1:128,1),Y3(1:128,2),'ro');
plot(Y3(129:end,1),Y3(129:end,2),'b*');
drawnow;
