%��������/�ű�M�ļ�
clear;close all;
tic
x=[-6:0.1:6];leng=length(x);
for m=1:leng;
    if x(m)<=0
        y(m)=sin(x(m)); 
%Ҳ�ɻ���y(m)=mysind(x(m)/pi*180)
%˵������/�ű��ļ��ɵ����û��Խ�����
    elseif x(m)<=3
        y(m)=x(m);
    else y(m)=-x(m)+6;
    end
end
plot(x,y);  grid;
toc

%���¼��п��Դ������������
%clear;close all;
%tic
%x=-6:0.1:6;
%y=myf1(x);       %���ú���myf1.m
%plot(x,y); grid
%toc



