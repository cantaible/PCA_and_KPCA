function K=kernel(X)
% Gaussian Kernel
% Input:
% X: ��������ݾ���ÿһ����һ�����ݣ���������������
% sigma_kernel: ������˺����Ĳ���
% Output:
% K: X��kernel���󣬴�СΪN*N

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
K = zeros(N);

tmp = zeros(N,N);
        for i = 1:N
            for j = 1:N
                tmp(i,j) = norm(X(i,:)-X(j,:));
            end
        end   
        K = exp(-0.5*(tmp/sigma_kernel).^2);


%for i = 1:N
    %for j = 1:N
        %diff_ij = X(i,:)-X(j,:);
        %K(i,j) = exp(-diff_ij*diff_ij'/2/sigma_kernel^2);
        %�õ�һ����
        %if i~=j
            %K(j,i) = K(i,j);
        %end
    %end
%end