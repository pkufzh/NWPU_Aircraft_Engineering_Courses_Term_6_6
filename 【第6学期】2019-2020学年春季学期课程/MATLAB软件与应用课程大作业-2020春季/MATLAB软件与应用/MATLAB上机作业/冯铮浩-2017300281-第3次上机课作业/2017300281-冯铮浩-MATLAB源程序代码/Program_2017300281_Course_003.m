%% MATLAB�����Ӧ�ã���3���ϻ�MATLAB����Դ���룩
%% �ڿ���ʦ���ο���ʦ
%% ���������
%% ѧ�ţ�2017300281
%% ѧԺ������ѧԺ
%% ���ʱ�䣺2020��4��14��

%% MATLAB����Դ���루�������ע�ͱ�ע��
% �����ʼ��
clear all
clc
format short
fprintf('MATLAB�����Ӧ�ã���3���ϻ�MATLAB����Դ���룩\n');
fprintf('���������\n');
fprintf('ѧ�ţ�2017300281\n');
fprintf('ѧԺ������ѧԺ\n');
fprintf('���ʱ�䣺2020��4��14��\n');
fprintf('\n');
fprintf('���ֳ������н�����£�\n');
fprintf('\n');

%% Problem_001���ú�ɫ�㻭�߷�ʽ����y=sin(x)+cos(10x)��[-pi,pi�ϵ�����]�����Ժ���Ϊ���⣩
figure; % ����һ���µ�ͼ��
x=-pi:(pi/60):pi;
y=sin(x)+cos(10*x);
plot(x,y,'r-.','LineWidth',2); % ��������
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),title('Figure 1: y=sin(x)+cos(10x),x=[-\pi,\pi]');
grid on;
box on;

%% Problem_002���ö���ͼ��ʽ�ֱ��������y1=sin(x+1),y2=e^(2x),y3=y1+y2��[0,5*pi]�ϵ����ߣ�
x=0:(pi/60):(5*pi);
y1=sin(x+1);
y2=exp(2*x);
y3=y1+y2;
% ���δ���������ͼ
figure;
subplot(3,1,1),plot(x,y1,'r-','LineWidth',2),xlabel('Coordinate \itx'),ylabel('Coordinate \ity1'),title('Figure 2.1: y1=sin(x+1),x=[0,5\pi]');
subplot(3,1,2),plot(x,y2,'b-','LineWidth',2),xlabel('Coordinate \itx'),ylabel('Coordinate \ity2'),title('Figure 2.2: y2=e^{2x},x=[0,5\pi]');
subplot(3,1,3),plot(x,y3,'m-','LineWidth',2),xlabel('Coordinate \itx'),ylabel('Coordinate \ity3'),title('Figure 2.3: y3=y1+y2=sin(x+1)+e^{2x},x=[0,5\pi]');

%% Problem_003�����ö�ͼ���淽ʽ�ֱ������������y1=sin(x+1)����������y2=cos(x)+1������[0,2*pi]�ϵ����ߣ�
x=0:(pi/60):(2*pi);
y1=sin(x+1);
y2=cos(x)+1;
% ���ö�ͼ����ķ�ʽ����
figure;
hold on; % ��������ģʽ
plot(x,y1,'r-','LineWidth',2);
plot(x,y2,'g--','LineWidth',2);
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),title('Figure 3: ��ͼ�������ʾ��ͼ')
legend('��������','��������','Location','Best');
grid on;
box on;

%% Problem_004���ֱ�����״ͼ�ͱ�״ͼ�ķ�ʽ���Ƴ���רҵѧ����״̬�ı�����
% ��������
stu_tot=120; % ��רҵ����ѧ��������
% type=['����ѧ��';'����ѧ��';'����ѧ��';'��ҵѧ��';'����ѧ��'];
type=1:5;
stu_each=[18,12,72,6,12];
figure;
subplot(2,1,1);bar(type,stu_each); % ������״ͼ
set(gca,'XTickLabel',{'����ѧ��','����ѧ��','����ѧ��','��ҵѧ��','����ѧ��'});
title('Figure 4.1: ��רҵѧ����״̬�ı�����״ͼ');
subplot(2,1,2);pie(stu_each,[1 1 1 1 1]); % ���Ʊ�״ͼ
title('Figure 4.2: ��רҵѧ����״̬�ı�����״ͼ');
legend({'����ѧ��','����ѧ��','����ѧ��','��ҵѧ��','����ѧ��'},'Location','Best');

%% Problem_005��������ά���ߣ�
t=1:0.05:10;
x=3*t.*sin(t);
y=3*t.*cos(t);
z=t;
figure;
plot3(x,y,z,'r-','LineWidth',2);
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),zlabel('Coordinate \itz');
title('Figure 5: ��ά���߻���');
grid on;
box on;

%% Problem_006����XYƽ����ѡ������[0,-6]*[0,-6]���ƶ�ά��˹����z=e^(-((x-3)^2+(y-3)^2))����ά�������棩
x=-6:0.05:6;
y=-6:0.05:6;
[X,Y]=meshgrid(x,y); % ����x,y���ꡰ��㡱����
Z=exp(-(((X-3).^2)+((Y-3).^2)));
figure;
mesh(X,Y,Z); % ���ɶ�ά��˹��������ά��������
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),zlabel('Coordinate \itz');
title('Figure 6: ���ɶ�ά��˹��������ά��������');
grid on;
box on;

