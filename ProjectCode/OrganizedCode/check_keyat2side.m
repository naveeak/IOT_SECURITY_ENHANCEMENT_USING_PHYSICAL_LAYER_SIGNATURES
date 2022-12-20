                                         

for l=2:2                                   
 read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_ping_pair/ping_ak',int2str(l),'_pair.csv'));
 %read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_ping/ping_ak',int2str(l),'.csv'));
%read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ak/mismatch',int2str(l)));
% read=read_log_file(strcat('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_single_room_',int2str(l-1),'.csv'));          
%base{l} =  read{1, 1}.timestamp ;                                                                                                                                                                                                                                                                                                                               antenna][subcarriers]
number_packets_to_consider=200;
data=cell(number_packets_to_consider,1);
h=1;
timestamp=zeros(1,number_packets_to_consider);
means_abs=zeros(1,number_packets_to_consider);

for i=1:number_packets_to_consider
    timestamp(i)=read{i}.timestamp;
 for j=1:h
     data{i,1}=read{i}.csi;
     temp{i}=read{i,1}.timestamp; 
     csi_matrix=data{i,1}(j,:,1);
     csi_abs=abs(csi_matrix);
     means_abs(h*(i-1)+j)=mean(csi_abs);
 end
    
end
time{l}=temp{i};

key_log=quantization(means_abs);
key=char(key_log+'0')
key_hash{l}=hash(key);
key_log2{l}=hex2bin(key_hash{l});
plot(means_abs);
hold on;
end


