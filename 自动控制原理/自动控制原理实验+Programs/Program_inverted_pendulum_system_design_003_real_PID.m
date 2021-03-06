%% 自动控制原理——倒立摆系统建模与控制系统设计
%% 程序初始化
clear all
clf
clc

%% 参数设定（均为国际标准单位）
M=10; % 倒立摆小车质量
m=60; % 摆球质量，取为个人体重
l=1.02; % 杆长，取为个人身高的60%
I=m*l*l; % 摆球转动惯量（相对于圆心）
f=0.1; % 水平地面摩擦系数
g=9.8; % 重力加速度

%% 系统建模
q=(M+m)*(I+(m*l*l))-((m*l)^2);
num=[m*l/q 0 0];
den=[1 (f*(I+m*l*l))/q ((-1)*(m+M)*m*g*l)/q (-1)*f*m*g*l/q 0];
fprintf('【原始倒立摆系统建模】\n');
fprintf('\n');
fprintf('原始倒立摆系统 输入力F—摆角theta 传递函数G(s)：\n');
printsys(num,den);
fprintf('\n');
r_ori=roots(polyadd2(num,den))
fprintf('\n');

%% PD控制系统建模
fprintf('【倒立摆PD控制系统建模】\n');
fprintf('\n');
Kp=5000;
% Ki=800;
Kd=1000;
numPID=[Kd Kp 0];
denPID=[1 0];

% PD控制系统开环传递函数建模
num_open=conv(num,numPID);
den_open=conv(den,denPID);
fprintf('倒立摆PD控制系统开环传递函数Gc(s)：\n');
printsys(num_open,den_open);
fprintf('\n');
r_con_open=roots(polyadd2(num_open,den_open))
fprintf('\n');

% PD控制系统闭环传递函数建模
num_con=conv(num,denPID);
den_con=polyadd2(conv(denPID,den),conv(numPID,num));
fprintf('倒立摆PD控制系统闭环传递函数Phi(s)：\n');
printsys(num_con,den_con);
fprintf('\n');

%% 绘制控制系统根轨迹（开环传递函数特性）
sys_open=tf(num_open,den_open);
rlocus(sys_open);
title('倒立摆PD控制系统根轨迹图');
grid on;
box on;

%% 绘制控制系统根频率特性曲线（Nyquist图、Bode图）
figure;
nyquist(sys_open); % 绘制Nyquist图
title('倒立摆PD控制系统Nyquist图');
grid on;
box on;

figure;
bode(sys_open); % 绘制Nyquist图
title('倒立摆PD控制系统Bode图');
grid on;
box on;

%% 系统测试（时域分析）
% 原始倒立摆系统单位阶跃输入响应测试
figure;
t=0:0.0005:5;
step(num,den,t);
title('原始倒立摆系统单位阶跃输入响应测试');
grid on;
box on;

% 倒立摆控制系统单位阶跃输入响应测试
figure;
t=0:0.0005:5;
step(num_con,den_con,t);
title('倒立摆PD控制系统单位阶跃输入响应测试');
grid on;
box on;

figure;
sys=tf(num_con,den_con);
KM=f*(M+m)*g;
step(KM*sys,t)

