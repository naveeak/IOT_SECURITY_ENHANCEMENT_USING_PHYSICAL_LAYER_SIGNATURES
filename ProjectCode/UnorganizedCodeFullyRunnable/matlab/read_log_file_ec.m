%%This is function that return the packet information including
%%csi,rssi,etc it checkes whether the returning variable is 0 ,if so it stops the operation

function ret =read_log_file_ec(filename)
ret=read_log_file(filename);
if(size(ret) == 0)
    
    fprintf("Halting the current opertion due to above Error\n\n");
    %error("error");
  
end
end