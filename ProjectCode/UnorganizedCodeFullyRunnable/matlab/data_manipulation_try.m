                                         %clearing data
clear;
close all;
clc;
                                         %Reading data from the log file

read=load('/home/ak/Documents/Final_year_project/csi_extract/data/csi_data_2*2.mat');
read=read.read;
                                          %calculating start time
base =  read{1, 1}.timestamp;
data=cell(10,1);
                                          %csi_matrix[rx antenna][tx antenna][subcarriers]
for i=1:100
    data{i,1}=read{i}.csi;
    rssi(i)=read{i}.rssi;
end
values=[];
y=[];
for k=1:10:10
for i=1:100
for j=1:k
   svd_tmp=svd(data{i,1}(:,:,j));
%    svd_tmp=(mean(svd_tmp));
   values=[values svd_tmp(1) svd_tmp(2)]
end
   y=[y values];
   values=[];

end
plot(y);
hold on;


end



