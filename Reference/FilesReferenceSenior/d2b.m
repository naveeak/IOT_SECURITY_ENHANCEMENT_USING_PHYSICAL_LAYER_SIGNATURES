function tldc_d2b=d2b(v1)
n = 9;         % number bits for integer part of your number      
m = 7;         % number bits for fraction part of your number
% binary number
x=length(v1);
d2b3=zeros(x,16);
for i=1:x
    a=v1(i);
    d2b1= fix(rem(a*pow2(-(n-1):m),2));
    if(a<0)
        d2b2=1;
        d2b3(i,1:end)=horzcat(d2b2,d2b1(1,2:end));
    else
        d2b2=0;
        d2b3(i,1:end)=horzcat(d2b2,d2b1(1,2:end));
    end
end
tldc_d2b=reshape(d2b3,1,16*x);