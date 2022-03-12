%% MATLAB软件与应用（第1次上机MATLAB程序源代码）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月7日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc

%% Problem_001（熟悉MATLAB的基本命令）
%% i.工作空间管理（说明+举例）

% 定义演示程序变量
a=0.4; % a为一个1*1的Double变量
b='cfd'; % b为一个有3个字符的字符串变量
c={{1},{'China'}}; % c为一个有两个存储空间的元胞数组

who % 按字母顺序列出当前活动工作区中的所有变量的名称，即输出a,b,c

whos % 按字母顺序列出当前活动工作区中的所有变量的名称、大小和类型
     % 即输出变量a,b,c的名称、大小、所占内存、类型

clear a % 从工作区中删除项目、释放系统内存，此处即删除a变量并释放内存

% which函数 显示函数或文件的完整路径。
which('Program_2017300281_Course_001.m');  % 显示自编.m文件的完整路径
which('sin') % 显示软件自带系统三角函数sin的完整路径

% quit函数 终止 MATLAB 程序并退出。quit 函数不会自动保存工作区。

%% ii.路径编辑（函数说明）
% path函数 查看或更改搜索路径

% cd函数 更改当前文件夹

% addpath函数 向搜索路径中添加文件夹

% rmpath(folderName)函数 从搜索路径中删除文件夹

%% iii.显示格式（举例+说明）
format long % 定义命令行窗口输出显示格式为 long （15位定点表示），默认为short

format short e % 定义命令行窗口输出显示格式为 short e （5位定点表示）

format short g % 定义命令行窗口输出显示格式为 short g （系统选择5位定点和5位浮点中更好的表示）

format long g % 定义命令行窗口输出显示格式为 long g （系统选择15位定点和15位浮点中更好的表示）

format hex % 定义命令行窗口输出显示格式为 hex （十六进制的表示）

format rat % 定义命令行窗口输出显示格式为 rat （近似的有理数的表示）

format long

%% iv.窗口清理（函数说明）
clc % 清空命令行窗口

cla % 清除坐标区，从当前坐标区删除包含可见句柄的所有图形对象

clf % 清空当前图窗窗口

% close 删除指定图窗

%% v.操作系统命令（函数说明）
% copyfile source 该函数将文件或文件夹 source 复制到当前文件夹中。

% pwd函数 确定当前文件夹

%% vi.熟悉MATLAB的联机帮助命令（函数说明）
% help name 查看命令行窗口中函数的帮助

% helpwin 提供对所有函数的帮助注释的访问权限

% what 函数 列出文件夹中的 MATLAB 文件名称

% ver 查看MathWorks 产品的版本信息

%% Problem_002（熟悉常用命令窗口操作）
clear all
clc

% 个人信息
fprintf('MATLAB软件与应用（第1次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月7日\n');
fprintf('\n');
fprintf('部分程序运行结果如下：\n');
fprintf('\n');

fprintf('【2】第二问：两个幻方矩阵如下：\n');
Problem_2_ans_001=magic(4) % 利用magic函数生成4*4的幻方矩阵
Problem_2_ans_002=magic(6) % 可在命令窗口利用方向键将上条指令调出，在行内编辑，将其改成6阶魔术矩阵命令
fprintf('\n');

%% Problem_003（绘制函数y=tcos(t)在t[0,2pi]内的曲线）
clf
t=0:pi/60:(2*pi);
y=t.*cos(t);
plot(t,y,'r-','LineWidth',2);
xlabel('\itCoordinate t'),ylabel('\itCoordinate y'),title('问题三：绘制函数y=tcos(t)在[0,2\pi]内的曲线');
grid on
box on

%% Problem_004（选择适当的坐标范围，绘制函数f(x,y)=(x^2+y)*e^((-x^2-y^2)/2)）的三维曲线、网格曲面与光滑曲面）
% 创建 Problem_004_001 绘制三维曲线图层
figure;
X1=-3:0.05:3;
Y1=-6:0.10:6; % 绘制三维曲线，需要保证X,Y的元素个数相同
F1=(X1.^2+Y1).*exp((-X1.^2)-((Y1.^2)./2));
plot3(X1,Y1,F1,'b-','LineWidth',2); % 绘制三维曲线
view([-137.588411214953 22.592056205884]); % 调节三维视图参考点
xlabel('\itCoordinate x'),ylabel('\itCoordinate y'),zlabel('\itCoordinate f(x,y)');
title('问题四绘图一：绘制函数f(x,y)=(x^2+y)*exp(-x^2-(y^2/2))的三维曲线');
grid on
box on

