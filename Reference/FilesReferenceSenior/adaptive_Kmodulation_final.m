% SER VS SNR FOR PROPOSED METHOD FOR DIFFERENT VALUES OF MODULATION SCHEMES ie. K=2,3,4,5,6
clc;
clear all;
close all;
N=1000;                        % Initialization, No. of random message symbols per phase
phi=10;                        % Initialization, No. of random phase values per SNR
c=1;                            % BER array index
mk=0;                           % Modulation type k for proposed method eg. 2,4,8,16,32
nk=0;                           % Modulation type k eg. 2,4,8,16,32 for paper method
initial=-10;                      % SNR Min
inc=5;                          % SNR increment
final=50;                       % SNR Max
P = randi([0,360],phi,1);   % To generate 'phi' no. of random phases
% for K=6  
c=1;
b=0;
del=5;
for snrdb=initial:inc:final                   
            errors=0;                   % errors for proposed method
            errors1=0;                  % errors for paper method
            snr=10^(snrdb/10);
            for k=1:length(P)
                t(k)=pi/P(k);
                if(snrdb<7)
                    mk=2;
                end
                 if (7<=snrdb && snrdb<13)                 % QPSK & BPSK
                      if((0<=P(k)||(360==P(k)))&& P(k)<=180)
                      mk=2;
                      elseif(180<P(k)&& P(k)<360)
                      mk=4;
                      end
                end  
                if (13<=snrdb && snrdb<17)                % 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<120)
                      mk=2;
                  elseif(120<=P(k)&& P(k)<240)
                      mk=4;
                  elseif(240<=P(k)&& P(k)<360)
                      mk=8;
                  end
                end 
                if (17<=snrdb && snrdb<22)                % 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<90)
                      mk=2;
                  elseif(90<=P(k)&& P(k)<180)
                      mk=4;
                  elseif(180<=P(k)&& P(k)<270)
                      mk=8;
                  elseif(270<=P(k)&& P(k)<360)
                      mk=16;
                  end
                end  
                if (22<=snrdb && snrdb<27)              % 32 PSK, 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<72)
                      mk=2;
                  elseif(72<=P(k)&& P(k)<144)
                      mk=4;
                  elseif(144<=P(k)&& P(k)<216)
                      mk=8;
                  elseif(216<=P(k)&& P(k)<288)
                      mk=16;
                  elseif(288<=P(k)&& P(k)<360)
                      mk=32;
                  end
                end  
                if (27<=snrdb)                            % 64 PSK, 32 PSK, 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<60)
                      mk=2;
                  elseif(60<=P(k)&& P(k)<120)
                      mk=4;
                  elseif(120<=P(k)&& P(k)<180)
                      mk=8;
                  elseif(180<=P(k)&& P(k)<240)
                      mk=16;
                  elseif(240<=P(k)&& P(k)<300)
                      mk=32;
                  elseif(300<=P(k)&& P(k)<360)
                      mk=64;
                  end
                end  
                X= randi([0,mk-1],N,1);              % channel convolution and AWGN
                M_sig=(pskmod(X,mk,pi/mk)).*exp(-1i*(t(k)));    % PSK modulation
                h = 1/sqrt(2)*(randn(length(M_sig),1) + 1i*randn(length(M_sig),1)); 
                N0 = 1/snr;
                rx1 = h.*M_sig;
                Noise=sqrt(N0/2)*((randn(length(M_sig),1))+1i*randn(length(M_sig),1));
                rx=rx1 +Noise;
                rx = rx./h;
                %receiver
                the1= P(k)+del;
                the2= P(k)-del;
                P_1=randi([the2,the1],1);
                t_1=pi/P_1;
                if(snrdb<7)
                    mk1=2;
                end
                 if (7<=snrdb && snrdb<13)                 % QPSK & BPSK
                      if((0<=P_1||(360==P_1))&& P_1<=180)
                      mk1=2;
                      elseif(180<P_1&& P_1<360)
                      mk1=4;
                      end
                end  
                if (13<=snrdb && snrdb<17)                % 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<120)
                      mk1=2;
                  elseif(120<=P_1&& P_1<240)
                      mk1=4;
                  elseif(240<=P_1&& P_1<360)
                      mk1=8;
                  end
                end 
                if (17<=snrdb && snrdb<22)                % 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<90)
                      mk1=2;
                  elseif(90<=P_1&& P_1<180)
                      mk1=4;
                  elseif(180<=P_1&& P_1<270)
                      mk1=8;
                  elseif(270<=P_1&& P_1<360)
                      mk1=16;
                  end
                end  
                if (22<=snrdb && snrdb<27)              % 32 PSK, 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<72)
                      mk1=2;
                  elseif(72<=P_1&& P_1<144)
                      mk1=4;
                  elseif(144<=P_1&& P_1<216)
                      mk1=8;
                  elseif(216<=P_1&& P_1<288)
                      mk1=16;
                  elseif(288<=P_1&& P_1<360)
                      mk1=32;
                  end
                end  
                if (27<=snrdb)                            % 64 PSK, 32 PSK, 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<60)
                      mk1=2;
                  elseif(60<=P_1&& P_1<120)
                      mk1=4;
                  elseif(120<=P_1&& P_1<180)
                      mk1=8;
                  elseif(180<=P_1&& P_1<240)
                      mk1=16;
                  elseif(240<=P_1&& P_1<300)
                      mk1=32;
                  elseif(300<=P_1&& P_1<360)
                      mk1=64;
                  end
                end  
                dephase_change=rx*exp(1i*(t_1));   
                dm_sig=pskdemod(dephase_change,mk,pi/mk);           % Demodulation
                x=length(find(dm_sig~=X));
                errors= errors + x;
                
                if((0<=P(k)||(360==P(k)))&& P(k)<=60)       % Paper method
                      nk=2;
                elseif(60<P(k)&& P(k)<=120)
                      nk=4;
                elseif(120<P(k)&& P(k)<=180)
                      nk=8;
                elseif(180<P(k)&& P(k)<=240)
                      nk=16;
                elseif(240<P(k)&& P(k)<=300)
                      nk=32;
                elseif(300<P(k)&& P(k)<360)
                      nk=64;
                end

                X1= randi([0,nk-1],N,1);  
                M_sig1=(pskmod(X1,nk,pi/nk)).*exp(-1i*(t(k)));
                h1 = 1/sqrt(2)*(randn(length(M_sig1),1) + 1i*randn(length(M_sig1),1)); 
                N0 = 1/snr;
                rx11 = h1.*M_sig1;
                Noise1=sqrt(N0/2)*((randn(length(M_sig1),1))+1i*randn(length(M_sig1),1));
                rx2=rx11 +Noise1;
                rx2 = rx2./h1;
                %receiver 
                 if((0<=P_1||(360==P_1))&& P_1<=60)       % Paper method
                      nk1=2;
                elseif(60<P_1&& P_1<=120)
                      nk1=4;
                elseif(120<P_1&& P_1<=180)
                      nk1=8;
                elseif(180<P_1&& P_1<=240)
                      nk1=16;
                elseif(240<P_1&& P_1<=300)
                      nk1=32;
                elseif(300<P_1&& P_1<360)
                      nk1=64;
                end
                dephase_change1=rx2*exp(1i*(t_1));
                dm_sig1=pskdemod(dephase_change1,nk,pi/nk); 
                x1=length(find(X1~=dm_sig1));
                errors1= errors1 + x1;    % accumulating errors for every random phi value with N no. of symbols
            end
            BERk6(c)=errors/(phi*N);      % calculating average BER (proposed method)for one SNR (with index value c)for total no. of phi*N bits
            if BERk6(c)==0
                BERk6(c)=10^-7;          % if BER is 0, assign a non-zero value
            end
            BERBk6(c)=errors1/(phi*N);    % calculating average BER for paper method
            if BERBk6(c)==0
                BERBk6(c)=10^-7;         % if BER is 0, assign a non-zero value
            end
           c=c+1;
