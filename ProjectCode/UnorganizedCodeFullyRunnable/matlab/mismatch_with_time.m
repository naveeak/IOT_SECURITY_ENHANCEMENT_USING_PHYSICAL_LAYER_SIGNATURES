                                         %clearing data

for l=1:8                                   %Reading data from the log file

 read=read_log_file_ec(strcat('/home/ak/Documents/Final_year_project/ak/mismatch',int2str(l)));
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

key_log=quantization(means_abs);


key=char(key_log+'0');
key1{l}=key;

key_hash{l}=hash(key);
key_log1{l}=hex2bin(key_hash{l});


subplot(3,3,l)
plot(means_abs);
title(['CSI DATASET-',num2str(l)]);
hold on;

end
for k=2:8
 err(k-1)=biterr(key1{1},key1{k})/number_packets_to_consider;

end
figure;
bar(err);
xlabel('Keys at different time(greate than coherent time)');
ylabel('percentage of Error with the original user ');
title("CSI variation with time");
