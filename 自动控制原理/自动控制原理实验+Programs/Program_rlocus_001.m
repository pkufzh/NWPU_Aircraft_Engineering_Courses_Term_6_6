%% ���Ʒ�������ϵͳ���켣����
%% �����ʼ��
clear all
clf
clc

%% �����㼫������
% zero=[-1.5,-2-1i,-2+1i];
% pole=[0,-2.5,-0.5+1i*1.5,-0.5-1i*1.5];
zero=[];
pole=[0,0,-2];
g=zpk(zero,pole,1);
rlocus(g);
grid on;
box on;
