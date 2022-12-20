phase=phase_calculation_fn;
Number_of_bit=1024;
data=randi([0 1],1,Number_of_bit);
size_block=2;
modulation=4;%For QPSK
bits_per_symbol=log2(modulation);
Tx_sig=[];
phaseChange=1;%Symbols/phase

for j=1:phaseChange
for i=1:length(data)/bits_per_symbol
    
    
end
end
