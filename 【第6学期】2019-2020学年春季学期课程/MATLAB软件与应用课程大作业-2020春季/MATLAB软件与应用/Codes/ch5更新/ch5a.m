%反除，线性方程组求解，4阶希尔伯特，精确解为1;1;1...
clear,close
n=12
A=hilb(n);
cond(A)
y1=ones(n,1);
b=A*y1;
A\b

%线性方程组求解，12阶希尔伯特，精确解为1;1;1...
clear,close
n=12
A=hilb(n);
cond(A)
y1=ones(n,1);
b=A*y1;

x1=A\b  %反除
sum(x1.^2)^0.5 %残值模，用来衡量精度

[l,u]=lu(A) ; %lu分解
x2=inv(u)*inv(l)*b
sum(x2.^2)^0.5 %残值模，用来衡量精度

x3=linsolve(A,b)%核心是lu分解
sum(x3.^2)^0.5 %残值模，用来衡量精度

%超定线性方程组
clear,close
xi=[1, 2, 3],  yi=[1.5, 2.2, 3.9],
A=[xi;1,1,1]', b=yi'  %3方程2未知数
y1=A\b %所得x不能使残值r归零
r=A*y1-b
plot(xi,yi,'o');
hold on;
xx=1:0.1:3;
yy=y1(1).*xx+y1(2);
plot(xx,yy,'r');
legend('原始数据','拟合');


%-----------------------------------------------------------
close all;clear;clc;
disp('多项式 poly2sym 显示多项式的符号表达式')
p=[1, 2, 3];
poly2sym(p) %是一种符号运算
p=[2, 5, 3, 4]; %注意系数降幂排列
s=poly2sym(p)

%-----------------------------------------------------------
close all;clear;clc;
disp('多项式  求根及其逆运算')
p=[2 6 4];
poly2sym(p)
r=roots(p) %求根
p1=poly(r) %p1=[1 3 2]
poly2sym(p1)
r1=roots(p1)


%-----------------------------------------------------------
close all;clear;clc;
disp('多项式求值, polyval，polyvalm的对比')
p=[1, 2, 3];
poly2sym(p)
polyval(p,2)

y1=[1  1;1  1];
a=polyval(p,y1) %polyval对矩阵元素进行操作

b=polyvalm(p,y1)  %polyvalmb对矩阵整体进行操作
c=y1^2+2*y1+3*eye(2)%这里c和b等价，有助于理解polyvalm

%解方程 ax^2+bx+c = 0 得到符号解
solve('a*x^2+b*x+c')

%解方程 x^3= -x-2
s=solve('x^3=-x-2') %或s=solve('x^3+x+2')
double(s)   % 这样能得到数值

%解方程默认或指定未知数solver
[x1,x2]=solve('x^2*y^2,x-(y/2)-c')	%默认未知数x y
[x1,x2]=solve('x^2*y^2,x-(y/2)-c', 'x', 'c')  %指定未知数x c
[y1,y,z]=solve('sin(x)+y^2+log(z)-7=0','3*x+2^y-z^3+1=0','x+y+z-5=0', 'x','y','z')

%fsolver解方程组 需要myeq001.m配合
clear
y=fsolve('myeq001',[1,1])
r=myeq001(y)

%fsolver解方程 需要iine函数配合
clear
fun1=inline('sin(2*x+1)')%需要引号
y1=fsolve(fun1,[-0.9 0.9])
%fsolver解方程 需要@匿名函数配合
clear
fun2=@(x)(sin(2*x+1)) %不需要引号
y2=fsolve(fun2,[-0.9 0.9])

%-----------------------------------------------------------
close all;clear;clc;
disp('多项式微分polyder')
p=[2 -5 6 -1 9];
poly2sym(p)
dp=polyder(p);
poly2sym(dp)

%-----------------------------------------------------------
close all;clear;clc;
disp('多项式乘除')
a=[1,2,3]; %%poly2sym(a)
b=[2,5]; %%poly2sym(b)
ab=conv(a,b);
poly2sym(ab)
a1=deconv(ab,b)    %与a相同

