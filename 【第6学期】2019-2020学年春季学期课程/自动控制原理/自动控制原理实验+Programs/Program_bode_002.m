%% ����ϵͳ����������Ƶ�������ߡ���Bodeͼ
%% �����ʼ��
clear all
clf
clc

%% ����ϵͳ����������Bodeͼ
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

