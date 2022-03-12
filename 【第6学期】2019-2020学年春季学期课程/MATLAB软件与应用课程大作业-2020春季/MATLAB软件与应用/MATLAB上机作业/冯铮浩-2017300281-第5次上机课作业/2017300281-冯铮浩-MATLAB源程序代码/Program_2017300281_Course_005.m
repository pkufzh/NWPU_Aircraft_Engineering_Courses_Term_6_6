%% MATLAB�����Ӧ�ã���5���ϻ�MATLAB����Դ���룩
%% �ڿ���ʦ���ο���ʦ
%% ���������
%% ѧ�ţ�2017300281
%% ѧԺ������ѧԺ
%% ���ʱ�䣺2020��4��22��

%% MATLAB����Դ���루�������ע�ͱ�ע��
% �����ʼ��
clear all
clc
format short
fprintf('MATLAB�����Ӧ�ã���5���ϻ�MATLAB����Դ���룩\n');
fprintf('���������\n');
fprintf('ѧ�ţ�2017300281\n');
fprintf('ѧԺ������ѧԺ\n');
fprintf('���ʱ�䣺2020��4��22��\n');
fprintf('\n');
fprintf('���ֳ������н�����£�\n');
fprintf('\n');

%% Problem_001���ֱ�������󷨺�LU�ֽⷨ������Է����飩
fprintf('��1������һ�����ַ���������Է����������£�\n');
fprintf('\n');
% ������ĿҪ�󹹽�ϵ���볣�����󣬽����Է����黯ΪAx=B����ʽ
A=[1,4,-2,2
   2,1,-4,1
   5,2,-1,-1
   -1,3,-2,3];
b=[10;5;21;1];

% ����һ�����������������Է�����
fprintf('����һ�����������������Է����飺\n');
fprintf('\n');
fprintf('���x1���£�\n');
x1=inv(A)*b;
x1

% ������������LU�ֽⷨ������Է����飨�ֽ�A=LU���Ƚ�Ly=b���ٽ�Ux=y���ɣ�
fprintf('������������LU�ֽⷨ������Է����飺\n');
fprintf('\n');
fprintf('����LU�ֽⷨ������Է������ϵ������A�������Ƿֽ����£�\n');
[L,U]=lu(A) % ��ϵ������A����LU�ֽ�
fprintf('���x2���£�\n');
y=L\b; % ��������Է�����Ly=b
x2=U\y; % ��������Է�����Ux=y
x2

% ���ַ���������Ƚ�
fprintf('���ַ���������Է�������һ�¡�\n');
fprintf('\n');

%% Problem_002���ֱ����solve��roots�������Է���x^4-3x^3+2x^2-2x+5=0��
fprintf('��2������������ַ����������Է��̽�����£�\n');
fprintf('\n');

% ����һ������solveָ��߰汾MATLAB����ʹ��vpasolveָ��������Է���
fprintf('����һ������solveָ��߰汾MATLAB����ʹ��vpasolveָ��������Է��̣�\n');
fprintf('\n');
fprintf('���s1���£�\n');
syms x;
s1=vpasolve(x^4-3*x^3+2*x^2-2*x+5==0);
% �����ž���ת��Ϊ��ֵ����
s1=double(s1)

% ������������rootsָ���������Է���
fprintf('������������rootsָ���������Է��̣�\n');
fprintf('\n');
fprintf('���s2���£�\n');
p=[1,-3,2,-2,5]; % ��������Է���ϵ������
s2=roots(p);
s2

% ���ַ���������Ƚ�
fprintf('���ַ���������Է�������һ�¡�\n');
fprintf('\n');

%% Problem_003����Ԫ������ֵ��˫���β�ֵ������
% ����ԭʼ�ڵ��������ݣ������ɶ�ά������
x=-3:0.5:3;
y=x;
[X,Y]=meshgrid(x,y);
Z=7-(3.*(X.^3).*exp(-(X.^2)-(Y.^2)));

% ����һ���Ը���x,y����ڵ���ж�Ԫ������ֵ
xi=-3.9:0.5:5;
yi=-4.9:0.5:4.5;
[Xi,Yi]=meshgrid(xi,yi);
Zi_spline=interp2(X,Y,Z,Xi,Yi,'spline');

% ���������Ը���x,y����ڵ����˫���β�ֵ
Zi_cubic=interp2(X,Y,Z,Xi,Yi,'cubic');

% ���������Ը���x,y����ڵ�����޸ĵ�Akima����Hermite��ֵ
Zi_makima=interp2(X,Y,Z,Xi,Yi,'makima');

