%% �Զ�����ԭ����Ҫͼ�λ��Ƴ���ģ��
%% �����ʼ��
clear all
clc

%% ģ��1�����ƿ���ϵͳ�ĸ��켣
figure;
zero=[-1.5 -2-1i -2+1i];
pole=[0 -2.5 -0.5-1.5i -0.5+1.5i];
g=zpk(zero,pole,1);
rlocus(g);
axis equal;
grid on;
box on;

%% ģ��2������ϵͳ����������Ƶ�������ߡ���Bodeͼ
figure;
s=tf('s');
sym=2/((2*s+1)*(8*s+1));
nyquist(sym);
% plot([-1i 0],'r.','MarkerSize',10);
axis equal;
grid on;
box on;

%% ģ��3������ϵͳ���������������ߡ���Nyquist����
% figure;
% P=bodeoptions;
% P.Grid='on';
% P.XLim={[0.01 100]};
% P.XLimMode={'manual'};
% num=[48 48];
% den=[0.4 8.05 49 48];
% H=tf(num,den);
% bode(H,P)
% axis equal;

figure;
P=bodeoptions;
P.Grid='on';
P.XLim={[0.01 100]};
P.XLimMode={'manual'};
s=tf('s');
sym=10/(s*(0.5*s+1));
bode(sym,P)

