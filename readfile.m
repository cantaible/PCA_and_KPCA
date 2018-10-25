clc
clear
filename = 'data_PCA.txt';
[data1,data2]=textread(filename,'%n%n','delimiter', ',');
dataOrigion=[data1,data2];