end
%for K=5
c=1;
b=0;
del=5;
for snrdb=initial:inc:final                   
            errors=0;                   % errors for proposed method
            errors1=0;                  % errors for paper method
            snr=10^(snrdb/10);
            for k=1:length(P)
                t(k)=pi/P(k);
                if(snrdb<5)
                    mk=2;
                end
                if (5<=snrdb && snrdb<10)                 % QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<=72)
                      mk=2;
                  elseif(72<P(k)&& P(k)<360)
                      mk=4;
                  end
                end  
                if (10<=snrdb && snrdb<14)                % 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<72)
                      mk=2;
                  elseif(72<=P(k)&& P(k)<144)
                      mk=4;
                 elseif(144<=P(k) && P(k)<360)
                    mk=8;
                  end 
                end
                if (14<=snrdb && snrdb<19)                % 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<72)
                      mk=2;
                  elseif(72<=P(k)&& P(k)<144)
                      mk=4;
                  elseif(144<=P(k)&& P(k)<216)
                      mk=8;
                  elseif(216<=P(k) && P(k)<360)
                      mk=16;
                  end
                end  
                if (19<=snrdb)              % 32 PSK, 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<72)
                      mk=2;
                  elseif(72<=P(k)&& P(k)<144)
                      mk=4;
                  elseif(144<=P(k)&& P(k)<216)
                      mk=8;
                  elseif(216<=P(k)&& P(k)<288)
                      mk=16;
                  elseif(288<=P(k) && P(k)<360)
                      mk=32;
                  end
                end  
               
                X= randi([0,mk-1],N,1);              % channel convolution and AWGN
                M_sig=(pskmod(X,mk,pi/mk)).*exp(-1i*(t(k)));    % PSK modulation
                h = 1/sqrt(2)*(randn(length(M_sig),1) + 1i*randn(length(M_sig),1)); 
                N0 = 1/snr;
                rx1 = h.*M_sig;
                Noise=sqrt(N0/2)*((randn(length(M_sig),1))+1i*randn(length(M_sig),1));
                rx=rx1 +Noise;
                rx = rx./h;
                %receiver
                the1= P(k)+del;
                the2= P(k)-del;
                P_1=randi([the2,the1],1);
                t_1=pi/P_1;
                if(snrdb<5)
                    mk1=2;
                end
                if (5<=snrdb && snrdb<10)                 % QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<=72)
                      mk1=2;
                  elseif(72<P_1&& P_1<360)
                      mk1=4;
                  end
                end  
                if (10<=snrdb && snrdb<14)                % 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<72)
                      mk1=2;
                  elseif(72<=P_1&& P_1<144)
                      mk1=4;
                 elseif(144<=P_1 && P_1<360)
                    mk1=8;
                  end 
                end
                if (14<=snrdb && snrdb<19)                % 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<72)
                      mk1=2;
                  elseif(72<=P_1&& P_1<144)
                      mk1=4;
                  elseif(144<=P_1&& P_1<216)
                      mk1=8;
                  elseif(216<=P_1 && P_1<360)
                      mk1=16;
                  end
                end  
                if (19<=snrdb)              % 32 PSK, 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<72)
                      mk1=2;
                  elseif(72<=P_1&& P_1<144)
                      mk1=4;
                  elseif(144<=P_1&& P_1<216)
                      mk1=8;
                  elseif(216<=P_1&& P_1<288)
                      mk1=16;
                  elseif(288<=P_1 && P_1<360)
                      mk1=32;
                  end
                end
                dephase_change=rx*exp(1i*(t(k)));   
                dm_sig=pskdemod(dephase_change,mk,pi/mk);           % Demodulation
                x=length(find(X~=dm_sig));
                errors= errors + x;

                if((0<=P(k)||(360==P(k)))&& P(k)<=72)       % Paper method
                      nk=2;
                elseif(72<P(k)&& P(k)<=144)
                      nk=4;
                elseif(144<P(k)&& P(k)<=216)
                      nk=8;
                elseif(216<P(k)&& P(k)<=288)
                      nk=16;
                elseif(288<P(k)&& P(k)<=360)
                      nk=32;
                end
                X1= randi([0,nk-1],N,1); 
               M_sig1=(pskmod(X1,nk,pi/nk)).*exp(-1i*(t(k)));
                h1 = 1/sqrt(2)*(randn(length(M_sig1),1) + 1i*randn(length(M_sig1),1)); 
                N0 = 1/snr;
                rx11 = h1.*M_sig1;
                Noise1=sqrt(N0/2)*((randn(length(M_sig1),1))+1i*randn(length(M_sig1),1));
                rx2=rx11 +Noise1;
                rx2 = rx2./h1;
                %receiver
                
                if((0<=P_1||(360==P_1))&& P_1<=72)       % Paper method
                      nk1=2;
                elseif(72<P_1&& P_1<=144)
                      nk1=4;
                elseif(144<P_1&& P_1<=216)
                      nk1=8;
                elseif(216<P_1&& P_1<=288)
                      nk1=16;
                elseif(288<P_1&& P_1<=360)
                      nk1=32;
                end
                dephase_change1=rx2*exp(1i*(t(k)));
                dm_sig1=pskdemod(dephase_change1,nk,pi/nk); 
                
                x1=length(find(X1~=dm_sig1));
                errors1= errors1 + x1;              % accumulating errors for every random phi value with N no. of symbols
           end
           BERk5(c)=errors/(phi*N);      % calculating average BER (proposed method)for one SNR (with index value c)for total no. of phi*N bits
           if BERk5(c)==0
                BERk5(c)=10^-7;          % if BER is 0, assign a non-zero value
           end
           BERBk5(c)=errors1/(phi*N);    % calculating average BER for paper method
           if BERBk5(c)==0
                BERBk5(c)=10^-7;         % if BER is 0, assign a non-zero value
           end
           c=c+1;
