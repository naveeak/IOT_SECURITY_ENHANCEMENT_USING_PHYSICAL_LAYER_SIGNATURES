clc;
clear all;
close all;
bits = 384;
msg  = round(rand(1,bits));                                                             % Generating Random Bit Stream
M = [4 16 64 256];                                                                                 % M-ary
for j=1:1

bits_sym = log2(M(j));                                                                             % Bits per Symbol for M-ary
sym_tx = reshape(msg,bits_sym,length(msg)/bits_sym);                                                               % Serial to Parallel Conversion for QAM
H_Tx = modem.qammod('M', M(j), 'PHASEOFFSET', 100, 'SYMBOLORDER', 'BINARY', ...
                                                    'INPUTTYPE', 'BIT');                           % Generate Handle for Modulation
qam_tx = modulate(H_Tx,sym_tx);     
qam_rx =(qam_tx(:)).';% Modulation
H_Rx = modem.qamdemod('M', M(j), 'PHASEOFFSET', 0, 'SYMBOLORDER', 'BINARY', ...
                 'OUTPUTTYPE', 'BIT');                                                 % Generate Handle for Modulation
sym_rx = demodulate(H_Rx,qam_rx);                                    % Finding out SNR from Eb/No

end

