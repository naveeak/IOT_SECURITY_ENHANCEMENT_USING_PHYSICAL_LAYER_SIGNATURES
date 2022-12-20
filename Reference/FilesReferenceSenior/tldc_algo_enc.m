function data = tldc_algo_enc(channel,message)

channel_length = length(channel);
%Differential CSI
diff_CSI = zeros(1,channel_length);

for i=1:channel_length-1
    diff_CSI(i) = channel(i+1) - channel(i);
end;

%Create bucket_matrix
bucket_length = 8;
bucket_row = channel_length/bucket_length;
bucket_column = bucket_length;
bucket_matrix = zeros(bucket_row,bucket_column);
trav = 1;

for i=1:bucket_row
    for j=1:bucket_column
        bucket_matrix(i,j) = diff_CSI(trav);
        trav = trav+1;
    end
end

%Four Shape Pattern Vector
diff_min = min(diff_CSI);
diff_max = max(diff_CSI);
FSP_row = 4;
FSP_column = bucket_length;

FSP_vector = zeros(FSP_row,FSP_column);

for i=1:bucket_length
    FSP_vector(1,i) = i*diff_min/channel_length;
    FSP_vector(3,i) = i*diff_max/channel_length;
end

for i=bucket_length:-1:1
    FSP_vector(2,bucket_length-i+1) = i*diff_min/channel_length;
    FSP_vector(4,bucket_length-i+1) = i*diff_max/channel_length;
end

%Find Frechet distance
trav = 1;
for i=1:channel_length/bucket_length
    for j=1:FSP_row
        for k=1:bucket_length
            diff(k) = abs(bucket_matrix(i,k) - FSP_vector(trav,k));
        end
        max_element = max(diff);
        
        %Coupling
        if(i>1 && j>1)
            max_1 = max(result_mat(i-1,j),result_mat(i,j-1));
            max_2 = max(max_1, result_mat(i-1,j-1));
            result_mat(i,j) = min(max_element,max_2);
        else
            result_mat(i,j) = max_element;
        end
        
        trav = trav+1;
    end
    trav = 1;
end

result_matrix = result_mat.';
result_vector = min(result_matrix);

%Key generation
key = [];
combination = [];
for i=1:channel_length/bucket_length
    for j=1:bucket_length
        if(result_vector(i) == result_matrix(j,i))
            key = [key FSP_vector(j,1:end)];
            combination = [combination j];
            break;
        end
    end
end

bit_array = [];
for i=1:length(key)
    tldc_d2b = d2b(key(i));
    binary = tldc_d2b;
    bit_array = [bit_array binary];
end

bit_matrix = reshape(bit_array,channel_length,16);

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

message_length = length(message);

CFO_Matrix = sort(CFO_Matrix,'descend');

%Encryption
Encrypted_Vector = [];
for i = 1:message_length
    j = mod(i,Injection_length);
    if(j == 0)
        temp = Injection_length;
    else
        temp = j;
    end
    Encrypted_Vector(i) = message(i)*CFO_Matrix(temp);
end

mat = d2b(Encrypted_Vector);
[x,y] = size(mat);
data = reshape(mat,1,x*y);
end