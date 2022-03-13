%% 绘制控制系统奈奎斯特图（Nyquist）程序
%% 程序初始化
clear all
clf
clc

%% 输入零极点数据
% zero=[];
% pole=[0 -1 1j -1j];
% % 
% % num=[];
% % den=conv([1 0],conv([1 1],[1 1j],[1 -1j]));
% sym_1=tf(10,pole);
% nyquist(sym_1,{0.15 10000});
% 
% % s=tf('s');
% % nyquist(10/(s*(s+1)*(s^2+1)));
% % grid on;
% % box on;

K=10;
d=conv([1 0],conv([1 1],[1 0 1]));
w=[2.00:0.01:2.20];
e=exp(1j*w);
re=real(e);
im=imag(e);
[a,b]=nyquist(K,d,w);
plot(re,im,a,b);
% Gs=tf(K,d);
% nyquist(Gs);
grid on;
box on;
