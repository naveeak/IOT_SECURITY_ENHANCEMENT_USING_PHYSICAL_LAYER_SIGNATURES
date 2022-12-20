                                         %clearing data
clear;
close all;
clc;

for l=1:1                                         %Reading data from the log file

read=load('/home/ak/Documents/Final_year_project/csi_extract/data/csi_data.mat');
read=read.read;

% read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_',int2str(l-1),'.csv'));
                                          %calculating start time
base{l} =  read{1, 1}.timestamp;
                                          %csi_matrix[rx antenna][tx antenna][subcarriers]
number_packets_to_consider=200;
                                          %variable declaration
data=cell(number_packets_to_consider,1);
h=1;                                      %min(rx_ant);
timestamp=zeros(1,number_packets_to_consider);
means_real=zeros(1,number_packets_to_consider);
means_abs=zeros(1,number_packets_to_consider);
means_angle=zeros(1,number_packets_to_consider);

for i=1:number_packets_to_consider
 for j=1:h
     data{i,1}=read{i}.csi;
                                    %calculating time of packet from reference packet
    
     csi_matrix=data{i,1}(j,:,1);
                                     %this takes the csi of tx
                                    % csi_matrix=data{i,1}(:,j,1);
                                     %manipulating the csi complex data

     csi_abs=abs(csi_matrix);
     csi_real=real(csi_matrix);
     csi_angle=angle(csi_matrix);
     %mean values
     means_real(h*(i-1)+j)=mean(csi_real);
     means_angle(h*(i-1)+j)=mean(csi_angle);
     means_abs(h*(i-1)+j)=mean(csi_abs);
 end
end

figure (2);
plot(means_abs);

title('Absolute value of csi matrix');
xlabel('No of packets');
ylabel('magnitute');
%
%generated key
%
key_log=quantization(means_abs);
key=char(key_log+'0')
% fprintf('%d',key_log);
% fprintf('\n');
%
%Hash sha_256
%
key_hash{l}=hash(key);
%disp(key_hash);
%
%encryption 
%
end
