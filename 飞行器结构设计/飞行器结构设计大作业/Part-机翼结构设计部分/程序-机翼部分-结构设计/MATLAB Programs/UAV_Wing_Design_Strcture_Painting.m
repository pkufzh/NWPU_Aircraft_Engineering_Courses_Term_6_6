%% 机翼结构设计初步元件布置（MATLAB图形可视化）
%% 程序初始化
clear all
clf
clc

%% 导入机翼几何尺寸数据（单位：mm）
b=30574; % 翼展长度
bh=b/2; % 半翼展长度
cr=2348; % 根弦长度
ct=904; % 根梢长度

%% 绘制机翼根梢弦与前后缘
hold on;
h_cr=plot([0,0],[0,cr],'-g','LineWidth',2); % 机翼根弦
h_ct=plot([bh,bh],[ct,0],'-g','LineWidth',2); % 机翼稍弦
h_rear=plot([0,bh],[0,0],'-g','LineWidth',2); % 机翼后缘
h_front=plot([0,bh],[cr,ct],'-g','LineWidth',2); % 机翼前缘

%% 绘制纵向元件（翼梁）
% 输入翼梁根数
n_ron=4;
n_ron_vir=n_ron+2;

% 线性方法生成数据
Cx=linspace(0,0,n_ron_vir);
Cy=linspace(0,cr,n_ron_vir);
Dx=linspace(bh,bh,n_ron_vir);
Dy=linspace(0,ct,n_ron_vir);

% 删去前缘和后缘两个线型
Cx(1)=[];Cx(n_ron+1)=[];Cy(1)=[];Cy(n_ron+1)=[];
Dx(1)=[];Dx(n_ron+1)=[];Dy(1)=[];Dy(n_ron+1)=[];
X_ron=[Cx;Dx];
Y_ron=[Cy;Dy];
h_ron=plot(X_ron,Y_ron,'-r','LineWidth',2);

%% 绘制横向元件（翼肋）
% 输入翼梁（一侧）根数
n_rib=10;
n_rib_vir=n_rib+2;

% 线性方法生成数据
Ax=linspace(0,bh,n_rib_vir);
Ay=linspace(0,0,n_rib_vir);
Bx=linspace(0,bh,n_rib_vir);
By=linspace(cr,ct,n_rib_vir);

% 删去第一个和最后一个线型
Ax(1)=[];Ax(n_rib+1)=[];Ay(1)=[];Ay(n_rib+1)=[];
Bx(1)=[];Bx(n_rib+1)=[];By(1)=[];By(n_rib+1)=[];
X_rib=[Ax;Bx];
Y_rib=[Ay;By];
h_rib=plot(X_rib,Y_rib,'-b','LineWidth',2);

%% 设置坐标轴特性
axis equal;
grid on;
box on;
xlabel('展向长度（m）'),ylabel('弦向长度（m）');

%% 设置部分图例
legend([])
