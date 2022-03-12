%% 绘制反馈控制系统根轨迹程序
%% 程序初始化
clear all
clf
clc

%% 输入零极点数据
% zero=[-1.5,-2-1i,-2+1i];
% pole=[0,-2.5,-0.5+1i*1.5,-0.5-1i*1.5];
zero=[];
pole=[0,0,-2];
g=zpk(zero,pole,1);
rlocus(g);
grid on;
box on;
