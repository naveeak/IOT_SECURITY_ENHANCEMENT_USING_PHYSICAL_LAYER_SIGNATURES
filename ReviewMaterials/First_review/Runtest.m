%@Run test for randomness

for i=1:length(key)
    p(i)=runstest(key{i});
end