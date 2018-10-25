function dataOrigin=pcaRead(dir)
%filename = 'data_PCA.txt';
[data1,data2]=textread(dir,'%n%n','delimiter', ',');
dataOrigin=[data1,data2];