%generate key for receiver
key=keygen('/home/ak/Documents/Final_year_project/csi_extract/data/csi_data_2*2_6.mat');
key_bin_rx=hex2bin(key);

rec1=data(1:256);
%decryption
mac_dec=(xor(rec1,key_bin));
%splitting for mac
mac_rx=mac_dec(1:48);
%hashing received mac
mac_hash_rx=hash(char(mac_rx+'0'));

mac_hash_bin_rx=hex2bin(mac_hash_rx);
%encrypting received hash
mac_hash_enc_rx=(xor(key_bin_rx,mac_hash_bin_rx));
%
%verifying with sender data
if(strcmp(char(mac_hash_enc_rx+'0'),char(data(257:512)+'0')))
    disp('siganture is verified');
end



