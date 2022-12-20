clc
clear all;
close all;

%Leakage tldc
channel_length_tldc = 512;
leakage_ratio_tldc = zeros(1,6);

for loop = 1:50
    k = 1;
    for i = 20:-10:-30
        client_channel_tldc = randi([-5 5], 1, channel_length_tldc);        
        adversary_channel_tldc = round((awgn(client_channel_tldc, i))); 
        %adversary_channel_tldc = ((client_channel_tldc).* (i)^-2);
        
        result = CFO(client_channel_tldc);                                  %client channel encryption using tldc algo
        client_combination_tldc = result;
        result = CFO(adversary_channel_tldc);                               %adversary channel encryption using tldc algo
        server_combination_tldc = result;
        leak = 0;
        for j = 1:length(server_combination_tldc)                           %comparing the keys of client and adversary
            if(client_combination_tldc(j) == server_combination_tldc(j))
                leak = leak + 1;
            end
        end
        leakage_ratio_tldc(k) = leakage_ratio_tldc(k) + leak;
        k = k+1;
    end
end
leakage_ratio_tldc = leakage_ratio_tldc/50;

%Leakage svd
channel_length_svd = 100;
leakage_ratio_svd = zeros(1,6);

for loop = 1:50
    k = 1;
    for i = 20:-10:-30
        client_channel_svd = randi([-5 5], 1, channel_length_svd);
        adversary_channel_svd = round((awgn(client_channel_svd, i)));
        result = svd_al(client_channel_svd,10);                          %client channel encryption using svd algo
        client_combination_svd = round(result,1);
        result = svd_al(adversary_channel_svd,10);                      %adversary channel encryption using svd algo
        adversary_combination_svd = round(result,1);
        leak = 0;
        for j = 1:sqrt(channel_length_svd)                              %comparing the keys of client and adversary
            if(client_combination_svd(j) == adversary_combination_svd(j))
                leak = leak + 1;
            end
        end
        leakage_ratio_svd(k) = leakage_ratio_svd(k) + leak;
        k = k+1;
    end
end
leakage_ratio_svd = leakage_ratio_svd/50;

x= 1:6
plot(x,leakage_ratio_tldc,'r-*',x,leakage_ratio_svd,'b-s');
legend('TLDC','SVD');
xlabel('Distance (as a function of SNR)');
ylabel('Leakage (in percentage)');
title('Information leakage to the adversary with different distances');