 clc;
clear;
%%receiver

k=1e3;
m=16;
M=log2(m);
phase_tx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');
phase_rx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');
phase_eve=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_2.csv');
for n=1:40
  snrdB=n;
    numErrs_rx = 0;
    numErrs_eve=0;
    numBits = 0;
     

 while   numErrs_rx  <200&&numBits < 1e5
%%data Generated
dataIn = randi([0 1],1,k);

%%qam-16
u=1;

for i=1:k/M
    temp=dataIn((i-1)*M+1:(i)*M);
   tx_signal(i)= qam_mod(m,phase_tx(mod(i,32)+1),temp);
end
 tx_signal = addGaussianNoise(tx_signal,snrdB);
% tx_signal = awgn(tx_signal,snrdB,'measured');
 
%%eve
decoded_data_eve=[];
for i=1:k/M
   temp=qam_demod(m,phase_eve(mod(i,32)+1),tx_signal(i));
   decoded_data_eve=[decoded_data_eve temp']
end
%%rx

decoded_data_rx=[];
for i=1:k/M
    temp=qam_demod(m,phase_rx(mod(i,32)+1),tx_signal(i));
   decoded_data_rx=[decoded_data_rx temp']
end

    
 numErrs_rx=biterr(decoded_data_rx,dataIn)+numErrs_rx;
 numErrs_eve=biterr(decoded_data_eve,dataIn)+numErrs_eve;
 numBits=numBits+k;
 end
 berEst_rx(n)=numErrs_rx/numBits;
 berEst_eve(n)=numErrs_eve/numBits;
end
% plot(1:10,berEst_rx,'*')
% hold on
% plot(1:10,berEst_eve)
% grid
% xlabel("SNRdB");
% ylabel("BER");
% legends("Original Receiver","Eve_user");