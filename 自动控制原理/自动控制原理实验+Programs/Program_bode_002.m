%% 绘制系统开环对数幅频特性曲线——Bode图
%% 程序初始化
clear all
clf
clc

%% 导入系统参数，绘制Bode图
% num=[200];
% den=[10 11 1 0 0];
% H=tf(num,den);
% bode(H);
% grid on;

P=bodeoptions;
P.Grid='on';
P.XLim={[0.01 100]};
P.XLimMode={'manual'};
num=[48 48];
den=[0.4 8.05 49 48];
H=tf(num,den);
bode(H,P)

