
function phase=phase_calculation_fn(filename)
key=keygen(filename);
key_binary=hex2bin(key);
for i=1:length(key_binary)/8
    temp=key_binary((i-1)*8+1:(i)*8);
    %%min_quandrant shift choosing from first 2 bits%%
    quandrant=bin2dec(char(temp(1:2)+'0'));
    base_phase_shift=quandrant*90;
    %%choosing sign for phase 
    sign=((-1)^(temp(3)+1)); 
    %%value of phase from next 5bits
    value=bin2dec(char(temp(4:8)+'0'));
    phase(i)=sign*base_phase_shift+(value*2.8125); 
end