function result = svd_al(channel,size)

channel_length = size*size;
matrix = reshape(channel,size,size);
[u,l,v] = svd(matrix);
key = round(reshape(l,1,size*size));
bucket_length = 10;

bit_array = [];
for i=1:length(key)
    tldc_d2b = d2b(key(i));
    binary = tldc_d2b;
    bit_array = [bit_array binary];
end

bit_matrix = reshape(bit_array,channel_length,16)
frequency_Offset = 0.1;
M = 16;
Injection_length_temp = (2*channel_length)/(M*bucket_length);
Injection_length = floor(Injection_length_temp);

CFO_Vector = reshape(bit_array,channel_length,M);

%Convert to decimal
for i = 1:channel_length
    temp = CFO_Vector(i,1:end);
    cfo_b2d=b2d(temp,M);
    decimal_value(i) = cfo_b2d;
end

CFO_Matrix = decimal_value*frequency_Offset;
result = CFO_Matrix;

