%@Run test for randomness
data_manipulation_10_key_runtest;
for i=1:length(key)
    h=runstest(hex2bin(key_hash{i}));
    p(i)=h;
    if(p(i)==0)
        disp(strcat('Key-',int2str(i),' is random by run test'));
    end
end