end        
% for  K=4
c=1; 
        for snrdb=initial:inc:final                   
            errors=0;
            errors1=0;
            snr=10^(snrdb/10);
            for k=1:length(P)
                t(k)=pi/P(k);
                if(snrdb<7)
                    mk=2;
                end
                if (7<=snrdb && snrdb<13)                 % QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<=90)
                      mk=2;
                  elseif(90<P(k)&& P(k)<360)
                      mk=4;
                  end
                end  
                if (13<=snrdb && snrdb<17)                % 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<=90)
                      mk=2;
                  elseif(90<P(k)&& P(k)<=180)
                      mk=4;
                  elseif(180<P(k)&& P(k)<360)
                      mk=8;
                  end
                end 
                if (17<=snrdb)                % 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<=90)
                      mk=2;
                  elseif(90<P(k)&& P(k)<=180)
                      mk=4;
                  elseif(180<P(k)&& P(k)<=270)
                      mk=8;
                  elseif(270<P(k)&& P(k)<360)
                      mk=16;
                  end
                end  
                
                X= randi([0,mk-1],N,1);              % channel convolution and AWGN
                M_sig=(pskmod(X,mk,pi/mk)).*exp(-1i*(t(k)));
                h = 1/sqrt(2)*(randn(length(M_sig),1) + 1i*randn(length(M_sig),1)); 
                N0 = 1/snr;
                rx1 = h.*M_sig;
                Noise=sqrt(N0/2)*((randn(length(M_sig),1))+1i*randn(length(M_sig),1));
                rx=rx1 +Noise;
                rx = rx./h;
                %receiver
                the1= P(k)+del;
                the2= P(k)-del;
                P_1=randi([the2,the1],1);
                t_1=pi/P_1;
                if(snrdb<5)
                    mk=2;
                end
                if (5<=snrdb && snrdb<10)                 % QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<=90)
                      mk1=2;
                  elseif(90<P_1&& P_1<360)
                      mk1=4;
                  end
                end  
                if (10<=snrdb && snrdb<14)                % 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<=90)
                      mk1=2;
                  elseif(90<P_1&& P_1<=180)
                      mk1=4;
                  elseif(180<P_1&& P_1<360)
                      mk1=8;
                  end
                end 
                if (14<=snrdb)                % 16 PSK, 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<=90)
                      mk1=2;
                  elseif(90<P_1&& P_1<=180)
                      mk1=4;
                  elseif(180<P_1&& P_1<=270)
                      mk1=8;
                  elseif(270<P_1&& P_1<360)
                      mk1=16;
                  end
                end 
                dephase_change=rx*exp(1i*(t_1));
                dm_sig=pskdemod(dephase_change,mk,pi/mk);
                x=length(find(dm_sig~=X));
                errors= errors + x;
                
                if((0<=P(k)||(360==P(k)))&& P(k)<=90)       % Paper method
                      nk=2;
                elseif(90<P(k)&& P(k)<=180)
                      nk=4;
                elseif(180<P(k)&& P(k)<=270)
                      nk=8;
                elseif(270<P(k)&& P(k)<360)
                      nk=16;                            
                end
                % channel convolution and AWGN for paper method
                X1= randi([0,nk-1],N,1); 
                M_sig1=(pskmod(X1,nk,pi/nk)).*exp(-1i*(t(k)));
                h1 = 1/sqrt(2)*(randn(length(M_sig1),1) + 1i*randn(length(M_sig1),1)); 
                N0 = 1/snr;
                rx11 = h1.*M_sig1;
                Noise1=sqrt(N0/2)*((randn(length(M_sig1),1))+1i*randn(length(M_sig1),1));
                rx2=rx11 +Noise1;
                rx2 = rx2./h1;
                if((0<=P_1||(360==P_1))&& P_1<=90)       % Paper method
                      nk1=2;
                elseif(90<P_1&& P_1<=180)
                      nk1=4;
                elseif(180<P_1&& P_1<=270)
                      nk1=8;
                elseif(270<P_1&& P_1<360)
                      nk1=16;                            
                end
                dephase_change1=rx2*exp(1i*(t_1));
                dm_sig1=pskdemod(dephase_change1,nk,pi/nk); 
                x1=length(find(dm_sig1~=X1));
                errors1= errors1 + x1;
                
           end
           BERk4(c)=errors/(phi*N);       % BER for proposed method
           if BERk4(c)==0
                BERk4(c)=10^-7;
           end
           BERBk4(c)=errors1/(phi*N);     % BER for paper method
           if BERBk4(c)==0
                BERBk4(c)=10^-7;
           end
           c=c+1;
        end
        
