close all;
clear ;
%%reading data from the test.mat log data obatined from the internet 
csi_data_load=load('test.mat');
csi_data=csi_data_load.test_data;
for i=1:4
csi_data_1=csi_data(:,i)';
 plot(csi_data_1);
 hold on;
end
% csi_data_array= reshape(csi_data_1',1,[]);
y = uencode(csi_data_1,32);


