%% ����ṹ��Ƴ���Ԫ�����ã�MATLABͼ�ο��ӻ���
%% �����ʼ��
clear all
clf
clc

%% ��������γߴ����ݣ���λ��mm��
b=30574; % ��չ����
bh=b/2; % ����չ����
cr=2348; % ���ҳ���
ct=904; % ���ҳ���

%% ���ƻ����������ǰ��Ե
hold on;
h_cr=plot([0,0],[0,cr],'-g','LineWidth',2); % �������
h_ct=plot([bh,bh],[ct,0],'-g','LineWidth',2); % ��������
h_rear=plot([0,bh],[0,0],'-g','LineWidth',2); % �����Ե
h_front=plot([0,bh],[cr,ct],'-g','LineWidth',2); % ����ǰԵ

%% ��������Ԫ����������
% ������������
n_ron=4;
n_ron_vir=n_ron+2;

% ���Է�����������
Cx=linspace(0,0,n_ron_vir);
Cy=linspace(0,cr,n_ron_vir);
Dx=linspace(bh,bh,n_ron_vir);
Dy=linspace(0,ct,n_ron_vir);

% ɾȥǰԵ�ͺ�Ե��������
Cx(1)=[];Cx(n_ron+1)=[];Cy(1)=[];Cy(n_ron+1)=[];
Dx(1)=[];Dx(n_ron+1)=[];Dy(1)=[];Dy(n_ron+1)=[];
X_ron=[Cx;Dx];
Y_ron=[Cy;Dy];
h_ron=plot(X_ron,Y_ron,'-r','LineWidth',2);

%% ���ƺ���Ԫ�������ߣ�
% ����������һ�ࣩ����
n_rib=10;
n_rib_vir=n_rib+2;

% ���Է�����������
Ax=linspace(0,bh,n_rib_vir);
Ay=linspace(0,0,n_rib_vir);
Bx=linspace(0,bh,n_rib_vir);
By=linspace(cr,ct,n_rib_vir);

% ɾȥ��һ�������һ������
Ax(1)=[];Ax(n_rib+1)=[];Ay(1)=[];Ay(n_rib+1)=[];
Bx(1)=[];Bx(n_rib+1)=[];By(1)=[];By(n_rib+1)=[];
X_rib=[Ax;Bx];
Y_rib=[Ay;By];
h_rib=plot(X_rib,Y_rib,'-b','LineWidth',2);

%% ��������������
axis equal;
grid on;
box on;
xlabel('չ�򳤶ȣ�m��'),ylabel('���򳤶ȣ�m��');

%% ���ò���ͼ��
legend([])
