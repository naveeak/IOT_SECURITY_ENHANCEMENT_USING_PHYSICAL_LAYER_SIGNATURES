 clc;
clear;
%%receiver

k=1e6;
m=32;
M=log2(m);
sym_phase=1000000;%no of symbol encryption per symbol
k=M*k;
phase_tx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');
phase_rx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');
phase_eve=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_2.csv');
for n=1:40
  snrdB=n;
    numErrs_rx = 0;
    numErrs_eve=0;
    numBits = 0;
     

 while   numErrs_rx  <200&&numBits < 1e7
%%data Generated
dataIn = randi([0 1],1,k);
tx_signal=cell(1,k/(sym_phase*M));
%%qam-16
u=1;

for i=1:k/(sym_phase*M)
    temp=dataIn((i-1)*sym_phase*M+1:(i)*sym_phase*M);
   tx_signal{i}= qam_mod(m,phase_tx(mod(i,32)+1),temp);
end
tx_signal=cell2arr(tx_signal);
 tx_signal = addGaussianNoise(tx_signal,snrdB);
% tx_signal = awgn(tx_signal,snrdB,'measured');
 
%%eve
decoded_data_eve=[];
for i=1:k/(sym_phase*M)
   temp=qam_demod(m,phase_eve(mod(i,32)+1),tx_signal((i-1)*sym_phase+1:(i)*sym_phase));
   temp=mat2array(temp);
   decoded_data_eve=[decoded_data_eve temp]
end
%%rx

decoded_data_rx=[];
for i=1:k/(sym_phase*M)
    temp=qam_demod(m,phase_rx(mod(i,32)+1),tx_signal((i-1)*sym_phase+1:(i)*sym_phase));
   temp=mat2array(temp);
   decoded_data_rx=[decoded_data_rx temp]
end

    
 numErrs_rx=biterr(decoded_data_rx,dataIn)+numErrs_rx;
 numErrs_eve=biterr(decoded_data_eve,dataIn)+numErrs_eve;
 numBits=numBits+k;
 end
 berEst_rx(n)=numErrs_rx/numBits;
 berEst_eve(n)=numErrs_eve/numBits;
end
plot1;
% plot(1:10,berEst_rx,'*')
% hold on
% plot(1:10,berEst_eve)
% grid
% xlabel("SNRdB");
% ylabel("BER");
% legends("Original Receiver","Eve_user");