% 创建 Problem_004_002 绘制三维网格曲面图层
figure;
x=-4:0.05:4;
y=-5:0.05:5;
[X2,Y2]=meshgrid(x,y);
F2=(X2.^2+Y2).*exp((-X2.^2)-((Y2.^2)./2));
mesh(X2,Y2,F2); % 绘制三维曲面
xlabel('\itCoordinate x'),ylabel('\itCoordinate y'),zlabel('\itCoordinate f(x,y)');
title('问题四绘图二：绘制函数f(x,y)=(x^2+y)*exp(-x^2-(y^2/2))的三维网格曲面');
grid on
box on

% 创建 Problem_004_002 绘制三维光滑曲面图层
figure;
surf(X2,Y2,F2); % 绘制三维曲面
shading interp; % 去除网格显示
colormap('spring'); % 调整色彩为‘春天’
xlabel('\itCoordinate x'),ylabel('\itCoordinate y'),zlabel('\itCoordinate f(x,y)');
title('问题四绘图三：绘制函数f(x,y)=(x^2+y)*exp(-x^2-(y^2/2))的三维光滑曲面');
grid on
box on

%% Problem_005
%% Problem_005_001（熟悉MATLAB的集成视窗环境、窗口及使用方法）
%% Problem_005_002（计算T）
% 定义运算变量
A=1.2;
B=-4.6;
C=8.0;
D=3.5;
E=-4.0;

fprintf('【5.2】第五问第二小问：计算T的值如下：\n');
T=atan(((2*pi*A)+(E/(2*pi*B*C)))/D) % 计算 T = 1.137069651630844（rad）
fprintf('\n');

%% Problem_005_003（计算表达式）
x=45*(pi/180); % 需要注意，MATLAB中所有三角函数运算的单位为弧度，应提前转换
fprintf('【5.3】第五问第三小问：计算表达式的值如下：\n');
Problem_005_003=(sin(x)+sqrt(35))/(72^(1/5))  % 计算表达式 = 2.815791472102042
fprintf('\n');

%% Problem_005_004（计算表达式）
% 定义运算变量
a=5.67;
b=7.811;

fprintf('【5.4】第五问第四小问：计算表达式的值如下：\n');
Problem_005_004=exp(a+b)/log10(a+b)  % 计算表达式 = 6.335082610738692e+05
fprintf('\n');

%% Problem_005_005（计算表达式在x=3时的值）
syms x % 定义符号变量x
y=sqrt(x)-6*(x+(1/x))+(((x-3.2)^2)/((x+7.7)^3)); % 定义y关于x的表达式
fprintf('【5.5】第五问第五小问：当x=3时，计算表达式y的值如下：\n');
Problem_005_005=double(subs(y,x,3))  % 计算表达式 = -18.267916540516048
fprintf('\n');

%% Problem_005_006（已知圆的半径为15，求其直径，周长和面积）
r=15; % 导入圆的半径数据信息
fprintf('【5.6】第五问第六小问：已知圆的半径为15，求其直径，周长和面积如下：\n');
D=2*r  % 计算圆的直径 D = 30
L=pi*D % 计算圆的周长 L = 94.247779607693786
S=pi*(r^2) % % 计算圆的面积 S = 7.068583470577034e+02
fprintf('\n');

%% Problem_005_007（已知某三角形的三个边的边长分别为8.5,14.6,18.4，求该三角形的面积）
% 利用海伦-秦九韶公式计算三角形面积
% 导入三角形三边边长
la=8.5;
lb=14.6;
lc=18.4;

% 计算三角形半周长
s=(la+lb+lc)/2;

% 计算三角形面积
fprintf('【5.7】第五问第七小问：已知三角形三边边长为8.5,14.6,18.4，求解三角形面积如下：\n');
S_Tri_Area=sqrt(s*(s-la)*(s-lb)*(s-lc))