%for K=3
c=1;
for snrdb=initial:inc:final                   
            errors=0;                   % errors for proposed method
            errors1=0;                  % errors for paper method
            snr=10^(snrdb/10);
            for k=1:length(P)
                t(k)=pi/P(k);
                if(snrdb<5)
                    mk=2;
                end
                if (5<=snrdb && snrdb<10)                 % QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<=120)
                      mk=2;
                  elseif(120<P(k)&& P(k)<360)
                      mk=4;
                  end
                end  
                if (10<=snrdb)                % 8 PSK, QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<120)
                      mk=2;
                  elseif(120<=P(k)&& P(k)<240)
                      mk=4;
                 elseif(240<=P(k) && P(k)<360)
                    mk=8;
                  end 
                end
                X= randi([0,mk-1],N,1);              % channel convolution and AWGN
                M_sig=(pskmod(X,mk,pi/mk)).*exp(-1i*(t(k)));    % PSK modulation
                h = 1/sqrt(2)*(randn(length(M_sig),1) + 1i*randn(length(M_sig),1)); 
                N0 = 1/snr;
                rx1 = h.*M_sig;
                Noise=sqrt(N0/2)*((randn(length(M_sig),1))+1i*randn(length(M_sig),1));
                rx=rx1 +Noise;
                rx = rx./h;
                %receiver
                the1= P(k)+del;
                the2= P(k)-del;
                P_1=randi([the2,the1],1);
                t_1=pi/P_1;
                if (0<=snrdb && snrdb<10)                 % QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<=120)
                      mk1=2;
                  elseif(120<P_1&& P_1<360)
                      mk1=4;
                  end
                end  
                if (10<=snrdb)                % 8 PSK, QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<120)
                      mk1=2;
                  elseif(120<=P_1&& P_1<240)
                      mk1=4;
                 elseif(240<=P_1 && P_1<360)
                    mk1=8;
                  end 
                end
                dephase_change=rx*exp(1i*(t(k)));   
                dm_sig=pskdemod(dephase_change,mk,pi/mk);           % Demodulatio
                x=length(find(X~=dm_sig));
                errors= errors + x;

                if((0<=P(k)||(360==P(k)))&& P(k)<=120)       % Paper method
                      nk=2;
                elseif(120<P(k)&& P(k)<=240)
                      nk=4;
                elseif(240<P(k)&& P(k)<=360)
                      nk=8;
                end
                X1= randi([0,nk-1],N,1); 
                M_sig1=(pskmod(X1,nk,pi/nk)).*exp(-1i*(t(k)));
                h1 = 1/sqrt(2)*(randn(length(M_sig1),1) + 1i*randn(length(M_sig1),1)); 
                N0 = 1/snr;
                rx11 = h1.*M_sig1;
                Noise1=sqrt(N0/2)*((randn(length(M_sig1),1))+1i*randn(length(M_sig1),1));
                rx2=rx11 +Noise1;
                rx2 = rx2./h1;
                %receiver
                if((0<=P_1||(360==P_1))&& P_1<=120)       % Paper method
                      nk1=2;
                elseif(120<P_1&& P_1<=240)
                      nk1=4;
                elseif(240<P_1&& P_1<=360)
                      nk1=8;
                end
                dephase_change1=rx2*exp(1i*(t(k)));
                dm_sig1=pskdemod(dephase_change1,nk,pi/nk); 
                x1=length(find(X1~=dm_sig1));
                errors1= errors1 + x1;              % accumulating errors for every random phi value with N no. of symbols
           end
           BERk3(c)=errors/(phi*N);      % calculating average BER (proposed method)for one SNR (with index value c)for total no. of phi*N bits
           if BERk3(c)==0
                BERk3(c)=10^-7;          % if BER is 0, assign a non-zero value
           end
           BERBk3(c)=errors1/(phi*N);    % calculating average BER for paper method
           if BERBk3(c)==0
                BERBk3(c)=10^-7;         % if BER is 0, assign a non-zero value
           end
           c=c+1;
        end        
        
 % For K=2
