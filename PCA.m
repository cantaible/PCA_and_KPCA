function [Y,eigVector,eigValue]=PCA(X,d)

Sx=cov(X);
[v,D]=eig(Sx);
eigValue=diag(D);
[eigValue,IX]=sort(eigValue,'descend');
eigVector=v(:,IX);

norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

eigVector=eigVector(:,1:d);
%d为要选的维数
Y=X*eigVector;
end
