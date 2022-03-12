%% 自动控制原理——倒立摆系统建模与控制系统设计
%% 程序初始化
clear all
clf
clc

%% 参数设定（均为国际标准单位）
M=1.096; % 倒立摆小车质量
m=0.109; % 摆球质量，取为个人体重
l=0.25; % 杆长，取为个人身高的60%
I=0.0034; % 摆球转动惯量（相对于圆心）
f=0.1; % 水平地面摩擦系数
g=9.8; % 重力加速度

% M=10; % 倒立摆小车质量
% m=60; % 摆球质量，取为个人体重
% l=1.02; % 杆长，取为个人身高的60%
% I=m*l*l; % 摆球转动惯量（相对于圆心）
% f=0.1; % 水平地面摩擦系数
% g=9.8; % 重力加速度

%% 系统建模
q=(M+m)*(I+(m*l*l))-((m*l)^2);
num=[m*l/q 0 0];
den=[1 (f*(I+m*l*l))/q ((-1)*(m+M)*m*g*l)/q (-1)*f*m*g*l/q 0];
printsys(num,den);

% num=[1 0];
% den=[(2*M+m)*l 2*f*l (-1)*(M+m)*g (-1)*g*f];

%% 控制系统建模
Kp=200;
Ki=8;
Kd=40;
numPID=[Kd Kp Ki];
denPID=[1 0];
num_con=conv(num,denPID);
den_con=polyadd2(conv(denPID,den),conv(numPID,num));

% [num_con,den_con]=feedback(num,den,numPID,denPID);
% printsys(num_con,den_con);

% num_con=[(Kd*m*l)/q (Kp*m*l)/q (Ki*m*l)/q 0 0];
% den_con=[1 (f*(I+m*l*l))/q ((-1)*(m+M)*m*g*l)/q (-1)*f*m*g*l/q 0 0];

%% 系统测试
% 原始倒立摆系统响应测试
t=0:0.0005:5;
impulse(num,den,t);
grid on;
box on;

% 倒立摆控制系统响应测试
figure;
t=0:0.0005:5;
impulse(num_con,den_con,t);
grid on;
box on;

