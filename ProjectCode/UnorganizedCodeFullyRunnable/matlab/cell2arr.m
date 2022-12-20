function arr=cell2arr(y)
len=length(y);
arr=[];
 cell_len=length(y{1,1});
for i=1:len
    temp=[];
     for j=1:cell_len
         temp=[temp y{1,i}(j)];
     end
    arr=[arr temp];
end