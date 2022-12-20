function ret=check_equality_0_1(y)
ret=false;
len=length(y);
if count_0_1(y)==((len/2)+1)
    ret=true;
end
    