clear;
close all;
files = dir('*.csv');
len=length(files);
for i=1:len
    oldname=files(i).name;
    newname=strcat('sample_', oldname);
    command = ['rename' 32 oldname 32 newname];
    status = dos(command);
    if status == 0
        disp([oldname, ' �ѱ�������Ϊ ', newname]);
    else
        disp([oldname, ' ������ʧ��!']);
    end
end
