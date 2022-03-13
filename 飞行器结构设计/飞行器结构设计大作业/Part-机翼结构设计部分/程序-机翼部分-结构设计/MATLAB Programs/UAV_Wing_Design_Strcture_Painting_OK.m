%% 机翼结构设计初步元件布置（MATLAB图形可视化）
%% 程序初始化
clear all
clf
clc

%% 导入机翼几何尺寸数据（单位：mm）
e=1000; % 缩放比例
b=30574/e; % 翼展长度
bh=b/2; % 半翼展长度
cr=2348/e; % 根弦长度
ct=904/e; % 根梢长度
cj=250/e;
theta=(cr-ct)/bh;

%% 绘制机翼根梢弦与前后缘
hold on;
h_cr=plot([0,0],[0,cr],'-g','LineWidth',1.8); % 机翼根弦
h_ct=plot([bh,bh],[ct,cr],'-g','LineWidth',1.8); % 机翼梢弦
h_rear=plot([0,bh],[cr,cr],'-g','LineWidth',1.8); % 机翼后缘
h_front=plot([0,bh],[0,ct],'-g','LineWidth',1.8); % 机翼前缘

%% 绘制纵向元件（翼梁）
% 输入翼梁根数
n_spar=4;
n_spar_vir=n_spar+2;

% 线性方法生成数据
Cx=linspace(0,0,n_spar_vir);
Cy=linspace(0,cr-cj,n_spar_vir);
Dx=linspace(bh,bh,n_spar_vir);
Dy=linspace(ct,cr,n_spar_vir);

% 删去前缘和后缘两个线型
Cx(1)=[];Cx(n_spar+1)=[];Cy(1)=[];Cy(n_spar+1)=[];
Dx(1)=[];Dx(n_spar+1)=[];Dy(1)=[];Dy(n_spar+1)=[];
X_spar=[Cx;Dx];
Y_spar=[Cy;Dy];
h_spar=plot(X_spar,Y_spar,'-r','LineWidth',1.5);

%% 绘制横向元件（翼肋）
% 确定加强肋位置（2#与3#）
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

% 输入翼梁（一侧）根数
n_rib=6;
n_rib_vir=n_rib+2;

% 线性方法生成数据
Ax=linspace(Bx_3,bh,n_rib_vir);
Ay=linspace(cr,cr,n_rib_vir);
Bx=linspace(Bx_3,bh,n_rib_vir);
By=linspace(By_3,ct,n_rib_vir);

% 删去第一个和最后一个线型
% Ax(1)=[];Ax(n_rib+1)=[];Ay(1)=[];Ay(n_rib+1)=[];
% Bx(1)=[];Bx(n_rib+1)=[];By(1)=[];By(n_rib+1)=[];
X_rib=[Ax;Bx];
Y_rib=[Ay;By];
h_rib=plot(X_rib,Y_rib,'-','LineWidth',1,'Color',[0 0 1]);

%% 设置坐标轴特性
axis equal;
grid on;
box on;
xlabel('展向长度（m）'),ylabel('弦向长度（m）');

%% 设置部分图例
legend([h_cr,h_spar(1),h_rib(1)],'机翼缘条线','机翼翼梁','机翼翼肋');
