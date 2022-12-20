function arr=mat2array(x)
[rows ,columns] = size(x);
arr=[];
for i=1:columns
   
    arr=[arr x(:,i)'];
end

