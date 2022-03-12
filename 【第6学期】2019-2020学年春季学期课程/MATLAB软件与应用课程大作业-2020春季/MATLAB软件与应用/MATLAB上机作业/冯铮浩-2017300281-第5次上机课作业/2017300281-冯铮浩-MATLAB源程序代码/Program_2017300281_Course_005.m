%% MATLAB软件与应用（第5次上机MATLAB程序源代码）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月22日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format short
fprintf('MATLAB软件与应用（第5次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月22日\n');
fprintf('\n');
fprintf('部分程序运行结果如下：\n');
fprintf('\n');

%% Problem_001（分别用逆矩阵法和LU分解法求解线性方程组）
fprintf('【1】问题一的两种方法求解线性方程组结果如下：\n');
fprintf('\n');
% 根据题目要求构建系数与常数矩阵，将线性方程组化为Ax=B的形式
A=[1,4,-2,2
   2,1,-4,1
   5,2,-1,-1
   -1,3,-2,3];
b=[10;5;21;1];

% 方法一：利用逆矩阵法求解线性方程组
fprintf('方法一：利用逆矩阵法求解线性方程组：\n');
fprintf('\n');
fprintf('结果x1如下：\n');
x1=inv(A)*b;
x1

% 方法二：利用LU分解法求解线性方程组（分解A=LU，先解Ly=b，再解Ux=y即可）
fprintf('方法二：利用LU分解法求解线性方程组：\n');
fprintf('\n');
fprintf('利用LU分解法求解线性方程组对系数矩阵A进行三角分解如下：\n');
[L,U]=lu(A) % 对系数矩阵A进行LU分解
fprintf('结果x2如下：\n');
y=L\b; % 先求解线性方程组Ly=b
x2=U\y; % 在求解线性方程组Ux=y
x2

% 两种方法求解结果比较
fprintf('两种方法求解线性方程组结果一致。\n');
fprintf('\n');

%% Problem_002（分别采用solve、roots求解非线性方程x^4-3x^3+2x^2-2x+5=0）
fprintf('【2】问题二的两种方法求解非线性方程结果如下：\n');
fprintf('\n');

% 方法一：利用solve指令（高版本MATLAB，可使用vpasolve指令）求解非线性方程
fprintf('方法一：利用solve指令（高版本MATLAB，可使用vpasolve指令）求解非线性方程：\n');
fprintf('\n');
fprintf('结果s1如下：\n');
syms x;
s1=vpasolve(x^4-3*x^3+2*x^2-2*x+5==0);
% 将符号矩阵转化为数值矩阵
s1=double(s1)

% 方法二：利用roots指令求解非线性方程
fprintf('方法二：利用roots指令求解非线性方程：\n');
fprintf('\n');
fprintf('结果s2如下：\n');
p=[1,-3,2,-2,5]; % 定义非线性方程系数矩阵
s2=roots(p);
s2

% 两种方法求解结果比较
fprintf('两种方法求解线性方程组结果一致。\n');
fprintf('\n');

%% Problem_003（二元样条插值、双三次插值操作）
% 导入原始节点坐标数据，并生成二维网格面
x=-3:0.5:3;
y=x;
[X,Y]=meshgrid(x,y);
Z=7-(3.*(X.^3).*exp(-(X.^2)-(Y.^2)));

% 方法一：对给定x,y区间节点进行二元样条插值
xi=-3.9:0.5:5;
yi=-4.9:0.5:4.5;
[Xi,Yi]=meshgrid(xi,yi);
Zi_spline=interp2(X,Y,Z,Xi,Yi,'spline');

% 方法二：对给定x,y区间节点进行双三次插值
Zi_cubic=interp2(X,Y,Z,Xi,Yi,'cubic');

% 方法三：对给定x,y区间节点进行修改的Akima立方Hermite插值
Zi_makima=interp2(X,Y,Z,Xi,Yi,'makima');

% 插值结果可视化
% 绘制原始数据网格面
subplot(2,2,1);
surf(X,Y,Z);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.1: 原始数据网格面');
% 绘制二元样条插值网格面
subplot(2,2,2);
surf(Xi,Yi,Zi_spline);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.2: 二元样条插值网格面（有外插部分）');
% 绘制双三次插值网格面
subplot(2,2,3);
surf(Xi,Yi,Zi_cubic);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.3: 双三次插值网格面（无外插部分）');
% 绘制修改的Akima立方Hermite插值网格面
subplot(2,2,4);
surf(Xi,Yi,Zi_makima);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.4: Makima插值网格面（有外插部分）');

% 关于双三次插值网格外插节点出现NaN的原因分析
fprintf('【3】问题三的两种插值方法图形可视化结果在图窗 Figure 1 中可见：\n');
fprintf('\n');
fprintf('关于双三次方法（cubic）插值网格外插节点出现NaN的原因分析：\n');
fprintf('在 help Document 中，有关interp2的外插功能说明如下：\n')
fprintf('\n');
fprintf('Vq = interp2(___,method,extrapval) also specifies extrapval, a scalar value that is assigned to all queries that lie outside the domain of the sample points.\n');
fprintf('If you omit the extrapval argument for queries outside the domain of the sample points, then based on the method argument interp2 returns one of the following:\n');
fprintf('Extrapolated values for the "spline" and "makima" methods\n');
fprintf('NaN values for other interpolation methods\n');
fprintf('\n');
fprintf('可见，interp2的外插功能仅限于二元样条插值（spline）与修改的Akima立方Hermite插值（makima），\n');
fprintf('其余插值方法不支持二维外插节点。\n');
fprintf('\n');

%% Problem_004（分别使用2~5次多项式对一组数据进行多项式拟合，绘制出拟合曲线，并分别计算拟合误差）
fprintf('【4】问题四中2~5次多项式拟合曲线结果在图窗 Figure 2 中可见：\n');
fprintf('\n');
% 导入原始数据
x=[-1,-0.96,-0.62,0.1,0.4,1];
y=[-1,-0.1512,0.386,0.4802,0.8838,1];

% 定义新的x坐标区间与步长
x_new=-1:0.001:1;

% 进行多项式曲线拟合，并求解各阶次多项式系数
a_2=polyfit(x,y,2); % 2次多项式拟合
a_3=polyfit(x,y,3); % 3次多项式拟合
a_4=polyfit(x,y,4); % 4次多项式拟合
a_5=polyfit(x,y,5); % 5次多项式拟合

% 分别计算各阶次多项式拟合数据结果
y_2=polyval(a_2,x_new);  % 2次多项式拟合结果
y_3=polyval(a_3,x_new);  % 3次多项式拟合结果
y_4=polyval(a_4,x_new);  % 4次多项式拟合结果
y_5=polyval(a_5,x_new);  % 5次多项式拟合结果

% 绘制出各阶次多项式拟合曲线（四幅子图）
figure;
% 2次多项式拟合曲线图形可视化
subplot(2,2,1);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_2,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.1: 2次多项式拟合曲线');
grid on;
box on;
hold off;

% 3次多项式拟合曲线图形可视化
subplot(2,2,2);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_3,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.2: 3次多项式拟合曲线');
grid on;
box on;
hold off;

% 4次多项式拟合曲线图形可视化
subplot(2,2,3);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_4,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.3: 4次多项式拟合曲线');
grid on;
box on;
hold off;

% 5次多项式拟合曲线图形可视化
subplot(2,2,4);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_5,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.4: 5次多项式拟合曲线');
grid on;
box on;
hold off;
