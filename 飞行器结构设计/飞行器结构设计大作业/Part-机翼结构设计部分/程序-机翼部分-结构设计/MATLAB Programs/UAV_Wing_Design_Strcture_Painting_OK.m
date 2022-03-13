%% ����ṹ��Ƴ���Ԫ�����ã�MATLABͼ�ο��ӻ���
%% �����ʼ��
clear all
clf
clc

%% ��������γߴ����ݣ���λ��mm��
e=1000; % ���ű���
b=30574/e; % ��չ����
bh=b/2; % ����չ����
cr=2348/e; % ���ҳ���
ct=904/e; % ���ҳ���
cj=250/e;
theta=(cr-ct)/bh;

%% ���ƻ����������ǰ��Ե
hold on;
h_cr=plot([0,0],[0,cr],'-g','LineWidth',1.8); % �������
h_ct=plot([bh,bh],[ct,cr],'-g','LineWidth',1.8); % ��������
h_rear=plot([0,bh],[cr,cr],'-g','LineWidth',1.8); % �����Ե
h_front=plot([0,bh],[0,ct],'-g','LineWidth',1.8); % ����ǰԵ

%% ��������Ԫ����������
% ������������
n_spar=4;
n_spar_vir=n_spar+2;

% ���Է�����������
Cx=linspace(0,0,n_spar_vir);
Cy=linspace(0,cr-cj,n_spar_vir);
Dx=linspace(bh,bh,n_spar_vir);
Dy=linspace(ct,cr,n_spar_vir);

% ɾȥǰԵ�ͺ�Ե��������
Cx(1)=[];Cx(n_spar+1)=[];Cy(1)=[];Cy(n_spar+1)=[];
Dx(1)=[];Dx(n_spar+1)=[];Dy(1)=[];Dy(n_spar+1)=[];
X_spar=[Cx;Dx];
Y_spar=[Cy;Dy];
h_spar=plot(X_spar,Y_spar,'-r','LineWidth',1.5);

%% ���ƺ���Ԫ�������ߣ�
% ȷ����ǿ��λ�ã�2#��3#��
Ax_2=0.8153;
Ay_2=cr;
Bx_2=0.8153;
By_2=theta*Bx_2;
% Ax_3=2.2420933;
% Ay_3=cr;
% Bx_3=2.2420933;
% By_3=theta*Bx_3;
Ax_3=2.8420;
Ay_3=cr;
Bx_3=2.8420;
By_3=theta*Bx_3;

plot([Ax_2,Bx_2],[Ay_2,By_2],'-','LineWidth',1,'Color',[0 0 1]);
plot([Ax_3,Bx_3],[Ay_3,By_3],'-','LineWidth',1,'Color',[0 0 1]);

% ����������һ�ࣩ����
n_rib=6;
n_rib_vir=n_rib+2;

% ���Է�����������
Ax=linspace(Bx_3,bh,n_rib_vir);
Ay=linspace(cr,cr,n_rib_vir);
Bx=linspace(Bx_3,bh,n_rib_vir);
By=linspace(By_3,ct,n_rib_vir);

% ɾȥ��һ�������һ������
% Ax(1)=[];Ax(n_rib+1)=[];Ay(1)=[];Ay(n_rib+1)=[];
% Bx(1)=[];Bx(n_rib+1)=[];By(1)=[];By(n_rib+1)=[];
X_rib=[Ax;Bx];
Y_rib=[Ay;By];
h_rib=plot(X_rib,Y_rib,'-','LineWidth',1,'Color',[0 0 1]);

%% ��������������
axis equal;
grid on;
box on;
xlabel('չ�򳤶ȣ�m��'),ylabel('���򳤶ȣ�m��');

%% ���ò���ͼ��
legend([h_cr,h_spar(1),h_rib(1)],'����Ե����','��������','��������');