% ��ֵ������ӻ�
% ����ԭʼ����������
subplot(2,2,1);
surf(X,Y,Z);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.1: ԭʼ����������');
% ���ƶ�Ԫ������ֵ������
subplot(2,2,2);
surf(Xi,Yi,Zi_spline);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.2: ��Ԫ������ֵ�����棨����岿�֣�');
% ����˫���β�ֵ������
subplot(2,2,3);
surf(Xi,Yi,Zi_cubic);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.3: ˫���β�ֵ�����棨����岿�֣�');
% �����޸ĵ�Akima����Hermite��ֵ������
subplot(2,2,4);
surf(Xi,Yi,Zi_makima);
grid on;
box on;
xlabel('\itx'),ylabel('\ity'),zlabel('\itz'),title('Figure 3.4: Makima��ֵ�����棨����岿�֣�');

% ����˫���β�ֵ�������ڵ����NaN��ԭ�����
fprintf('��3�������������ֲ�ֵ����ͼ�ο��ӻ������ͼ�� Figure 1 �пɼ���\n');
fprintf('\n');
fprintf('����˫���η�����cubic����ֵ�������ڵ����NaN��ԭ�������\n');
fprintf('�� help Document �У��й�interp2����幦��˵�����£�\n')
fprintf('\n');
fprintf('Vq = interp2(___,method,extrapval) also specifies extrapval, a scalar value that is assigned to all queries that lie outside the domain of the sample points.\n');
fprintf('If you omit the extrapval argument for queries outside the domain of the sample points, then based on the method argument interp2 returns one of the following:\n');
fprintf('Extrapolated values for the "spline" and "makima" methods\n');
fprintf('NaN values for other interpolation methods\n');
fprintf('\n');
fprintf('�ɼ���interp2����幦�ܽ����ڶ�Ԫ������ֵ��spline�����޸ĵ�Akima����Hermite��ֵ��makima����\n');
fprintf('�����ֵ������֧�ֶ�ά���ڵ㡣\n');
fprintf('\n');

%% Problem_004���ֱ�ʹ��2~5�ζ���ʽ��һ�����ݽ��ж���ʽ��ϣ����Ƴ�������ߣ����ֱ���������
fprintf('��4����������2~5�ζ���ʽ������߽����ͼ�� Figure 2 �пɼ���\n');
fprintf('\n');
% ����ԭʼ����
x=[-1,-0.96,-0.62,0.1,0.4,1];
y=[-1,-0.1512,0.386,0.4802,0.8838,1];

% �����µ�x���������벽��
x_new=-1:0.001:1;

% ���ж���ʽ������ϣ��������״ζ���ʽϵ��
a_2=polyfit(x,y,2); % 2�ζ���ʽ���
a_3=polyfit(x,y,3); % 3�ζ���ʽ���
a_4=polyfit(x,y,4); % 4�ζ���ʽ���
a_5=polyfit(x,y,5); % 5�ζ���ʽ���

% �ֱ������״ζ���ʽ������ݽ��
y_2=polyval(a_2,x_new);  % 2�ζ���ʽ��Ͻ��
y_3=polyval(a_3,x_new);  % 3�ζ���ʽ��Ͻ��
y_4=polyval(a_4,x_new);  % 4�ζ���ʽ��Ͻ��
y_5=polyval(a_5,x_new);  % 5�ζ���ʽ��Ͻ��

% ���Ƴ����״ζ���ʽ������ߣ��ķ���ͼ��
figure;
% 2�ζ���ʽ�������ͼ�ο��ӻ�
subplot(2,2,1);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_2,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.1: 2�ζ���ʽ�������');
grid on;
box on;
hold off;

% 3�ζ���ʽ�������ͼ�ο��ӻ�
subplot(2,2,2);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_3,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.2: 3�ζ���ʽ�������');
grid on;
box on;
hold off;

% 4�ζ���ʽ�������ͼ�ο��ӻ�
subplot(2,2,3);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_4,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.3: 4�ζ���ʽ�������');
grid on;
box on;
hold off;

% 5�ζ���ʽ�������ͼ�ο��ӻ�
subplot(2,2,4);
hold on;
plot(x,y,'ro','MarkerSize',5,'MarkerFaceColor',[1 0 0]);
plot(x_new,y_5,'b-','LineWidth',2);
xlabel('\itx'),ylabel('\ity'),title('Figure 4.4: 5�ζ���ʽ�������');
grid on;
box on;
hold off;
