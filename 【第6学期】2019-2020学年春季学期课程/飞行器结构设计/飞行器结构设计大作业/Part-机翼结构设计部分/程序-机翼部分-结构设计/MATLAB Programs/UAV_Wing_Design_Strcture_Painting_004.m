%% ����ṹ��Ƴ���Ԫ�����ã�MATLABͼ�ο��ӻ���
%% �����ʼ��
clear all
clf
clc

%% ��������γߴ����ݣ���λ��mm��
e=1000; % ���ű���
b=35420/e; % ��չ����
bth=b/2; % ����չ����
cr=1873.3/e; % ���ҳ���
ct=749.3/e; % ���ҳ���
c_mean=1.42; % ƽ�������ҳ�
theta=atan((cr-ct)/bth); % ����ǰԵ���ӽ�

%% ���ƻ����������ǰ��Ե
hold on;
h_cr=plot([0,0],[0,cr],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % �������
h_ct=plot([bth,bth],[(cr-ct),cr],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % ��������
h_rear=plot([0,bth],[cr,cr],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % �����Ե
h_front=plot([0,bth],[0,(cr-ct)],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % ����ǰԵ

%% ���ƺ���Ԫ������ͨ����+��ǿ���ߣ�
% ��������ǿ��λ��
L_str_rib_1=0.05333; % 1#��ǿ����չ��԰���չλ��
L_str_rib_2=0.18591; % 2#��ǿ����չ��԰���չλ��

% ȷ����ǿ��λ�ã�2#��3#��
Ax_2=L_str_rib_1*bth;
Ay_2=cr;
Bx_2=L_str_rib_1*bth;
By_2=theta*Bx_2;
Ax_3=L_str_rib_2*bth;
Ay_3=cr;
Bx_3=L_str_rib_2*bth;
By_3=tan(theta)*Bx_3;

% ���Ƽ�ǿ��λ��
h_str_rib_001=plot([Ax_2,Bx_2],[Ay_2,By_2],'-','LineWidth',1.8,'Color',[1 0 1]);
h_str_rib_002=plot([Ax_3,Bx_3],[Ay_3,By_3],'-','LineWidth',1.8,'Color',[1 0 1]);

% ������ͨ���ߣ�һ�ࣩ����
n_rib=6;
n_rib_vir=n_rib+2;

% ���Է����������ݣ���������ͨ����λ��
Ax=linspace(Bx_3,bth,n_rib_vir);
Ay=linspace(cr,cr,n_rib_vir);
Bx=linspace(Bx_3,bth,n_rib_vir);
By=linspace(By_3,(cr-ct),n_rib_vir);

% ɾȥ��һ�������һ������
Ax(1)=[];Ax(n_rib+1)=[];Ay(1)=[];Ay(n_rib+1)=[];
Bx(1)=[];Bx(n_rib+1)=[];By(1)=[];By(n_rib+1)=[];
X_rib=[Ax;Bx];
Y_rib=[Ay;By];
A_rib_ori=Ax/bth; % �����ʱ3#����n_rib+3��#��ͨ���ߵ���԰���չλ��
h_rib=plot(X_rib,Y_rib,'-','LineWidth',1,'Color',[0 0 1]);

%% ��������Ԫ����������
% ������������
n_spar=4;

% ����������λ��
L_spar_1=0.1787; % 1#����������ҳ�λ��
L_spar_2=0.3574; % 2#����������ҳ�λ��
L_spar_3=0.5361; % 3#����������ҳ�λ��
L_spar_4=0.7148; % 4#����������ҳ�λ��

% ���Է�����������
Cx(1)=0;
Cx(2)=Bx_3;
Cx(3)=Bx_3;
Cx(4)=0;
crr=cr-By_3; % 3#��ǿ�ߵ����ҳ���
Cy(1)=L_spar_1*cr;
Cy(2)=(L_spar_2*crr)+By_3;
Cy(3)=(L_spar_3*crr)+By_3;
Cy(4)=L_spar_4*cr;
Dx=linspace(bth,bth,n_spar);
Dy(1)=L_spar_1*ct;
Dy(2)=L_spar_2*ct;
Dy(3)=L_spar_3*ct;
Dy(4)=L_spar_4*ct;
Dy=Dy+(cr-ct);

% ���������ṹ�ֲ�
h_spar_001=plot([Cx(1),Dx(1)],[Cy(1),Dy(1)],'-r','LineWidth',1.2);
h_spar_002=plot([Cx(2),Dx(2)],[Cy(2),Dy(2)],'-r','LineWidth',1.2);
h_spar_003=plot([Cx(3),Dx(3)],[Cy(3),Dy(3)],'-r','LineWidth',1.2);
h_spar_004=plot([Cx(4),Dx(4)],[Cy(4),Dy(4)],'-r','LineWidth',1.2);

%% ��������ܿ����������֮���ϱ���ĳ���
% ��������������
n_stiff=6;
n_stiff_vir=n_rib+2;

% ���Է�����������
Ex=linspace(0,0,n_stiff_vir);
Ey=linspace(Cy(1),Cy(4),n_stiff_vir);
Fx=linspace(Bx_3,Bx_3,n_stiff_vir);
Fy=linspace(((L_spar_1*crr)+By_3),((L_spar_4*crr)+By_3),n_stiff_vir);

% ɾȥ��һ�������һ������
Ex(1)=[];Ex(n_stiff+1)=[];Ey(1)=[];Ey(n_stiff+1)=[];
Fx(1)=[];Fx(n_stiff+1)=[];Fy(1)=[];Fy(n_stiff+1)=[];
X_stiff=[Ex;Fx];
Y_stiff=[Ey;Fy];
h_stiff=plot(X_stiff,Y_stiff,'-','LineWidth',1,'Color',[0.27451 0.5098 0.70588]);

%% ��������������
axis equal;
grid on;
box on;
xlabel('չ�򳤶ȣ�m��'),ylabel('���򳤶ȣ�m��');
title('������ṹԪ������ʾ��ͼ');

%% ���ò���ͼ��
legend([h_cr,h_spar_001,h_rib(1),h_str_rib_001,h_stiff(1)],'����Ե����','��������','������ͨ����','�����ǿ��','������');
