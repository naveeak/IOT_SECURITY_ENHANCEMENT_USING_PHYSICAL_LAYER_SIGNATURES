
phase_tx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');

%typical mac id FF:FF:FF:FF:FF:FF (48 bit)
mac=randi([0 1],1,48);


mac_hash=hash(char(mac+'0'));%Hashing the MAC add. 

% mac_pad=[mac, zeros(1,length(key_bin)-48)];
mac_hash_bin=hex2bin(mac_hash);
%
%ENCRYPTION
mac_enc=enc_phase(mac,phase_tx);       %%MAC ADDRESS

mac_hash_enc=(enc_phase(mac_hash_bin,phase_tx));    %%%HASH OF MAC ADDRESS
%
%%data to sender
data=[mac_enc,mac_hash_enc];
fprintf('%d \n',data);

