
function ret =keygen(filename)
% read=load(filename);
% read=read.read;
try
read=read_log_file_ec(filename);
catch ME
    if (strcmp(ME.identifier,'MATLAB:UndefinedFunction'))
        
    return ;
    end
end
                          %calculating start time
start_time=  read{1, 1}.timestamp;
fprintf("starting time of the packet Sending %s\n",start_time);
                       %csi_matrix[rx antenna][tx antenna][subcarriers]
[number_packets_to_consider,~]=size(read);
                          %variable declaration
data=cell(number_packets_to_consider,1);
h=1;                      %min(rx_ant);
timestamp=zeros(1,number_packets_to_consider);

means_abs=zeros(1,number_packets_to_consider);


for i=1:number_packets_to_consider
 for j=1:h
     data{i,1}=read{i}.csi;
     %calculating time of packet from reference packet
     timestamp(i)=read{i}.timestamp-start_time;
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

key_log=quantization(means_abs);
key=char(key_log+'0');


key_hash=hash(key);
fprintf("Generated Key is %s\n",key_hash);

ret=key_hash;
end

