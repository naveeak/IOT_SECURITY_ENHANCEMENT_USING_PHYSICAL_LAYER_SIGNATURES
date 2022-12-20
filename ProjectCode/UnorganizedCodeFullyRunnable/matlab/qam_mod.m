function qam_tx=qam_mod(M,phs,msg)  
% M-ary
l=length(msg);

bits_sym = log2(M);     % Bits per Symbol for M-ary
m=mod(l,bits_sym);
    if m~= 0
        z_add = zeros(1,bits_sym-m);% appending zeros for coorect reshaping
        msg= [msg z_add];
    else
        msg= msg;
    end
    
sym_tx = reshape(msg,bits_sym,length(msg)/bits_sym);                                                               % Serial to Parallel Conversion for QAM
H_Tx = modem.qammod('M', M, 'PHASEOFFSET', 0, 'SYMBOLORDER', 'BINARY', ...
                                                    'INPUTTYPE', 'BIT');                           % Generate Handle for Modulation
qam_tx = modulate(H_Tx,sym_tx).*exp(1i*phs);     
qam_tx =(qam_tx(:)).';                                                                        % Modulation



