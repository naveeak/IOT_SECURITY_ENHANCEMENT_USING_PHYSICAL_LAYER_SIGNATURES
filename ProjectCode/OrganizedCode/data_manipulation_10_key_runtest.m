                                        %clearing data
clear;
close all;
clc;
num_files=1;
for l=1:num_files                                      
% read=load(strcat('/home/ak/Documents/Final_year_project/csi_extract/data/csi_data_2*2_',int2str(l),'.mat'));
% read=read.read;
read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_',int2str(l-1),'.csv'));
base{l} =  read{1, 1}.timestamp;
                                          %csi_matrix[rx antenna][tx antenna][subcarriers]
number_packets_to_consider=210;
data=cell(number_packets_to_consider,1);
h=1;   
% timestamp=zeros(1,number_packets_to_consider);
means_abs=zeros(1,number_packets_to_consider);

for i=1:number_packets_to_consider
 for j=1:h
     data{i,1}=read{i}.csi;    
     csi_matrix=data{i,1}(j,:,1);
     csi_abs=abs(csi_matrix);
     means_abs(h*(i-1)+j)=mean(csi_abs);
 end
end
key_log=quantization_1(means_abs);
key{l}=char(key_log+'0')
% fprintf('%d',key_log);
% fprintf('\n');
key_hash{l}=hash(key{l});
% figure (l);
% subplot(3,3,l)
% plot(means_abs);
% title(['CSI DATASET-',num2str(l)]);
% hold on;


% xlabel('No. of packets');
% ylabel('Magnitude ');
% suptitle('Absolute value of csi matrix');
%disp(key_hash);
end
fprintf('Generated Keys \n'); 
for k=1:num_files
fprintf('Key%d is %s\n',k,key_hash{k});
fprintf(' \n');
end