%-----------------------------------------------------------
close all;clear;clc;
disp(' 一维分段插值')
%在1-12的11小时内，每隔1小时测量一次温度，
%依次为：5，8，9，15，25，29，31，30，22，25，27，24。
%试估计每隔0.1小时的温度。
hours=1:12;
temps=[5 8 9 15 25 29 31 30 22 25 27 24];
h=1:0.1:12;
%t=interp1(hours,temps,h)  %分段线性
t1=interp1(hours,temps,h,'spline');  	%nearest，spline，cubic ，pchip
t2=interp1(hours,temps,h,'pchip');  	%nearest，spline，cubic ，pchip
plot(hours,temps,'ko',h,t1,'r-',h,t2,'b-')
title('temp curve'),
xlabel('Hour'),ylabel('Degrees Celsius')
legend('原始数据','spline插值','pchip插值','Location','NorthWest')


%-----------------------------------------------------------
close all;clear;clc;
disp(' 网格型二维插值   该例子从较少的数据插值出更多数据用来绘图')
%对一根10米长钢轨进行温度传播测试。用x表示测量点0:2.5:10(米)，
%用h表示测量时间0:30:60(秒)，用T表示测试所得各点的温度(℃)。
%试用线性插值求出在一分钟内每隔5秒、钢轨每隔0.5米处的温度。
[y1,h]=meshgrid(0:2.5:10,0:30:60)
T=[95,14,0,0,0;88,48,32,12,6;67,64,54,48,41];
[xi,hi]=meshgrid(0:0.5:10,0:5:60)
TI=interp2(y1,h,T,xi,hi,'cubic');
subplot(1,2,1) %注意绘图函数的用法
surf(y1,h,T)  ,title('原始数据');
subplot(1,2,2)
surf(xi,hi,TI),title('插值数据');

%-----------------------------------------------------------
close all;clear;clc;
disp(' 散乱点型二维插值')
rand('seed',0) 
y1 = rand(100,1)*4-2; 
y = rand(100,1)*4-2; 
z = y1.*exp(-y1.^2-y.^2);
ti = -2:0.05:2; 
[XI,YI] = meshgrid(ti,ti); 
ZI = griddata(y1,y,z,XI,YI);
mesh(XI,YI,ZI), hold 
plot3(y1,y,z,'o', 'MarkerFaceColor',[1,0,0]), hold off


%-----------------------------------------------------------
close all;clear;clc;
disp('多项式拟合')
t=[20.5 32.5 51 73 95.7]; %5个数据点，4次拟合实质上是插值
r=[765 826 873 762 632];
tnew=20.5:95.7;
aa1=polyfit(t,r,1); aa2=polyfit(t,r,2); aa4=polyfit(t,r,4);
a1=aa1(1); a2=aa2(1); a4=aa4(1);
b1=aa1(2); b2=aa2(2); b4=aa4(2);
y1=polyval(aa1,tnew); y2=polyval(aa2,tnew); y4=polyval(aa4,tnew); 
plot(t,r,'ko',tnew,y1,tnew,y2,tnew,y4)
title('多项式拟合');
legend('原始数据','线性','二次','四次')


%-----------------------------------------------------------
close all;clear;clc;
disp(' 最小二乘曲线拟合lsqcurvefit, 需指定拟合函数')
% 例如这里采用fun004=a1*exp(-a2*x)+a3*exp(-a4*x)作为拟合函数
% 4个待定系数，对3个数据点无法工作，对4个数据点可做插值，对4以上数据点可做拟合
xdata=[0:.1:2];
xdata=[0:0.1:2]; 
ydata=[5.8955    3.5639    2.5173    1.9790    1.8990 ...
    1.3938    1.1359    1.0096    1.0343    0.8435    0.6856 ...
    0.6100    0.5392    0.3946    0.3903    0.5474    0.3459 ...
    0.1370    0.2211    0.1704    0.2636];
a0=[1,1,1,0];
%myfitfun1.m是拟合函数
[a,resnorm,residual,flag,output]=lsqcurvefit('myfitfun1',a0,xdata,ydata);
xi=linspace(0,2,200);
yi=myfitfun1(a,xi);
plot(xdata,ydata,'ro',xi,yi)
xlabel('x'),ylabel('y=f(x)'),
title('nonlinear curve fitting')



