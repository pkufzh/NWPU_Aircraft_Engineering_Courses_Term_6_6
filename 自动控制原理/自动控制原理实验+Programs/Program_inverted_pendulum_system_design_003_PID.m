%% �Զ�����ԭ����������ϵͳ��ģ�����ϵͳ���
%% �����ʼ��
clear all
clf
clc

%% �����趨����Ϊ���ʱ�׼��λ��
M=1.096; % ������С������
m=0.109; % ����������ȡΪ��������
l=0.25; % �˳���ȡΪ������ߵ�60%
I=0.0034; % ����ת�������������Բ�ģ�
f=0.1; % ˮƽ����Ħ��ϵ��
g=9.8; % �������ٶ�

% M=10; % ������С������
% m=60; % ����������ȡΪ��������
% l=1.02; % �˳���ȡΪ������ߵ�60%
% I=m*l*l; % ����ת�������������Բ�ģ�
% f=0.1; % ˮƽ����Ħ��ϵ��
% g=9.8; % �������ٶ�

%% ϵͳ��ģ
q=(M+m)*(I+(m*l*l))-((m*l)^2);
num=[m*l/q 0 0];
den=[1 (f*(I+m*l*l))/q ((-1)*(m+M)*m*g*l)/q (-1)*f*m*g*l/q 0];
printsys(num,den);

% num=[1 0];
% den=[(2*M+m)*l 2*f*l (-1)*(M+m)*g (-1)*g*f];

%% ����ϵͳ��ģ
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

%% ϵͳ����
% ԭʼ������ϵͳ��Ӧ����
t=0:0.0005:5;
impulse(num,den,t);
grid on;
box on;

% �����ڿ���ϵͳ��Ӧ����
figure;
t=0:0.0005:5;
impulse(num_con,den_con,t);
grid on;
box on;

