function ans_hash = hash(string)
persistent md
if isempty(md)
    md = java.security.MessageDigest.getInstance('SHA-256');
end
ans_hash = sprintf('%2.2x', typecast(md.digest(uint8(string)), 'uint8')');
end