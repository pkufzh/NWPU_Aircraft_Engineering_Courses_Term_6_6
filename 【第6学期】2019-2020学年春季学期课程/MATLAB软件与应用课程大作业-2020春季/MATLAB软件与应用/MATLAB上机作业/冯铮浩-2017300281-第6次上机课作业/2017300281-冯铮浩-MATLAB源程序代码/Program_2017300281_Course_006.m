%% MATLAB软件与应用（第6次上机MATLAB程序源代码）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月22日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format long
warning off;

fprintf('MATLAB软件与应用（第6次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月22日\n');
fprintf('\n');
fprintf('部分程序运行结果如下：\n');
fprintf('\n');

%% Problem_001（符号函数y=5x^3+3y^2+x+9分别对x、y进行二阶微分，并对x进行定积分计算，其中x=(0,1)）
fprintf('【1】问题一：对符号函数进行微分与积分结果如下：\n');
fprintf('\n');

% 建立符号函数表达式
syms x y;
f=5*x^3+3*y^2+x+9;

% 第一小问：将符号函数表达分别对x、y进行二阶微分（符号微分diff）
fprintf('【1.1】第一小问：符号函数分别对x、y进行二阶微分结果如下：\n');
dfdx=diff(f,x,2); % 对x进行二阶微分
dfdy=diff(f,y,2); % 对y进行二阶微分
dfdx
dfdy

% 第二小问：将符号函数表达对x进行定积分，x=(0,1)（符号积分int）
fprintf('【1.2】第二小问：将符号函数表达对x在(0,1)上进行定积分微分结果如下：\n');
int_f_x=int(f,x,0,1);
int_f_x

%% Problem_002（已知f(x)，g(y)，求复合函数f(g(y))）
fprintf('【2】问题二：已知f(x)，g(y)，求复合函数f(g(y))结果如下：\n');
fprintf('\n');

% 写出f(x)与g(y)表达式
syms x y;
f=(1/(x^3))+2*x^2;
g=sin(y)+cos(y);
f
g

% 利用subs函数进行复合函数f(g(y))
f_g=subs(f,g);
f_g

%% Problem_003（计算下列各式的不定积分）
fprintf('【3】问题三：计算下列各式的不定积分结果如下：\n');
fprintf('\n');

% 不定积分（表达式一）
fprintf('【3.1】不定积分（表达式一）：\n');
syms x;
f_1=(x-1)/((x^4)+1);
indef_int_1=int(f_1,x);
indef_int_1

% 不定积分（表达式二）
fprintf('【3.2】不定积分（表达式二）：\n');
syms x;
f_2=((sin(2*x))^3)*cos(x);
indef_int_2=int(f_2,x);
indef_int_2

%% Problem_004（求微分方程组的特解）
fprintf('【4】问题四：求微分方程组的特解结果如下：\n');
fprintf('\n');

% 步骤一：求微分方程组的通解
fprintf('步骤一：首先求微分方程组的通解结果如下：\n');
syms t C1 C2; % 定义常数符号变量
[x,y]=dsolve('Dx=(-3*x)+y,Dy=(8*x)-y')

% 步骤二：代入t=0时的初始值，构建有关C1，C2的方程组
x_0=subs(x,t,0);
x_0_eq=x_0-1;
y_0=subs(y,t,0);
y_0_eq=y_0-4;

fprintf('步骤二：代入初始表达式值求解常数结果如下：\n');
% 求解常数C1，C2
[c1,c2]=solve(x_0_eq,y_0_eq)

% 将C1，C2由符号变量转化为数值变量
c1=double(c1);
c2=double(c2);

fprintf('步骤三：将C1，C2代入x,y的表达式，最终获得微分方程组的特解结果如下：\n');
% 将C1，C2代入x,y的表达式，获得微分方程组的特解
x_special=subs(x,[C1 C2],[c1 c2])
y_special=subs(y,[C1 C2],[c1 c2])

%% Problem_005（将函数(sin(x))^2展开成x的泰勒级数，取前4项写出展开式）
fprintf('【5】问题五：将函数(sin(x))^2展开成x的泰勒级数，取前4项写出展开式结果如下：\n');
fprintf('\n');

% 函数定义
syms x;
f=(sin(x))^2;

% 方式一：直接利用Taylor展开（取10阶精度截断）
fprintf('【5.1】方式一：直接利用Taylor展开（取10阶精度截断）\n');
f_taylor=taylor(f,x,'Order',10)
pretty(f_taylor) % 直观表达式

% 方式二：调用MuPAD引擎计算展开（取10阶精度截断）
fprintf('【5.2】方式二：调用MuPAD引擎计算展开（取10阶精度截断）\n');
f_MuPAD=evalin(symengine,'series((sin(x))^2,x=0,8)')
pretty(f_MuPAD) % 直观表达式
