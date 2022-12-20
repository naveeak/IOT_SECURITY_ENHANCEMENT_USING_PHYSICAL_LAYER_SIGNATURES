 clc;
clear;
%%receiver
EbNoVec = (50:55)';
k=1024;
m=16;
M=log2(m);
phase_tx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');
phase_rx=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_1.csv');
phase_eve=phase_calculation_fn('/home/ak/Documents/Final_year_project/ashok_csi/local_ashok_diff_room_2.csv');
for n=1:length(EbNoVec)
    snrdB = EbNoVec(n) + 10*log10(k/M);
    numErrs_rx = 0;
    numErrs_eve=0;
    numBits = 0;
     

 while   numBits < 1024
%%data Generated
dataIn = randi([0 1],1,k);

%%qam-16
u=1;

for i=1:k/4
    temp=dataIn((i-1)*M+1:(i)*M);
   tx_signal(i)= qam_mod(m,phase_tx(mod(i,32)+1),temp);
end
 tx_signal = addGaussianNoise(tx_signal,snrdB);
% tx_signal = awgn(tx_signal,snrdB,'measured');
 
%%eve
decoded_data_eve=[];
for i=1:k/4
    temp=qam_demod(m,phase_eve(mod(i,32)+1),tx_signal(i));
   decoded_data_eve=[decoded_data_eve temp']
end
%%rx

decoded_data_rx=[];
for i=1:k/4
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
plot(EbNoVec,berEst_rx,'*')
hold on
plot(EbNoVec,berEst_eve)
grid
