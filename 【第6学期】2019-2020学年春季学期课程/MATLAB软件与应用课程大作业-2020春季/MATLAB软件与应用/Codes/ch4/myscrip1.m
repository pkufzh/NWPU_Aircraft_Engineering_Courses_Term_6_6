%这是命令/脚本M文件
clear;close all;
tic
x=[-6:0.1:6];leng=length(x);
for m=1:leng;
    if x(m)<=0
        y(m)=sin(x(m)); 
%也可换成y(m)=mysind(x(m)/pi*180)
%说明命令/脚本文件可调用用户自建函数
    elseif x(m)<=3
        y(m)=x(m);
    else y(m)=-x(m)+6;
    end
end
plot(x,y);  grid;
toc

%以下几行可以代替上面的内容
%clear;close all;
%tic
%x=-6:0.1:6;
%y=myf1(x);       %调用函数myf1.m
%plot(x,y); grid
%toc



