function sym_rx=qam_demod(M,phs,qam_rx)                                                                                                                                    % M-ary QAM                                                                       % Modulation
H_Rx = modem.qamdemod('M', M, 'PHASEOFFSET', 0, 'SYMBOLORDER', 'BINARY', ...
                 'OUTPUTTYPE', 'BIT');                                                      % Generate Handle for Modulation
sym_rx = demodulate(H_Rx,qam_rx*exp(-1i*phs));                                                        % Finding out SNR from Eb/No



