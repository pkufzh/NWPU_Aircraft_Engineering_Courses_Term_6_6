%% 机翼结构设计初步元件布置（MATLAB图形可视化）
%% 程序初始化
clear all
clf
clc

%% 导入机翼几何尺寸数据（单位：mm）
e=1000; % 缩放比例
b=30574/e; % 翼展长度
bh=b/2; % 半翼展长度
cr=1873.3/e; % 根弦长度
ct=749.3/e; % 根梢长度
theta=atan((cr-ct)/bh);

%% 绘制机翼根梢弦与前后缘
hold on;
h_cr=plot([0,0],[0,cr],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % 机翼根弦
h_ct=plot([bh,bh],[(cr-ct),cr],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % 机翼梢弦
h_rear=plot([0,bh],[cr,cr],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % 机翼后缘
h_front=plot([0,bh],[0,(cr-ct)],'-','LineWidth',1.8,'Color',[0.18039 0.5451 0.34118]); % 机翼前缘

%% 绘制横向元件（普通翼肋+加强翼肋）
% 参数化加强肋位置
L_str_rib_2=0.8153; % 2#加强肋翼展位置（单位：米）
L_str_rib_3=2.8420; % 3#加强肋翼展位置（单位：米）

% 确定加强肋位置（2#与3#）
Ax_2=L_str_rib_2;
Ay_2=cr;
Bx_2=L_str_rib_2;
By_2=theta*Bx_2;
Ax_3=L_str_rib_3;
Ay_3=cr;
Bx_3=L_str_rib_3;
By_3=tan(theta)*Bx_3;

% 绘制加强肋位置
h_str_rib_001=plot([Ax_2,Bx_2],[Ay_2,By_2],'-','LineWidth',1.8,'Color',[1 0 1]);
h_str_rib_002=plot([Ax_3,Bx_3],[Ay_3,By_3],'-','LineWidth',1.8,'Color',[1 0 1]);

% 输入普通翼肋（一侧）根数
n_rib=6;
n_rib_vir=n_rib+2;

% 线性方法生成数据，参数化普通翼肋位置
Ax=linspace(Bx_3,bh,n_rib_vir);
Ay=linspace(cr,cr,n_rib_vir);
Bx=linspace(Bx_3,bh,n_rib_vir);
By=linspace(By_3,(cr-ct),n_rib_vir);

% 删去第一个和最后一个线型
Ax(1)=[];Ax(n_rib+1)=[];Ay(1)=[];Ay(n_rib+1)=[];
Bx(1)=[];Bx(n_rib+1)=[];By(1)=[];By(n_rib+1)=[];
X_rib=[Ax;Bx];
Y_rib=[Ay;By];
h_rib=plot(X_rib,Y_rib,'-','LineWidth',1,'Color',[0 0 1]);

%% 绘制纵向元件（翼梁）
% 输入翼梁根数
n_spar=4;

% 参数化翼梁位置
L_spar_1=0.1787; % 1#翼梁的相对弦长位置
L_spar_2=0.3574; % 2#翼梁的相对弦长位置
L_spar_3=0.5361; % 3#翼梁的相对弦长位置
L_spar_4=0.7148; % 4#翼梁的相对弦长位置

% 线性方法生成数据
Cx(1)=0;
Cx(2)=Bx_3;
Cx(3)=Bx_3;
Cx(4)=0;
crr=cr-By_3; % 3#加强肋的翼弦长度
Cy(1)=L_spar_1*cr;
Cy(2)=(L_spar_2*crr)+By_3;
Cy(3)=(L_spar_3*crr)+By_3;
Cy(4)=L_spar_4*cr;
Dx=linspace(bh,bh,n_spar);
Dy(1)=L_spar_1*ct;
Dy(2)=L_spar_2*ct;
Dy(3)=L_spar_3*ct;
Dy(4)=L_spar_4*ct;
Dy=Dy+(cr-ct);

% 绘制翼梁结构分布
h_spar_001=plot([Cx(1),Dx(1)],[Cy(1),Dy(1)],'-r','LineWidth',1.2);
h_spar_002=plot([Cx(2),Dx(2)],[Cy(2),Dy(2)],'-r','LineWidth',1.2);
h_spar_003=plot([Cx(3),Dx(3)],[Cy(3),Dy(3)],'-r','LineWidth',1.2);
h_spar_004=plot([Cx(4),Dx(4)],[Cy(4),Dy(4)],'-r','LineWidth',1.2);

%% 绘制起落架开口区与根肋之间上壁面的长桁
% 输入该区域长桁根数
n_stiff=6;
n_stiff_vir=n_rib+2;

% 线性方法生成数据
Ex=linspace(0,0,n_stiff_vir);
Ey=linspace(Cy(1),Cy(4),n_stiff_vir);
Fx=linspace(Bx_3,Bx_3,n_stiff_vir);
Fy=linspace(((L_spar_1*crr)+By_3),((L_spar_4*crr)+By_3),n_stiff_vir);

% 删去第一个和最后一个线型
Ex(1)=[];Ex(n_stiff+1)=[];Ey(1)=[];Ey(n_stiff+1)=[];
Fx(1)=[];Fx(n_stiff+1)=[];Fy(1)=[];Fy(n_stiff+1)=[];
X_stiff=[Ex;Fx];
Y_stiff=[Ey;Fy];
h_stiff=plot(X_stiff,Y_stiff,'-','LineWidth',1,'Color',[0.27451 0.5098 0.70588]);

%% 设置坐标轴特性
axis equal;
grid on;
box on;
xlabel('展向长度（m）'),ylabel('弦向长度（m）');
title('上翼面结构元件布置示意图');

%% 设置部分图例
legend([h_cr,h_spar_001,h_rib(1),h_str_rib_001,h_stiff(1)],'机翼缘条线','机翼翼梁','机翼普通翼肋','机翼加强肋','机翼长桁');
