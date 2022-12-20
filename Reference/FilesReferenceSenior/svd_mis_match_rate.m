clc;
clear all;
close all;

loop_length = 100;
relation = zeros(1,10);
for size=1:10
    for i=1:loop_length
        client_channel = randi([-5 5], 1, 100);
        server_channel = awgn(client_channel, 30);
        result = svd_al_mr(client_channel(1:size*size),size);   %client encryption using svd algorithm
        client_key = result;
        result = svd_al_mr(server_channel(1:size*size),size);   %provider encryption using svd algorithm
        server_key = result;    
        if(client_key == server_key)                            %Mismatch calculation
            relation(size) = relation(size)+1;
        end
    end
end

plot(loop_length-relation,'b-s');
axis([1 10 0 100]);
xlabel('Dimension of the SVD matrix');
ylabel('Mismatch rate (in percentage)');
title('Mismatch rate under different dimensions of SVD Matrix');