c=1; 
        for snrdb=initial:inc:final                   
            errors=0;
            errors1=0;
            snr=10^(snrdb/10);
            for k=1:length(P)
                t(k)=pi/P(k);
                if (snrdb<7)                                % only BPSK
                  mk=2;             
                end
                if (7<=snrdb)                              % QPSK & BPSK
                  if((0<=P(k)||(360==P(k)))&& P(k)<=180)
                      mk=2;
                  elseif(180<P(k)&& P(k)<360)
                      mk=4;
                  end
                end  
                
                X= randi([0,mk-1],N,1);              % channel convolution and AWGN
                M_sig=(pskmod(X,mk,pi/mk)).*exp(-1i*(t(k)));
                h = 1/sqrt(2)*(randn(length(M_sig),1) + 1i*randn(length(M_sig),1)); 
                N0 = 1/snr;
                rx1 = h.*M_sig;
                Noise=sqrt(N0/2)*((randn(length(M_sig),1))+1i*randn(length(M_sig),1));
                rx=rx1 +Noise;
                rx = rx./h;
                %receiver
                the1= P(k)+del;
                the2= P(k)-del;
                P_1=randi([the2,the1],1);
                t_1=pi/P_1;
                if (snrdb<7)                                % only BPSK
                  mk1=2;             
                end
                if (7<=snrdb)                              % QPSK & BPSK
                  if((0<=P_1||(360==P_1))&& P_1<=180)
                      mk1=2;
                  elseif(180<P_1&& P_1<360)
                      mk1=4;
                  end
                end  
                dephase_change=rx*exp(1i*(t_1));
                dm_sig=pskdemod(dephase_change,mk,pi/mk);
                x=length(find(dm_sig~=X));
                errors= errors + x;

                if((0<=P(k)||(360==P(k)))&& P(k)<=180)       % Paper method
                      nk=2;
                elseif(180<P(k)&& P(k)<360)
                      nk=4;                    
                end
                X1= randi([0,nk-1],N,1);  % channel convolution and AWGN for paper method
                M_sig1=(pskmod(X1,nk,pi/nk)).*exp(-1i*(t(k)));
                h1 = 1/sqrt(2)*(randn(length(M_sig1),1) + 1i*randn(length(M_sig1),1)); 
                N0 = 1/snr;
                rx11 = h1.*M_sig1;
                Noise1=sqrt(N0/2)*((randn(length(M_sig1),1))+1i*randn(length(M_sig1),1));
                rx2=rx11 +Noise1;
                rx2 = rx2./h1;
                %receiver
                
                if((0<=P_1||(360==P_1))&& P_1<=180)       % Paper method
                      nk1=2;
                elseif(180<P_1&& P_1<360)
                      nk1=4;                    
                end
                dephase_change1=rx2*exp(1i*(t_1));
                dm_sig1=pskdemod(dephase_change1,nk1,pi/nk1); 
                x1=length(find(dm_sig1~=X1));
                errors1= errors1 + x1;
                
           end
           BERk2(c)=errors/(phi*N);
           if BERk2(c)==0
                BERk2(c)=10^-5;
           end
           BERBk2(c)=errors1/(phi*N);
           if BERBk2(c)==0
                BERBk2(c)=10^-5;
           end
           c=c+1;
        end
