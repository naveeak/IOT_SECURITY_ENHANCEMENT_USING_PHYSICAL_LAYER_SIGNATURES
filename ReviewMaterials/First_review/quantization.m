
function  y=quantization(values)
%  quantize_value=(((min(values)+max(values))/2));
%quantize_value=sum(means_abs)/length(means_abs);
quantize_value=median(values);
y=values>quantize_value;
 temp=std(values);
len=length(y);
while check_equality_0_1(y)==0
    temp=temp/2;
    if temp==0
        break;
    end
    if count_0_1(y)<(len/2)
    quantize_value=quantize_value+temp;
    y=values>quantize_value;
    else
     quantize_value=quantize_value-temp;
     y=values>quantize_value;
    end
    
    
end
disp(quantize_value);


