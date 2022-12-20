clc;
clear all;
close all;

channel = random('Normal',0.1,1,1,1.e5).';
bit_size = 9*1.e3;
bits = randi([0 1],1,bit_size).';
mod_index = 64;
k = log2(mod_index);

for i = 0:5:40
    snr_db = i;
    
    %without encryption
    message = reshape(bits,length(bits)/k,k);
    mes_sym = bi2de(message);
    mod_mes = qammod(mes_sym,mod_index,'bin');          %modulation
    no_mes = awgn(mod_mes,snr_db,'measured');           %adding awgn noise
    demod_mes = qamdemod(no_mes,mod_index,'bin');       %demodulation
    rec_mes = de2bi(demod_mes,k);
    data_out = rec_mes(:);
    [num,ber(1+i/5)] = biterr(data_out,bits);
    
    %with tldc encryption
    enc_mes = tldc_algo_enc(channel(1:80),bits);        %tldc encryption
    message = reshape(enc_mes,length(enc_mes)/k,k);
    mes_sym = bi2de(message);
    mod_mes = qammod(mes_sym,mod_index,'bin');          %modulation
    no_mes = awgn(mod_mes,snr_db,'measured');           %adding awgn noise
    demod_mes = qamdemod(no_mes,mod_index,'bin');       %demodulation
    rec_mes = de2bi(demod_mes,k);
    dec_mes = tldc_algo_dec(channel(1:80),rec_mes(:).');%tldc decryption
    rec_mes1 = reshape(dec_mes,1,bit_size);
    data_out = rec_mes1(:);
    [num_1,ber_tldc(1+i/5)] = biterr(data_out,bits);
   
    %with svd encryption
    enc_mes = svd_algo_enc(channel(1:80),bits);         %svd encryption
    message = reshape(enc_mes,length(enc_mes)/k,k);
    mes_sym = bi2de(message);
    mod_mes = qammod(mes_sym,mod_index,'bin');          %modulation
    no_mes = awgn(mod_mes,snr_db,'measured');           %adding awgn noise
    demod_mes = qamdemod(no_mes,mod_index,'bin');       %demodulation
    rec_mes = de2bi(demod_mes,k);
    dec_mes = svd_algo_dec(channel(1:80),rec_mes(:).'); %svd decryption
    rec_mes1 = reshape(dec_mes,1,bit_size);
    data_out = rec_mes1(:);
    [num_2,ber_svd(1+i/5)] = biterr(data_out,bits);
end

snr_db = 0:5:40;
for j=1:9
 if (ber(j)==0)
    ber(j)=1.00e-07;
 end
end
for j=1:9
 if (ber_tldc(j)==0)
    ber_tldc(j)=1.00e-07;
 end
end

for j=1:9
 if (ber_svd(j)==0)
    ber_svd(j)=1.00e-07;
 end
 end

semilogy(snr_db,ber,'r-*',snr_db,ber_tldc,'b-v',snr_db,ber_svd,'y-s');    
legend('without encryption','with tldc encryption','with svd encryption');
ylabel('BER');
xlabel('snr db (dB)');
set(gca,'XTicklabel',[0 5 10 15 20 25 30 35 40]);
title('QAM - 64');