semilogy(1:length(berEst_rx),berEst_rx)
hold on
semilogy(1:length(berEst_eve),berEst_eve)
grid
xlabel("SNRdB");
ylabel("BER");
title("Modulation:QAM-32");
a=legend("Original Receiver","Eve-user");
a.Location="southeast";