%-----------------------------------------------------------
close all;clear;clc;
disp(' 解方程（组），solver , fsolver')
disp('  ax^2+bx+c = 0 符号解')
solve('a*x^2+b*x+c') %多项式，用roots行不行？

syms a b c
roots([a,b,c])
%%%%%%%%%%
close all;clear;clc;
disp('  x^3+2x^2= -x-1 数值解')
s1=solve('x^3+2*x^2=-x-1')  %s1 s2是等价的，得到了精确解（符号解，观察解中有类似三分之一的内容，而不是0.333333）
s2=solve('x^3+2*x^2+x+1.0') 
double(s1)%精确解可用doubles函数截取64位数值精度, 就变成了近似数值解
double(s2)
%%%%%%%%%%
close all;clear;clc;
disp('  x^2*y^2,  x-(y/2)-b 符号解, 类似地，也可计算数值解')
[y1,y]=solve(' x^2*y^2,  x-(y/2)-b ') %本行和下行等价，说明调用方式很灵活
[y1,y]=solve(' x^2*y^2', 'x-(y/2)-b ') 
s=solve(' x^2*y^2, x-(y/2)-b ') %结构化表达方式，同上两行相比，仅仅是解得表达方式有区别

%%%%%%%%%%%
close all;clear;clc;
disp(' 另一个例子，解采用结构化方式来表达')
[y1,y,z]=solve('sin(x)+y^2+log(z)-7=0',  '3*x+2^y-z^3+1=0',  'x+y+z-5=0',  'x','y','z' )
[y1,y,z]=solve('sin(x)+y^2+log(z)-7=0',  '3*x+2^y-z^3+1=0',  'x+y+z-5=0' )



%-----------------------------------------------------------
close all;clear;clc;
disp(' 定解线性方程组，A\b ，注意是“线性方程组”，数值解，定解线性方程组是重点')
A=[100 2 3; 4 80 6; 7 8 99]; b=[105; 90; 114];%非病态，精确解是[1,1,1]，
det(A)  %行列式的秩，如果太大太小就可能求解失败，等于零也不能计算
cond(A)%如果条件数太大就是病态，可能求解失败
x1=A\b


%-----------------------------------------------------------
close all;clear;clc;
disp(' 不定线性方程组，A\b是否能解 ？不定方程组不是重点')
A = [2,3]; 
b = [1];
y1 = A\b  %只能解出一个特解（实际有无数个解）



%-----------------------------------------------------------
close all;clear;clc;
disp(' 奇异线性方程组，A\b是否能解 ？  奇异方程组不是重点')
%奇异是什么？看《线性代数》
%通俗的说就是方程组中有两个或两个以上方程是等价的
%例如 2x+3y=1 与-4x-6y= -2 实质上是等价的，称为线性相关
%这相当于减少了一个方程，造成方程数量少于未知数，类似于不定方程组
A = [2,3; -4,-6]; 
b = [1; -2];
y1 = A\b  %好像不能解，需要补充一个方程才能解，或者减少一个线性相关的方程，成为不定方程组，再按照不定方程组解出特解。
%注意看命令窗口的提示信息




%------------------------------------------------------------
close all;clear;clc;
disp(' 超定线性方程组，一般可得最小二乘解（最小二乘作为判断解的符合度的标准，当然也可以采用其他标准）')
% 有的多项式拟合问题可以归结为超定方程组
% 例如以下例子： 用线性多项式（2个待定系数）来拟合3个数据点
xi=[1;2;3];
yi=[1.5;2.2;3.9];
A=[xi(1),1;  xi(2),1;  xi(3),1]
A=[xi,[1;1;1]]
b=yi;
p=A\b
y1=1:0.1:3
y=p(1)*y1+p(2)
plot(xi,yi,'d',y1,y)

r=A*p-b %残值
rr=r.*r 
sum(rr) %残值最小二乘，平方和
%sum计算了残值平方和，即最小二乘，残值为0就是方程组严格成立，
%对于定解方程组，优秀的解方程算法可以将残值算到10e-10甚至更小，
%但对于超定方程组，只能使残值尽可能下降，代表方程组近似成立（拟合曲线尽可能接近已知数据点）
%对于本例，残值平方和为0.1666667
