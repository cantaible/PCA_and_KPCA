function [Y,eigVector,eigValue]=kPCA(X,d,type,para)

if (strcmp(type,'simple')||strcmp(type,'poly')||strcmp(type,'gaussian'))==0
    Y=[];
    eigVector=[];
    fprintf(['\nError:Kernel type type is not supported.\n']);
    return
end

N=size(X,1);
%NΪ�����ĸ���
K0=kernel(X);
oneN=ones(N,N)/N;
K=K0-oneN*K0-K0*oneN+oneN*K0*oneN;
%K��Ϊ���ϵ�K����

%��ȡ����ֵ����������
[V,D]=eig(K/N);
eigValue=diag(D);
[~,IX]=sort(eigValue,'descend');
eigVector=V(:,IX);
eigValue=eigValue(IX);

%��׼��
norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

eigVector=eigVector(:,1:d);
%dΪҪѡ��ά��
Y=K0*eigVector;