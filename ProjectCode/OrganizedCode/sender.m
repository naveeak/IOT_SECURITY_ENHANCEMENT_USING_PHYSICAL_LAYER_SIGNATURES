
key=keygen('/home/ak/Documents/Final_year_project/csi_extract/data/csi_data_2*2_6.mat');
key_bin=hex2bin(key);
%typical mac id FF:FF:FF:FF:FF:FF (48 bit)
mac=randi([0 1],1,48);


mac_hash=hash(char(mac+'0'));

mac_pad=[mac, zeros(1,length(key_bin)-48)];
mac_hash_bin=hex2bin(mac_hash);
%
%encryption of mac with key
mac_enc=(xor(key_bin,mac_pad));
%
%encryption of hash of mac with key
mac_hash_enc=(xor(key_bin,mac_hash_bin));
%
%data to sender
data=[mac_enc,mac_hash_enc];
fprintf('%d',data);

