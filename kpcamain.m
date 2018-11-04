clc
clear
dir = 'data_PCA.txt';
data=pcaRead(dir);
[data,m,sigma]=zscore(data);
N=size(data,1);
disp('��ʼ����');


%NΪ�����ĸ���
%K0=kernel(data);
X=data;
N = size(X,1); %��������Ϊ���ݸ���
DIST=zeros(N,N);
for i=1:N
    for j=1:N
        diff=X(i,:)-X(j,:);
        DIST(i,j)=sqrt(diff*diff');
    end
end
DIST(DIST==0)=inf;
%infΪ�����
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
%K��Ϊ���ϵ�K����

%��ȡ����ֵ����������
[V,D]=eig(K/N);
%V=real(V);
%D=real(D);
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
Y3=K0*eigVector;
figure;
hold on;
%plot(Y3(1:end,1),Y3(1:end,2),'b*');
plot(Y3(1:128,1),Y3(1:128,2),'ro');
plot(Y3(129:end,1),Y3(129:end,2),'b*');
drawnow;
