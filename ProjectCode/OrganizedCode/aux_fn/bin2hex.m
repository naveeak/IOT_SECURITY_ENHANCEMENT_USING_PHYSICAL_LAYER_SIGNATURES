function x = bin2hex(BinStr)
% BIN2HEX (BinStr,...output)
%
% Converts binary strings of any length to hexadecimal pairs. Adds leading
% zeros if there is not an even number of hex bits.
%
% Now also supports cell array inputs.
%
%
% Author: Richard Medlock 2001
% Check to see what the input is:
if iscell(BinStr)
    
    NCells = length(BinStr)
    
    for C = 1:NCells
        
        Str = BinStr{C};
        
        x{C} = doconvert(Str);
        
    end
    
elseif ~ischar(BinStr)
    
    error('Input must be a string or character or cell array.')
    
else
    
    x = doconvert(BinStr);
    
end