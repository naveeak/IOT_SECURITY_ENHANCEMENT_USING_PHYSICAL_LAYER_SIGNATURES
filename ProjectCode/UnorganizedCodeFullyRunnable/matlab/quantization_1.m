function ret= quantization_1(values)
for i=2:length(values)
    if (values(i)>values(i-1))
        y(i-1)=0;
    else
        y(i-1)=1;
    end
        
end
char(y+'0');
ret=y>0;