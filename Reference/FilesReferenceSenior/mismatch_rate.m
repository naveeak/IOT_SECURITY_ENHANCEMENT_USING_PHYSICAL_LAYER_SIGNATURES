clc;
clear all;
close all;

%Mismatch rate
channel_length = 80;
loop_length = 500;
relation = zeros(1,channel_length/8);
for j=1:2
    for loop = 1:loop_length
        for i = 8:8:channel_length
            client_channel = randi([-5 5] , 1, i);
            server_channel = (awgn(client_channel, 40));
            result = CFO(client_channel(1:i));               %client encryption using svd algorithm
            client_combination = result;
            result = CFO(server_channel(1:i));              %provider encryption using svd algorithm
            server_combination = result;
            if (client_combination == server_combination)   %Mismatch calculation
                relation(i/8) = relation(i/8) + 1;
            end
        end
    end
end

figure(1);
plot(loop_length-relation(2:2:end)/5,'b-*');
xlabel('No. of buckets');
set(gca,'XTicklabel',[2 3 4 5 6 7 8 9 10]);
set(gca,'YTicklabel',[0 10 20 30 40 50 60 70 80 90 100]);
ylabel('Mismatch rate (in percentage)');
title('Mismatch rate under different no. of buckets');

