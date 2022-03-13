%符号变量定义
clc,clear,close all
disp('定义符号变量')
syms a;  % a定义为符号变量
syms b  c;  % b c 定义为符号变量'
f=sym('a*b+2/3*y^2'); % f定义为符号变量，并赋值为
e=f - a*b % e通过表达式赋值定义为符号变量,值为(2*y^2)/3

pause
A=sym('aa') %这两个变量的值不同
A=sym('bb')

pause
clc,clear,close all
disp('定义符号变量  错误示范')
try
x=sym x;  x=sym 'x';  syms x,y,z;
catch
    disp('以上是错误示')
end

pause
clear
sym a  %可以运行，但也是有问题的，运行一下得到什么? 定义了变量a ?  用whos查一查
whos
sym(a)
whos

pause
clc,clear,close all
a=sin(pi/4)      % sin(pi/4)为数值常量
b=sym('sin(pi/4)')   % 这里sin(pi/4)为符号常量


pause
clc,clear,close all
disp('定义符号变量  sym')
f= sym('sin(x)^2+ cos(x)^2')                   
A=0.25 
sym(A)   %结果是1/4
sym('A')  %结果是A
A='1/5'   %A是字符串
A=sym('1/8')
sym('sqrt(3)') 
sym(sqrt(3))

%用sym函数建立符号表达式。
f1=sym('a*x^2+b*x+c'); 
solve(f1)
%使用已经定义的符号变量组成符号表达式。
syms  x  y  a  b  c
f2=a*x^2+b*x+c  %不加单引号
solve(f2)
%????   
f3='a*x^2+b*x+c'    %f是字符串变量
solve(f3)

      	sym('x', 'real')
        sym('y', 'real')
        syms x y 'real'
        conj(x)
        sym('x', 'unreal')
        conj(x)

		sym(1/3,'f')
		sym(1/3,'e')
		sym(1/3,'r')
		sym(1/3,'d')
        
pause
clc,clear,close all
disp('默认变量')
syms a b c x y t i j
sin(a*x+b*y),subs(ans,1)
a*x^2+b*x+c,subs(ans,1)
1/(4+cos(t)),subs(ans,1)
4*x/y,subs(ans,1)
2*a+b,subs(ans,1)
2*i+4*j,subs(ans,1)

pause
clc,clear,close all
disp('自动获取默认自变量')
f=sym('sin(a*x+b*y)'); findsym(f)
f=sym('sin(a*x+b*y)'); findsym(f,1)
f=sym('sin(a*x+b*y)'); findsym(f,2)

pause
clc,clear,close all
disp('符号、符号矩阵的基本运算')
syms a b c x y z v w
f=(a*x+b*y-c*z)/2*v*w^2
A=[a,b;2*a,-b]*[2*x,b;2*a,-3*c]
inv(A)
det(A)
p=[1,2,3], s=poly2sym(p)  %多项式/符号表达式的转换
expand(s*s), sym2poly(s*s)


%所有数值运算符（包括矩阵运算）和 大部分数值运算函数也可用于符号运算。
syms a b c d
m1=[a,b]; m2=[c,d]
x=m1+m2
y=[m1;m2]
z1=y.^2
z2=y^2
inv(z1)
det(z2)




pause
clc,clear,close all
disp('符号常用运算函数numden')
f1=sym('1/(a-b)')
f2=sym('2*a/(a+b)')
[n,d]=numden(f1+f2)    %n/d等于f1+f2

pause
clc,clear,close all
disp('符号常用运算函数collect')
f=sym('x^2*y+y*x-x^2-2*x')
collect(f) 
syms x y;
collect(x^2*y+y*x-x^2-2*x)

pause
clc,clear,close all
disp('符号常用运算函数expand')
f=sym('(x-2)*(x-4)'); 
expand(f)   %结果是x^2 - 6*x + 8
%expand((x-2)*(x-4))是否可行

pause
clc,clear,close all
disp('符号常用运算函数factor')
syms x
factor(x^3-6*x^2+11*x-6)

pause
clc,clear,close all
disp('符号常用运算函数horner')
syms x;
horner(x^3-6*x^2+11*x-6)

