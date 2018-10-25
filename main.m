clc
clear
dir = 'data_PCA.txt';
data=pcaRead(dir);
%dataOrigin=data;
[dataOrigin,m,sigma]=zscore(data);
%��׼��
%Y1=PCA(dataOrigin,2);
d=2;
Sx=cov(dataOrigin);
[V,D]=eig(Sx);
%v������������D��������ֵ��ɵĶԽǾ���
eigValue=diag(D);
%eigValue�ǴӶԽǾ���
[eigValue,IX]=sort(eigValue,'descend');
%ix�ǰ��մӸߵ��͵�˳�����еõ�������
eigVector=V(:,IX);
%��������ֵ��������������

norm_eigVector=sqrt(sum(eigVector.^2));
eigVectorRepmat=eigVector./repmat(norm_eigVector,size(eigVector,1),1);
%������A����m*n�飬����A��ΪB��Ԫ�أ�B �� m*n ��Aƽ�̶��ɡ�
%B ��ά���� [size(A,1)*m,size(A,2)*n]
eigVectorRepmatd=eigVectorRepmat(:,1:d);
%dΪҪѡ��ά��
Y1=dataOrigin*eigVectorRepmatd;


figure;
hold on;
%plot(dataOrigin(1:end,1),dataOrigin(1:end,2),'ro');
%plot(Y1(1:end,1),Y1(1:end,2),'b*');
plot(Y1(1:128,1),Y1(1:128,2),'ro');
plot(Y1(129:end,1),Y1(129:end,2),'b*');