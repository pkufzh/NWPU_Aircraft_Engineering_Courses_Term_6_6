%% MATLAB软件与应用（第4次上机MATLAB程序源代码：实验内容2）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月15日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format long
fprintf('MATLAB软件与应用（第4次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月15日\n');
fprintf('\n');
fprintf('实验内容2的运行结果如下：\n');
fprintf('\n');

%% Problem_002（实验内容2，计算K值）
%% 方法一：利用for循环语句计算K值
tic; % 开始计时
K1=0;
for i=0:1000000
    K1=K1+(0.2^i);
end
fprintf('方法一：利用for循环语句计算K = %.6f\n',K1);
fprintf('方法一：运行时间为：%.3f（秒）\n',toc);
fprintf('\n');

%% 方法二：利用while循环语句计算K值
tic; % 开始计时
K2=0;
cnt=0;
while (cnt<=1000000)
    K2=K2+(0.2^cnt);
    cnt=cnt+1;
end
fprintf('方法二：利用while循环语句计算K = %.6f\n',K2);
fprintf('方法二：运行时间为：%.3f（秒）\n',toc);
fprintf('\n');

%% 方法三：避免循环的数值、符号计算程序
% 创建0~1000000的矩阵
tic; % 开始计时
Mat=(0:1000000)';
K_Mat=(0.2).^Mat;
K3=sum(K_Mat);
fprintf('方法三：避免循环的数值、符号计算程序计算K = %.6f\n',K3);
fprintf('方法三：运行时间为：%.3f（秒）\n',toc);
fprintf('\n');
%% 三种方法时间效率比较
fprintf('运行时间比较：方法三 < 方法二 < 方法一。\n');
fprintf('\n');
