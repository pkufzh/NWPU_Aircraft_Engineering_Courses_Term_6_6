%% ���Ʒ�������ϵͳ���켣����
%% �����ʼ��
clear all
clf
clc

%% �����㼫������
% zero=[-1.5,-2-1i,-2+1i];
% pole=[0,-2.5,-0.5+1i*1.5,-0.5-1i*1.5];
% s=tf('s');
% rlocus(1/((s^2)*(s+2)));
% grid on;
% box on;
% 
% figure;
% s=tf('s');
% rlocus((s+3)/((s^2)*(s+2)));
% grid on;
% box on;
% 
% figure;
% s=tf('s');
% rlocus((s+1)/((s^2)*(s+2)));
% grid on;
% box on;

figure;
s=tf('s');
rlocus(1/(0.05*(s^3)+0.6*(s^2)+s));
grid on;
box on;
