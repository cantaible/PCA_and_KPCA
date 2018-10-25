clc
clear
dir = 'data_PCA.txt';
data=pcaRead(dir);
[data,m,sigma]=zscore(data);
N=size(data,1);
disp('��ʼ����');


%NΪ�����ĸ���
K0=kernel(data);
%K0=data*data';
oneN=ones(N,N)/N;
K=K0-oneN*K0-K0*oneN+oneN*K0*oneN;
%K=K0;
%K��Ϊ���ϵ�K����

%��ȡ����ֵ����������
[V,D]=eig(K/N);
V=real(V);
D=real(D);
eigValue=diag(D);
[~,IX]=sort(eigValue,'descend');
%���Ե�һ������
eigVector=V(:,IX);
%��������V����������ɵľ���
eigValue=eigValue(IX);
%������������ֵ

%��׼��
norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

eigVector=eigVector(:,1:2);
%dΪҪѡ��ά��
Y3=K*eigVector;
figure;
hold on;
plot(Y3(1:end,1),Y3(1:end,2),'b*');
drawnow;
