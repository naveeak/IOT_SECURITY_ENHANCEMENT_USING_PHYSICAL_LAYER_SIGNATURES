% clc;
% clear all;
% close all;
data=[0  1 0 1 1 1 0 0 1 1]; % information
%Number_of_bit=1024;
%data=randint(Number_of_bit,1);

data_NZR=2*data-1; % Data Represented at NZR form for QPSK modulation
s_p_data=reshape(data_NZR,2,length(data)/2);  % S/P convertion of data
br=10.^6; %Let us transmission bit rate  1000000
f=br; % minimum carrier frequency
T=1/br; % bit duration
t=T/99:T/99:T; % Time vector for one bit information
% phs=[pi/2,pi/4,pi/8];
phs=pi/4;
y=[];
y_in=[];
y_qd=[];
for(i=1:length(data)/2)
    y1=s_p_data(1,i)*cos((2*pi*f*t)+phs); % inphase component(mod(i,4)+1
    y2=s_p_data(2,i)*sin((2*pi*f*t)+phs) ;% Quadrature component
    y_in=[y_in y1]; % inphase signal vector
    y_qd=[y_qd y2]; %quadrature signal vector
    y=[y y1+y2]; % modulated signal vector
end
Tx_sig=y; % transmitting signal after modulation


