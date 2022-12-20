
function data=dec_phase(tx_signal,phase)
sym_phase=2;
m=16;
M=log2(m);
k=M*length(tx_signal);
decoded_data=[];
for i=1:k/(sym_phase*M)
    temp=qam_demod(m,phase(mod(i,32)+1),tx_signal((i-1)*sym_phase+1:(i)*sym_phase));
   temp=mat2array(temp);
   decoded_data=[decoded_data temp];
end
data=decoded_data;