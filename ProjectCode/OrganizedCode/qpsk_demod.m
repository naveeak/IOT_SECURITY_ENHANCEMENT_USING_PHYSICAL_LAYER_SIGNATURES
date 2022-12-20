function ret=qpsk_demod(Tx_sig,phs)
br=10.^6; %Let us transmission bit rate  1000000
f=br; % minimum carrier frequency
T=1/br; % bit duration
t=T/99:T/99:T; % Time vector for one bit information
Rx_sig=Tx_sig; % Received signal
Rx_data=[];
for i=1:1:length(Tx_sig)/(99)
    %%XXXXXX inphase coherent dector XXXXXXX
    Z_in=Rx_sig((i-1)*length(t)+1:i*length(t)).*cos((2*pi*f*t)+phs); 
    % above line indicat multiplication of received & inphase carred signal
    Z_in_intg=(trapz(t,Z_in))*(2/T);% integration using trapizodial rull
    if(Z_in_intg>0) % Decession Maker
        Rx_in_data=1;
    else
       Rx_in_data=0; 
    end
    
    %%XXXXXX Quadrature coherent dector XXXXXX
    Z_qd=Rx_sig((i-1)*length(t)+1:i*length(t)).*sin((2*pi*f*t)+phs);
    %above line indicat multiplication ofreceived & Quadphase carred signal
    Z_qd_intg=(trapz(t,Z_qd))*(2/T);%integration using trapizodial rull
        if (Z_qd_intg>0)% Decession Maker
        Rx_qd_data=1;
        else
       Rx_qd_data=0; 
        end
        
        
        Rx_data=[Rx_data  Rx_in_data  Rx_qd_data]; % Received Data vector
end
ret=Rx_data;
