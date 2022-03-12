%目录有关
which myfun1
what

%变量名有关
12a=100
a12=100
a_12=100
a-12=100
a&12=100
A=1
a=2
A+a

%预设常量
pi
format long
pi
format long e
pi
format short
pi
clear

%标点
clear
a=1
b=1;
c=a+...
    b

e=100; f=200, g=e+f;

%换行等操作
clear e g
clear all
a=100
if a>0
    b=1
else
    b=-1
end

%查看工作区等操作
clear
clc
a=randn(3)
b=100
syms c
x='123456'
who
whos
whos a b


%帮助有关
help solve
doc solve
demo
lookfor asin
lookfor solve

%演示方程求根
clear
p = [2,0,-3,71,-9,13];  %建立多项式系数向量
x = roots(p);               %求根


%演示方程求根
clear
p = [2,0,-3,71,-9,13];  %建立多项式系数向量
x = roots(p);               %求根

%演示数值运算解线性方程组
clear
a = [2,3,-1;8,2,3;45,3,9];   %建立系数矩阵a
b = [2;4;23];                      %建立列向量b
x = inv(a)*b

%演示符号运算解线性方程组
clear
syms x y z  %建立符号变量
[x,y,z]=solve(2*x+3*y-z-2,8*x+2*y+3*z-4, 45*x+3*y+9*z-23)

%演示符号运算解线性方程
clear
syms x y z  %建立符号变量
solve(2*x+y+z)

%演示积分
clear
quad('x.*log(1+x)',0,1)   %数值解
syms x, int(x*log(1+x),0,1)   %符号解

%演示另一个符号积分
clear
syms x a, int(a*sin(x),0,1)

%演示多项式拟合与绘图
clear
x=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]   %原始数据x  
y=[1.2, 3, 4, 4, 5, 4.7, 5, 5.2, 6, 7.2] %原始数据y
p1=polyfit(x,y,1)  %1次多项式拟合
p3=polyfit(x,y,3)  %3次多项式拟合

x2=1:0.1:10;
y1=polyval(p1,x2);
y3=polyval(p3,x2);
%对原始数据、1次拟合曲线和3次拟合曲线绘图
plot( x, y, '*', x2, y1, ':', x2, y3)
legend('原始数据','1次拟合','3次拟合')

%调用函数myplot.m,  该函数由上面的绘图窗口生成
x1=1:6
y1=sin(x1)
x2=1:0.2:6
ym=sin(x2)+sin(2*x2)/5
ym=[ym;ym+randn(1,26)/5]
myplot1(x1,y1,x2,ym)
