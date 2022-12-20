                                              %clearing data

for l=1:9                                     %Reading data from the log file
% 
% read=load('/home/ak/Documents/Final_year_project/csi_extract/data/csi_data_2*2.mat');
% read=read.read;
% read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_ping_pair/ping_ak',int2str(l),'_pair.csv'));
%  read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_ping/ping_ak',int2str(l),'.csv'));
% "/home/ak/Documents/Final_year_project//.csv"
read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_',int2str(l-1),'.csv'));
                                          %calculating start time
base{l} =  read{1, 1}.timestamp;
                                          %csi_matrix[rx antenna][tx antenna][subcarriers]
number_packets_to_consider=200;
                                          %variable declaration
data=cell(number_packets_to_consider,1);
h=1;                                      %min(rx_ant);
timestamp=zeros(1,number_packets_to_consider);
means_abs=zeros(1,number_packets_to_consider);

for i=1:number_packets_to_consider
 for j=1:h
     data{i,1}=read{i}.csi;
                                    %calculating time of packet from reference packet
    
     csi_matrix=data{i,1}(j,:,1);
                                     %this takes the csi of tx
                                    % csi_matrix=data{i,1}(:,j,1);
                                     %manipulating the csi complex data

     csi_abs=abs(csi_matrix);
     %mean values
     means_abs(h*(i-1)+j)=mean(csi_abs);
 end
end



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
key_log1{l}=hex2bin(key_hash{l});
% figure (l);

subplot(3,3,l)
plot(means_abs);
title(['CSI DATASET-',num2str(l)]);
hold on;


% xlabel('No. of packets');
% ylabel('Magnitude ');
% suptitle('Absolute value of csi matrix');
%disp(key_hash);
%
%encryption 
%
end
% disp(key_hash);
fprintf('Generated Keys \n'); 
for k=2:9
 err(k-1)=biterr(key_log1{1},key_log1{k})/number_packets_to_consider;
 
end
figure;
bar(err);
xlabel('Distance from original user(cm)');
ylabel('percentage of Error with the original user ');
title("Leakage of key near user");
xticks = get(gca,'xtick') 
scaling  = 15 
newlabels = arrayfun(@(x) sprintf('%.1f', scaling * x), xticks, 'un', 0)
set(gca,'xticklabel',newlabels)
