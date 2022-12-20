%generate key for receiver
phase_Rx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_3.csv');
m=16;
M=log2(m);
mac_rx=dec_phase(data(1:48/M),phase_Rx);
fprintf("MAC ADDRESS IS %s\n",bin2hex(char(mac_rx+'0')));

%%VERIFYING SIGNATURE
mac_hash_rx=hash(char(mac_rx+'0'));


mac_hash_bin_rx=hex2bin(mac_hash_rx);
%encrypting received hash
mac_hash_enc=(enc_phase(mac_hash_bin,phase_Rx));
%
%verifying with sender data
if(isequal(mac_hash_enc,data(48/M+1:length(data))))
    disp('Siganture is verified');
else
    disp('Signature is not verified');
end



