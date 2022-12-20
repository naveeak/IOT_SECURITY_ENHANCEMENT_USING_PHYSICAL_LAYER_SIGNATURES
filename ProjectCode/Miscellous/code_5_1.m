% a=importdata('csi_a16_23.dat');
% text=a.textdata;
% f = fopen('csi_a16_23.dat', 'rb');
% field_len = fread(f, 1, 'uint16', 0, 'ieee-be');
filename = 'csi_a16_23.dat';
opt = detectImportOptions(filename);
t = readtable(filename, opt);