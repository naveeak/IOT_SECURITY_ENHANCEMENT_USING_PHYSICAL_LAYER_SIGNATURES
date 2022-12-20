clear all; close all; clc

Fs = 20; % Sampling frequency
l=4;
ret = read_log_file(strcat('/home/ak/Documents/Final_year_project/ak/mismatch',int2str(l)));   % out_0508_1159 % out_0514_1046   
ret1=read_log_file(strcat('/home/ak/Documents/Final_year_project/ak/mismatch',int2str(l+1)));
% out_0518_1033 has heart rate from 4450 to 4900
%[n_packets,~] = size(ret);
n_packets=400;
% choose which channel to use
nr1 = 1;
nc1 = 1;

nr2 = 1;
nc2 = 1;

% start time 
base =  ret{1, 1}.timestamp;
varSub = zeros(1,56);
data1 = zeros(56,n_packets);
data2 = zeros(56,n_packets);

for i = 1:56
    for packet = 1:n_packets
        csi_data = ret{packet}.csi;
        csi_data1 = ret1{packet}.csi;
        if(csi_data ~= 0)
            data1(i,packet) = csi_data(nr1,nc1,i);
            data2(i,packet) = csi_data1(nr2,nc2,i);
        end
    end
    
    ang1Temp = angle(data1(i,:));
    
    ang2Temp = angle(data2(i,:));
    
    angTemp = mod(ang1Temp - ang2Temp, 2*pi);
    angTemp = hampel(angTemp, Fs*4/5,1.5);
    varSub(i) = sum(abs(angTemp-mean(angTemp)))./length(angTemp);
end
figure()
stem(varSub,'filled','Linewidth',1);
%title('Mean absolute deviation of each subcarrier');
xlabel('Subcarrier Index');
ylabel('Mean absolute deviation');
[value,index] = sort(varSub,'DESCEND');
best_sc = index(2);


%% One plot: fetch data with best subcarrier and best channel
data1 = zeros(1,n_packets);
data2 = zeros(1,n_packets);
%best_sc = 13;
for packet = 1:n_packets
    csi_data = ret{packet}.csi;
        csi_data1 = ret1{packet}.csi;
    if(csi_data ~= 0)
        data1(packet) = csi_data(nr1,nc1,best_sc);
        data2(packet) = csi_data1(nr2,nc2,best_sc);
    end
end

ang1 = angle(data1);
ang2 = angle(data2); 

raw_data = mod(ang1 - ang2, 2*pi);

figure()
plot(1:n_packets, ang1,'r');
hold on;
plot(1:n_packets, ang2,'b');
hold on;
plot(1:n_packets, mod(ang1 - ang2, 2*pi),'y','Linewidth',2);
legend('Phase 1','Phase 2','Phase Difference');
xlabel('Number of Packets')
ylabel('Phase(rad)')
%title('Phase Difference Signal');

h_data = hampel(raw_data, Fs*4/5,1.5);
h_m_data = movmean(h_data,Fs);

figure();
plot(1:n_packets, raw_data, 'r');
hold on
plot(1:n_packets, h_data, 'b','Linewidth',3);
hold on
plot(1:n_packets, h_m_data, 'g','Linewidth',3);
legend('Raw Data','After Outlier Cancellation','After Noise Cancellation')
xlabel('Number of Packets')
ylabel('Phase Shift')
%title('CSI Phase shift vs Number of packets');
%hold on
%plot(h_m_data, 'ro');
%y_3 = xcorr(y_2,length(y_2)-1);
%[autocor,lags] = xcorr(h_m_data,'coeff');
%y3 = autocorr(h_m_data,length(h_m_data)-1);
%figure();
%plot(y3);
%xlabel('Lag (days)')
%ylabel('Autocorrelation')