pause
clc,clear,close all
disp('符号常用运算函数simplify')
syms x
simplify(sin(x)^2 + cos(x)^2)   %结果为1
simplify((x^2+5*x+6)/(x+2))  %结果x+3
%simplify(sqrt(16))  %这样不行，因为sqrt(16)系统默认为数值
f0=simplify(sqrt(sym('16')))  %这样结果为4，sqrt( sym('16') )定义为符号型
f1=sqrt(sym(16))
f2=sqrt(sym('16'))
f3=sqrt(16)
f4=sym(16)
f5=sqrt(f3)
f6=sqrt(f4)
whos    %用whos 可查看以上定义的数据类型

pause
clc,clear,close all
disp('符号常用运算函数simple')
syms x
f=2*cos(x)^2-sin(x)^2;
simple(f)
[r,how]=simple(f) 

pause
clc,clear,close all
disp('符号方程')
f1=sym('a*x^2+b*x=-c'); %符号方程
syms x y a b c
f2=a*x^2+b*x+c
f3='a*x^2+b*x+c'    %对比f1 f2 f3 f4
f4='a*x^2+b*x+c=0'   %符号方程
s1=solve(f1)
s2=solve(f2)
s3=solve(f3)%对比s1 s2 s3 s4
s4=solve(f4)
subs(s3,a,1)
s5=subs(subs(subs(s3,a,1),b,1),c,1)

pause
clc,clear,close all
disp('符号矩阵 符号方程组1')
syms a b1 b2
b1=a
b2=3*a
b=[b1;b2]
A=[2,-1;2,1]
x=A\b   %反除法可用于数值和符号运算

pause
clc,clear,close all
disp('符号方程组2')
f1=sym('x+y+z-10*a');
f2=sym('x-y+z');
f3=sym('2*x-y-z+4*a');
solve(f1,f2,f3);
[x,y,z]=solve(f1,f2,f3) %建议不要省略输出列表
s=[x,y,z]
subs(s,'a',1) %通过符号代入可得到解2,5,3

pause
clc,clear,close all
disp('subs的用法')
syms a b
subs(a+b,a,4)      

pause
f=sym('a+b')
subs(f,'a',4)       % 'a'改成a则不能运行
subs('a+b+c','a',4) % 'a'改成a则不能运行
syms a
subs(f,a,4)      % a被定义为符号变量后，可运行了
subs('a+b+c',a,4)% a被定义为符号变量后，可运行了


pause
clc,clear,close all
disp('符号-数值的转换')

s=solve('3*x^2+2*x-6=0')
f1=vpa(s) %观察f1 f2
f2=vpa(s,6)

syms x;
y=x-cos(x);
z1=subs(y,x,'pi')   %观察z1 z2
digits(15)
z2=vpa(z1)

pause
clc,clear,close all
disp('符号常用运算函数  合计 symsum')
syms k n;
f1=symsum(k)
f2=symsum(k^2,0,n)
f3=subs(f2,n,10)
f4=symsum(k^2,0,10)  %f3 f4应该相等



pause
clc,clear,close all
disp('梯度函数   计算f(x,y)的梯度')
[x,y]=meshgrid(-2:0.1:2);
f=x.*exp(-x.^2-y.^2);
subplot(1,2,1);
surfc(x,y,f);title('函数');%绘制三维曲面和投影型等高线图
xlabel('x');ylabel('y');zlabel('f');
subplot(1,2,2);
contourf(x,y,f);title('等高线和梯度');hold;%绘制填充型等高线图
[dx,dy]=gradient(f,0.1,0.1);%计算梯度
quiver(x,y,dx,dy)    %在填充型等高线图上叠加梯度矢量图


pause
clc,clear,close all
disp('diff 微分  ,用diff计算梯度（不用gradient）并绘图')
syms x y a b c
f=sym('x*exp(-x^2-y^2)')
dx= diff(f,x,1)
dy= diff(f,y,1)
[x1,y1]=meshgrid(-2:0.1:2);
dx1=vpa(subs(dx,{x,y},{x1,y1}))
dy1=vpa(subs(dy,{x,y},{x1,y1}))
quiver(x1,y1,dx1,dy1)    %梯度矢量图 
