
clc;
clear;
close all;
read=[];
for i=1:1
file=strcat('/home/ak/Documents/Final_year_project/csi_extract/ece-257b-final-project-76c35e8c38ae0509708208c53e6176b9aeb7352e/ece-257b-final-project.git/code/out_0610_2215_80_sm');
%'/home/ak/Documents/Final_year_project/Dataset/Data/wn_',int2str(i),'.csv'
% /home/ak/Documents/Final_year_project/csi_extract/ece-257b-final-project-76c35e8c38ae0509708208c53e6176b9aeb7352e/ece-257b-final-project.git/code
temp=read_log_file(file);
read=vertcat(read, temp);
end
data=cell(length(read),1);
