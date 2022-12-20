function tx_signal=enc_phase(dataIn,phase)
sym_phase=2;
m=16;
M=log2(m);
k=length(dataIn);
for i=1:k/(sym_phase*M)
    temp=dataIn((i-1)*sym_phase*M+1:(i)*sym_phase*M);
    tx_signal{i}= qam_mod(m,phase(mod(i,32)+1),temp);
end
tx_signal=cell2arr(tx_signal);