function ret=count_0_1(y)
x=0;
for m=1:length(y)
if y(m)==1
    x=x+1;
end
end
ret=x;

    