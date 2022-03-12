%% 机翼外载程序计算（采用椭圆形分布法近似，各个站位可继续细分）
%% 气动力分布算法：椭圆分布算法（大展弦比飞机）
%% 程序初始化
clear all
clf
clc

%% UAV总体参数设定
% 重量尺寸信息
Mmax=10394; % 最大起飞重量
Mh=Mmax/2; % 最大起飞重量的一半（用以单侧机翼气动力估算）
Mw=1160; % 机翼重量估算
bt=35.42; % 翼展长度
bth=bt/2; % 半翼展长度
c_mean=1.42; % 平均气动弦长

% 过载信息
nmax=3.048; % 最大载荷系数
nmin=-1.088; % 最小载荷系数
f=1.5; % 安全系数
g=9.8; % 重力加速度

% 气动特性参数
xac=0.241242799; % 机翼焦点相对位置
xcg=0.45; % 机翼重心相对位置
xz=0.5; % 机翼轴位置

%% 计算模块1：展向气动力分布估算（采用公式方法）
n_rib=20; % 展向站位个数
x=linspace(0,bth,n_rib);
z_upper=(nmax*1.5*2*Mh*g)*(sqrt(bth^2-x.^2)/(pi*bth^2)); % 利用公式拟合最大正过载nmax情况下的升力分布
z_lower=(nmin*1.5*2*Mh*g)*(sqrt(bth^2-x.^2)/(pi*bth^2)); % 利用公式拟合最大负过载nmin情况下的升力分布

% 采用双坐标轴绘制气动力分布图线
hl=plotyy(x,z_upper,x,z_lower);

% 进行坐标轴设置
xlabel('机翼展向位置（m）'),ylabel('气动力值（N）'),title('机翼展向气动力分布估算（采用公式方法拟合）');
xticks(0:3:17.71); 
yticks(0:2000:20000);
grid on
box on

%% 计算模块2、3：机翼展向剪力Q与弯矩M分布估算（采用公式方法）
% 模块初始化
syms x; % 设置积分符号变量x
cnt=0; % 计数器置零
A_y=zeros(1,n_rib); % 保存各机翼展向站位剪力Fy值
A_m=zeros(1,n_rib); % 保存各机翼展向站位弯矩Mz值

% 对各站位剪力Q与弯矩M进行计算
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

% 绘制机翼展向剪力分布图线与柱状图
figure;
t=0:(bth/n_rib):bth;
hold on
plot(t,A_y,'r-','LineWidth',2);
bar(t,A_y);
xlabel('机翼展向位置（m）'),ylabel('机翼展向剪力值（N）'),title('机翼展向剪力分布估算（采用公式方法拟合）');
grid on
box on

% 绘制机翼展向弯矩分布图线与柱状图
figure;
t=0:(bth/n_rib):bth;
hold on
plot(t,A_m,'b-','LineWidth',2);
bar(t,A_m);
xlabel('机翼展向位置（m）'),ylabel('机翼展向弯矩值（N*m）'),title('机翼展向弯矩分布估算（采用公式方法拟合）');
grid on
box on

%% 计算模块4：机翼展向扭矩Mt分布估算（采用公式方法）
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

% 绘制机翼展向扭矩分布图线与柱状图
figure;
t=0:(bth/n_rib):bth;
hold on
plot(t,A_mt,'m-','LineWidth',2);
bar(t,A_mt);
xlabel('机翼展向位置（m）'),ylabel('机翼展向扭矩值（N*m）'),title('机翼展向扭矩分布估算（采用公式方法拟合）');
grid on
box on
