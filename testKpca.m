clc
clear
dir = 'data_PCA.txt';
data=pcaRead(dir);
[data,m,sigma]=zscore(data);
N=size(data,1);
disp('��ʼ����');


%NΪ�����ĸ���
X=data;
N = size(X,1); %��������Ϊ���ݸ���
DIST=zeros(N,N);
for i=1:N
    for j=1:N
        diff=X(i,:)-X(j,:);
        DIST(i,j)=diff*diff';
    end
end
DIST(DIST==0)=inf;
%infΪ�����
DIST1=min(DIST);
sigma_kernel=5*mean(DIST1);
K0 = zeros(N);
for i = 1:N
    for j = i:N
        diff_ij = X(i,:)-X(j,:);
        K0(i,j) = exp(-diff_ij*diff_ij'/2/sigma_kernel^2);
        %�õ�һ����
        if i~=j
            K0(j,i) = K0(i,j);
        end
    end
end
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
