%Ŀ¼�й�
which myfun1
what

%�������й�
12a=100
a12=100
a_12=100
a-12=100
a&12=100
A=1
a=2
A+a

%Ԥ�賣��
pi
format long
pi
format long e
pi
format short
pi
clear

%���
clear
a=1
b=1;
c=a+...
    b

e=100; f=200, g=e+f;

%���еȲ���
clear e g
clear all
a=100
if a>0
    b=1
else
    b=-1
end

%�鿴�������Ȳ���
clear
clc
a=randn(3)
b=100
syms c
x='123456'
who
whos
whos a b


%�����й�
help solve
doc solve
demo
lookfor asin
lookfor solve

%��ʾ�������
clear
p = [2,0,-3,71,-9,13];  %��������ʽϵ������
x = roots(p);               %���


%��ʾ�������
clear
p = [2,0,-3,71,-9,13];  %��������ʽϵ������
x = roots(p);               %���

%��ʾ��ֵ��������Է�����
clear
a = [2,3,-1;8,2,3;45,3,9];   %����ϵ������a
b = [2;4;23];                      %����������b
x = inv(a)*b

%��ʾ������������Է�����
clear
syms x y z  %�������ű���
[x,y,z]=solve(2*x+3*y-z-2,8*x+2*y+3*z-4, 45*x+3*y+9*z-23)

%��ʾ������������Է���
clear
syms x y z  %�������ű���
solve(2*x+y+z)

%��ʾ����
clear
quad('x.*log(1+x)',0,1)   %��ֵ��
syms x, int(x*log(1+x),0,1)   %���Ž�

%��ʾ��һ�����Ż���
clear
syms x a, int(a*sin(x),0,1)

%��ʾ����ʽ������ͼ
clear
x=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]   %ԭʼ����x  
y=[1.2, 3, 4, 4, 5, 4.7, 5, 5.2, 6, 7.2] %ԭʼ����y
p1=polyfit(x,y,1)  %1�ζ���ʽ���
p3=polyfit(x,y,3)  %3�ζ���ʽ���

x2=1:0.1:10;
y1=polyval(p1,x2);
y3=polyval(p3,x2);
%��ԭʼ���ݡ�1��������ߺ�3��������߻�ͼ
plot( x, y, '*', x2, y1, ':', x2, y3)
legend('ԭʼ����','1�����','3�����')

%���ú���myplot.m,  �ú���������Ļ�ͼ��������
x1=1:6
y1=sin(x1)
x2=1:0.2:6
ym=sin(x2)+sin(2*x2)/5
ym=[ym;ym+randn(1,26)/5]
myplot1(x1,y1,x2,ym)
