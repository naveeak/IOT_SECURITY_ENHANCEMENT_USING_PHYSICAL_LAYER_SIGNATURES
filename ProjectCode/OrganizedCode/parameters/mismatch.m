%   keyn="/home/ak/Documents/Final_year_project/ashok_ping/ping_ak3.csv"
keyn="/home/ak/Documents/Final_year_project/ashok_ping_pair/ping_ak3_pair.csv"
read=read_log_file(keyn);
% read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_single_room_',int2str(l-1),'.csv'));
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
    
     csi_matrix=data{i,1}(j,:,2);
                                     %this takes the csi of tx
                                    % csi_matrix=data{i,1}(:,j,1);
                                     %manipulating the csi complex data

     csi_abs=abs(csi_matrix);
     %mean values
     means_abs(h*(i-1)+j)=mean(csi_abs);
   

 end

end
 figure (1);

% subplot(3,3,l)
plot(means_abs);
title(['CSI DATASET-',num2str(l)]);
hold on;

key_log=quantization(means_abs);
key=char(key_log+'0')

key_hash{l}=hash(key);