snrdb=initial:inc:final;         %plotting the curve
figure(1)
 semilogy(snrdb,BERk6,'b*-','linewidth',1);%,snrdb,BERBk6,'r+-','linewidth',1.5);
% semilogy(snrdb,BERBk6,'r+-','linewidth',1.5);
hold on;
%  semilogy(snrdb,BERk5,'go-',snrdb,BERBk5,'ys-','linewidth',1.5);
% semilogy(snrdb,BERBk5,'ys-','linewidth',1.5);
hold on;
 semilogy(snrdb,BERk4,'r^-','linewidth',1);%,snrdb,BERBk4,'y*-','linewidth',0.5);
%semilogy(snrdb,BERBk4,'g*-','linewidth',0.5);
 hold on;
% semilogy(snrdb,BERk3,'m^-',snrdb,BERBk3,'k*-','linewidth',0.5);
% semilogy(snrdb,BERBk3,'b*-','linewidth',0.5);
 hold on;
  semilogy(snrdb,BERk2,'gp-','linewidth',1);%,snrdb,BERBk2,'md-','linewidth',0.5);
%semilogy(snrdb,BERBk2,'md-','linewidth',0.5);
  legend('M=6','M=4','M=2');
%  legend('M=6 (our proposed in [1])','M=6(proposed in[1])','M=4(proposed in[1])','M=4 (our proposed method)','M=2(our proposed in[1])','M=2(proposed in [1])');
%  legend('Adaptive Modn.(phi & SNR)K=6','Adaptive Modn.(only phi)K=6','Adaptive Modn.(phi & SNR)K=4','Adaptive Modn.(only phi)K=4','Adaptive Modn.(phi & SNR)K=2','Adaptive Modn.(only phi)K=2','Adaptive Modn.(phi & SNR)K=3','Adaptive Modn.(only phi)K=3','Adaptive Modn.(phi & SNR)K=2','Adaptive Modn.(only phi)K=2');
% title('Average Symbol Error Rate Vs Signal to noise ratio(dB)');
xlabel('Signal to Noise ratio (dB)'); 
ylabel('Average Symbol Error Rate');
% grid on;
axis([-10 40 10^-7 1]);