%% Problem_007����XYƽ����ѡ������[-6,+6]*[-6,+6]���ƶ�ά��˹����z=sin((x^2+y^2)^(1/2))/((x^2+y^2)^(1/2))����ά�������棩
x=-6:0.2:6;
y=-6:0.2:6;
[X,Y]=meshgrid(x,y); % ����x,y���ꡰ��㡱����
Z=(sin(sqrt((X.^2)+(Y.^2))))./(sqrt((X.^2)+(Y.^2)));
figure;
surf(X,Y,Z); % ���ɶ�ά��˹��������ά��������
shading interp
xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),zlabel('Coordinate \itz');
title('Figure 7: ���ɺ���z����ά�⻬����');
grid on;
box on;

%% Problem_008����sphere����������������꣬���Ʋ�͸������ͼ��͸������ͼ������ͼ��
% ������ά��������꣬��뾶Ϊ30
[X,Y,Z]=sphere(30);
figure;
subplot(2,2,1);mesh(X,Y,Z);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 8.1: �������岻͸������ͼ');
subplot(2,2,2);mesh(X,Y,Z);hidden off;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 8.2: ��������͸������ͼ');
subplot(2,2,3);surf(X,Y,Z);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 8.3: �����������ͼ');

%% Problem_009������peaks�����ı���ͼ����colormap�����ı�Ԥ�õ�ɫͼ���۲�ɫ�ʵķֲ������
[X,Y,Z]=peaks(30);
figure;
surf(X,Y,Z);colormap('hot');
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 9.1: ����peaks��������ͼ��ɫͼΪůɫɫͼhot');
figure;
surf(X,Y,Z);colormap('cool');
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 9.2: ����peaks��������ͼ��ɫͼΪ��ɫɫͼcool');
figure;
surf(X,Y,Z);colormap('autumn');
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 9.3: ����peaks��������ͼ��ɫͼΪ���ɫͼautumn');

%% Problem_010�����ƹ��մ��������棬ȡ������ͬ�Ĺ���λ�ý��бȽϣ���ʹ�ö���ͼ�ķ�ʽ��
[X,Y,Z]=sphere(30);
figure;
subplot(2,2,1);surf(X,Y,Z);shading interp;
light('position',[2,-2,2]);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 10.1: �������ģʽ��');
subplot(2,2,2);surf(X,Y,Z);shading interp;
light('position',[1,1,1]);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 10.2: �������ģʽ��');
subplot(2,2,3);surf(X,Y,Z);shading interp;
light('position',[0.5,-0.5,2]);
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 10.3: �������ģʽ��');

%% Problem_011��ͼ�ξ��������
t=0:0.05:10;
x=sin(t);
y=cos(t);
z=t;
figure;
fprintf('��11������11��δ�޸�ʱ��Ĭ�ϣ�����ά���߾�����£�\n');
fig_1=plot3(x,y,z) % ��Ĭ�����Ի�����ά���ߣ�����������ֵ��fig���ڹ�������ʾ�����Ϣ
xlabel('\itx'),ylabel('\ity'),zlabel('\itz');
title('Figure 11: ͼ�ξ������ʾ��ͼ');
set(fig_1,'Color',[0,1,0]); % ����ͼ�ξ�����������ߵ���ɫ��Ϊ��ɫ
set(fig_1,'LineStyle','--'); % ����ͼ�ξ���������������͸�Ϊ����
set(fig_1,'LineWidth',2); % ����ͼ�ξ�������������߿�����Ϊ2
fprintf('�޸ĺ����ά���߾�����£�\n');
fig_1 % ��ʾ����ͼ�ξ�������޸ĺ�����߾����Ϣ
fprintf('\n');

%% Problem_012������һ�����ߣ����������������������Ի�ȡ���߾�������޸��������ͣ�
% ����һ�����Һ�������
x=0:(pi/60):(2*pi);
y1=sin(x);y2=cos(x);y3=sin(2*x);
figure;
hold on;
plot(x,y1,'r-','LineWidth',2);
plot(x,y2,'b--','LineWidth',2);
plot(x,y3,'m-.','LineWidth',2);
grid on
box on
hold off
xlabel('Coordinate \itx'),ylabel('Coordinate \ity');
% ���������������������Ի�ȡ���߾��
fig_line=get(gca,'Children'); % ������а������ߵľ������
tot_line=0; % ��¼������������������������������
for k=1:size(fig_line)
    if strcmp((get(fig_line(k),'LineStyle')),'--')==1 % ��������Ϊ���ߵ�����
        tot_line=tot_line+1;
        num_target_line(tot_line)=k; % ��¼�������������������������
        fig_target_line=fig_line(k); % ��������Ŀ�����߾����fig_target_Line
        set(fig_target_line,'LineStyle','-'); % �����fig_target_Line��Ӧ�������ԣ����ߣ��޸�Ϊֱ��
    end
end
title('Figure 12: ����������Ѱ�ҵ�������������������Ϊ���ߵ����ߣ����������޸�Ϊֱ��');
fprintf('��12������12���������������������������������Ϊ���ߵ����߹���%d�������Ϊ��',tot_line);
for i=1:tot_line-1
    fprintf('%d��,',num_target_line(i));
end
fprintf('%d��\n',num_target_line(tot_line));
fprintf('\n');

%% Problem_013����ȡһ��.fig��ʽ��ͼƬ����ȡ���еı������������ݾ���޸ı��⣩
open('Figure 1.fig'); % ��.fig��ʽ��ͼƬ
title_fig=get(gca,'Title');
set(title_fig,'String','Figure 13: ͼƬ�����޸ģ����þ��������'); % ���ݾ���޸ı���
