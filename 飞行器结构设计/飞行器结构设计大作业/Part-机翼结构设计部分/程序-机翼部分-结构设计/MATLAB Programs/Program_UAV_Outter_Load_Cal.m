%% �������س�����㣨������Բ�ηֲ������ƣ�����վλ�ɼ���ϸ�֣�
%% �������ֲ��㷨����Բ�ֲ��㷨����չ�ұȷɻ���
%% �����ʼ��
clear all
clf
clc

%% UAV��������趨
% �����ߴ���Ϣ
Mmax=10394; % ����������
Mh=Mmax/2; % ������������һ�루���Ե���������������㣩
Mw=1160; % ������������
bt=35.42; % ��չ����
bth=bt/2; % ����չ����
c_mean=1.42; % ƽ�������ҳ�

% ������Ϣ
nmax=3.048; % ����غ�ϵ��
nmin=-1.088; % ��С�غ�ϵ��
f=1.5; % ��ȫϵ��
g=9.8; % �������ٶ�

% �������Բ���
xac=0.241242799; % ���������λ��
xcg=0.45; % �����������λ��
xz=0.5; % ������λ��

%% ����ģ��1��չ���������ֲ����㣨���ù�ʽ������
n_rib=20; % չ��վλ����
x=linspace(0,bth,n_rib);
z_upper=(nmax*1.5*2*Mh*g)*(sqrt(bth^2-x.^2)/(pi*bth^2)); % ���ù�ʽ������������nmax����µ������ֲ�
z_lower=(nmin*1.5*2*Mh*g)*(sqrt(bth^2-x.^2)/(pi*bth^2)); % ���ù�ʽ�����󸺹���nmin����µ������ֲ�

% ����˫����������������ֲ�ͼ��
hl=plotyy(x,z_upper,x,z_lower);

% ��������������
xlabel('����չ��λ�ã�m��'),ylabel('������ֵ��N��'),title('����չ���������ֲ����㣨���ù�ʽ������ϣ�');
xticks(0:3:17.71); 
yticks(0:2000:20000);
grid on
box on

%% ����ģ��2��3������չ�����Q�����M�ֲ����㣨���ù�ʽ������
% ģ���ʼ��
syms x; % ���û��ַ��ű���x
cnt=0; % ����������
A_y=zeros(1,n_rib); % ���������չ��վλ����Fyֵ
A_m=zeros(1,n_rib); % ���������չ��վλ���Mzֵ

% �Ը�վλ����Q�����M���м���
for t=0:(bth/n_rib):bth
    z=2*(Mh-Mw)*g*sqrt(bth^2-x.^2)/(pi*bth^2);
    y=int(z,x,bth,t);
    m=int(y,x,bth,t);
    p_q=double(y);
    p_m=double(m);
    cnt=cnt+1;
    A_y(cnt)=p_q;
    A_m(cnt)=p_m;
end

% ���ƻ���չ������ֲ�ͼ������״ͼ
figure;
t=0:(bth/n_rib):bth;
hold on
plot(t,A_y,'r-','LineWidth',2);
bar(t,A_y);
xlabel('����չ��λ�ã�m��'),ylabel('����չ�����ֵ��N��'),title('����չ������ֲ����㣨���ù�ʽ������ϣ�');
grid on
box on

% ���ƻ���չ����طֲ�ͼ������״ͼ
figure;
t=0:(bth/n_rib):bth;
hold on
plot(t,A_m,'b-','LineWidth',2);
bar(t,A_m);
xlabel('����չ��λ�ã�m��'),ylabel('����չ�����ֵ��N*m��'),title('����չ����طֲ����㣨���ù�ʽ������ϣ�');
grid on
box on

%% ����ģ��4������չ��Ť��Mt�ֲ����㣨���ù�ʽ������
syms x;
cnt=0;
A_mt=zeros(1,n_rib);
for t=0:(bth/n_rib):bth
    n=(0.31*2*Mh*g*sqrt(17.7^2-x.^2)/(pi*(bth^2)))-(0.24*2*Mw*g*sqrt((bth^2)-x.^2)/(pi*(bth^2)));
    q=int(n,x,bth,t);
    p_mt=double(q);
    cnt=cnt+1;
    A_mt(cnt)=p_mt;
end

% ���ƻ���չ��Ť�طֲ�ͼ������״ͼ
figure;
t=0:(bth/n_rib):bth;
hold on
plot(t,A_mt,'m-','LineWidth',2);
bar(t,A_mt);
xlabel('����չ��λ�ã�m��'),ylabel('����չ��Ť��ֵ��N*m��'),title('����չ��Ť�طֲ����㣨���ù�ʽ������ϣ�');
grid on
box on
