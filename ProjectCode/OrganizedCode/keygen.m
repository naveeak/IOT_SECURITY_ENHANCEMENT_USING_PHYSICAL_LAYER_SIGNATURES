
function ret =keygen(filename)
% read=load(filename);
% read=read.read;
read=read_log_file(filename);
%calculating start time
base =  read{1, 1}.timestamp;
%csi_matrix[rx antenna][tx antenna][subcarriers]
number_packets_to_consider=220;
%variable declaration
data=cell(number_packets_to_consider,1);
h=1;%min(rx_ant);
timestamp=zeros(1,number_packets_to_consider);

means_abs=zeros(1,number_packets_to_consider);


for i=1:number_packets_to_consider
 for j=1:h
     data{i,1}=read{i}.csi;
     %calculating time of packet from reference packet
     timestamp(i)=read{i}.timestamp-base;
     %this takes the csi of rx
     csi_matrix=data{i,1}(j,:,1);
     %this takes the csi of tx
    % csi_matrix=data{i,1}(:,j,1);
     %manipulating the csi complex data

     csi_abs=abs(csi_matrix);
     %mean values
     means_abs(h*(i-1)+j)=mean(csi_abs);
 end
end

% figure (2);
% plot(means_abs);
% title('Absolute value of csi matrix');
% xlabel('No of packets');
% ylabel('magnitute');
%
%generated key
%
key_log=quantization_1(means_abs);
key=char(key_log+'0')

%Hash sha_256
%
key_hash=hash(key)

ret=key_hash;

