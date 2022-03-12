%% 机翼各元件尺寸确定与校核MATLAB程序
%% 程序初始化
clear all
clf
clc

%% 模块1：机翼原始尺寸、各主要元件站位数据、材料属性导入
% 【重量信息】
Mmax=10394; % 最大起飞重量
Mh=Mmax/2; % 最大起飞重量的一半（用以单侧机翼气动力估算）
Mw=580; % 单侧机翼重量估算
f=1.5; % 安全系数
g=9.8; % 重力加速度
nmax=3; % 最大正过载系数
nmin=-1; % 最大负过载系数

% 【机翼气动特性参数】
xac=0.241242799; % 机翼焦点相对位置
xcg=0.45; % 机翼重心相对位置
xz=0.5; % 机翼轴位置

% 【机翼主要尺寸】
e=1000; % 缩放比例
bt=35420/e; % 翼展长度
bth=bt/2; % 半翼展长度
cr=1873.3/e; % 根弦长度
ct=749.3/e; % 根梢长度
c_mean=1.42; % 平均气动弦长
theta=atan((cr-ct)/bth); % 机翼前缘后掠角
% skinb=0.02; % 蒙皮厚度

% 【机翼各主要元件站位数据导入】
% 【翼梁信息】
% 参数化翼梁位置
L_spar_1=0.1787; % 1#翼梁的相对弦长位置
L_spar_2=0.3574; % 2#翼梁的相对弦长位置
L_spar_3=0.5361; % 3#翼梁的相对弦长位置
L_spar_4=0.7148; % 4#翼梁的相对弦长位置
L_spar=[L_spar_1,L_spar_2,L_spar_3,L_spar_4]; % 保存翼梁相对弦长位置
n_spar=length(L_spar); % 翼梁根数
% 给出各翼梁所在位置翼型相对弦长高度
L_spar_h_1=0.085;
L_spar_h_2=0.095;
L_spar_h_3=0.080;
L_spar_h_4=0.055;
L_spar_h=[L_spar_h_1,L_spar_h_2,L_spar_h_3,L_spar_h_4];

% 【翼肋信息】
% 参数化加强肋位置
L_str_rib_1=0.05333; % 1#加强肋翼展相对半翼展位置
L_str_rib_2=0.18591; % 2#加强肋翼展相对半翼展位置
L_str_rib=[L_str_rib_1,L_str_rib_2]; % 保存加强肋相对半翼展位置
n_rib_str=length(L_str_rib); % 普通翼肋根数

% 参数化普通翼肋位置
L_rib_0=0.01;
L_rib_3=0.302208571428571;
L_rib_4=0.418507142857143;
L_rib_5=0.534805714285714;
L_rib_6=0.6511042857142861;
L_rib_7=0.767402857142857;
L_rib_8=0.883701428571429;
L_rib_9=0.95;
L_rib=[L_rib_3,L_rib_4,L_rib_5,L_rib_6,L_rib_7,L_rib_8]; % 保存各普通翼肋相对半翼展位置（除根肋与梢肋）

n_rib_ori=length(L_rib); % 普通翼肋根数

% 保存所有翼肋相对半翼展位置
L_rib_all=[L_rib_0,L_str_rib,L_rib];
% 获取所有需要计算外载的翼肋数量
n_rib=length(L_rib_all);

% 翼梁高度计算
% 计算各站位翼肋对应的翼型弦长
c_rib_all=zeros(1,n_rib);
for i=1:n_rib
    c_rib_all(i)=cr-(L_rib_all(i)*bth*tan(theta));
end
% 计算各站位翼肋对应的翼梁高度（单位：m）
L_spar_h_abs=L_spar_h'*c_rib_all;
% 计算各站位翼肋对应的闭室参数（共四个，前缘闭室近似为三角形，中间三个近似为直角梯形）
n_room=n_spar-1;
Room_area=zeros(n_room,n_rib); % 保存闭室面积
Room_C=zeros(n_room,n_rib); % 保存闭室周长
for k=1:n_rib
%     Room_area(1,k)=0.6*(L_spar(1)*c_rib_all(k))*L_spar_h_abs(1,k); % 前缘闭室近似为三角形，系数稍大取为0.6
%     Room_C(1,k)=(L_spar(1)*c_rib_all(k))+L_spar_h_abs(1,k)+1.2*sqrt((L_spar(1)*c_rib_all(k))^2+L_spar_h_abs(1,k)^2);
%     Area_room(n_room,k)=0.5*((1-L_spar(n_spar))*c_rib_all(k))*L_spar_h_abs(n_spar,k); % 后缘闭室近似为三角形
    for i=1:(n_spar-1)
        dl=(L_spar(i+1)-L_spar(i))*c_rib_all(k);
        ht=L_spar_h_abs(i,k)+L_spar_h_abs(i+1,k);
        dh=abs(L_spar_h_abs(i+1,k)-L_spar_h_abs(i,k));
        Room_area(i,k)=(0.5*ht)*dl;
        Room_C(i,k)=dl+ht+sqrt(dl^2+dh^2);
    end
end

% 【材料属性】
% 碳纤维材料属性
E_carbon=143e9; % 拉伸杨氏模量（单位：Pa）
sigma_b_carbon=2323e6; % 拉伸强度（单位：Pa）
% sigma_e_carbon; % 受压失稳临界应力（单位：Pa）
% LY12铝合金材料属性
E_alum=68e9; % 拉伸杨氏模量（单位：Pa）
sigma_b_alum=470e6; % 拉伸强度极限（单位：Pa）
sigma_e_alum=280e6; % 受压失稳临界应力（单位：Pa）
sigma_s_alum=325e6; % 屈服极限（单位：Pa）

%% 模块2：机翼各翼肋位置外载信息导入与计算
% 机翼展向各翼肋位置的剪力Q与弯矩M分布估算（采用公式方法）
syms x; % 设置积分符号变量x
A_q=zeros(1,n_rib); % 保存各机翼展向普通翼肋站位剪力Fy值
A_m=zeros(1,n_rib); % 保存各机翼展向普通翼肋站位弯矩Mz值
A_mt=zeros(1,n_rib); % 保存各机翼展向普通翼肋站位扭矩Mt值

% 对各翼肋站位的外载进行计算
for i=1:n_rib
    L=L_rib_all(i); % 取出当前计算翼肋位置
    z=f*nmax*2*Mh*g*sqrt(bth^2-x.^2)/(pi*bth^2);
    n=f*nmax*((0.31*2*Mh*g*sqrt(bth^2-x.^2)/(pi*(bth^2)))-(0.24*2*Mw*g*sqrt((bth^2)-x.^2)/(pi*(bth^2))));
    q=int(z,x,bth,L);
    m=int(q,x,bth,L);
    mt=int(n,x,bth,L);
    p_q=double(q);
    p_m=double(m);
    p_mt=double(mt);
    A_q(i)=p_q;
    A_m(i)=p_m;
    A_mt(i)=p_mt;
end

%% 模块3：翼梁各元件主要尺寸确定
% 【蒙皮尺寸确定】（厚度t_skin）
J_room=zeros(1,n_rib); % K_pla用以保存各翼肋位置的各闭室扭转剖面系数信息
Mt_room=zeros(n_room,n_rib);
qt_room=zeros(n_room,n_rib);
t_skin=zeros(n_room,n_rib);
q0_pla=zeros(n_spar,n_rib); % q0_pla用以保存由扭转引起的各翼肋站位处的四块梁腹板位置处所受剪流信息
for k=1:n_rib
    for j=1:n_room
        J_room(k)=J_room(k)+((2*Room_area(j,k))^2)/Room_C(j,k);
    end
end
% 计算各翼肋处各闭室所受扭矩（按刚度分配）
for k=1:n_rib
    for j=1:n_room
        Mt_room(j,k)=A_mt(k)*((((2*Room_area(j,k))^2)/Room_C(j,k))/J_room(k));
        qt_room(j,k)=Mt_room(j,k)/(2*Room_area(j,k));
    end
end
% 计算各翼肋处各闭室蒙皮厚度（可取最大值为该站位蒙皮最终厚度）
for k=1:n_rib
    for j=1:n_room
        t_skin(j,k)=abs(qt_room(j,k))/(0.1*sigma_s_alum);
    end
end
% 计算由扭矩引起的各翼肋处各翼梁腹板的剪流q0
for k=1:n_rib
    q0_pla(1,k)=qt_room(1,k);
    q0_pla(2,k)=qt_room(2,k)-qt_room(1,k);
    q0_pla(3,k)=qt_room(3,k)-qt_room(2,k);
    q0_pla(4,k)=(-1)*qt_room(3,k);
end

% 【翼梁腹板尺寸确定】（厚度t_spar），近似有各翼梁长度相同
K_pla=zeros(1,n_rib); % K_pla用以保存各翼肋位置的梁腹板刚度信息
q1_pla=zeros(n_spar,n_rib); % q1_pla用以保存由剪力引起的各翼肋站位处梁腹板位置处所受剪流信息
q_pla=zeros(n_spar,n_rib); % q_pla用以保存由剪力和扭矩叠加引起的各翼肋站位处梁腹板位置处所受剪流信息
t_pla_alum=zeros(n_spar,n_rib); % t_pla保存各翼肋站位处的四块梁腹板厚度信息
t_pla_carbon=zeros(n_spar,n_rib);
t_pla_alum_add=zeros(n_spar,n_rib); % t_pla保存各翼肋站位处的四块梁腹板厚度信息
t_pla_carbon_add=zeros(n_spar,n_rib);
for k=1:n_rib
    for i=1:n_spar
        K_pla(k)=K_pla(k)+(L_spar_h_abs(i,k)^2);
    end
end
% 计算由剪力引起的各翼肋站位处各翼梁腹板所受剪流q1大小（按刚度分配）
for i=1:n_spar
    for j=1:n_rib
        q1_pla(i,j)=(A_q(j)*((L_spar_h_abs(i,j)^2)/K_pla(j)))/L_spar_h_abs(i,j);
    end
end
% 计算由剪力与扭矩叠加引起的各翼肋站位处各翼梁腹板所受剪流q大小（按刚度分配）
for i=1:n_spar
    for j=1:n_rib
        q_pla(i,j)=q0_pla(i,j)+q1_pla(i,j);
    end
end
% 计算各翼肋站位处各翼梁腹板的厚度
for i=1:n_spar
    for j=1:n_rib
        % 情况一：不考虑加装立柱
        t_pla_alum(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*5.6*E_alum))^(1/3);
        t_pla_carbon(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*5.6*E_carbon))^(1/3);
        % 情况二：考虑加装立柱
        t_pla_alum_add(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*9.38*E_alum))^(1/3);
        t_pla_carbon_add(i,j)=((abs(q_pla(i,j))*(L_spar_h_abs(i,j)^2))/(0.9*9.38*E_carbon))^(1/3);
    end
end

% 【翼梁缘条尺寸确定】（截面积）
% 首先考虑翼梁缘条承受总弯矩比例为系数Me，上下蒙皮承受弯矩比例为Ms=1-Me（大部分），后续需要校核
Me=0.08;
Ms=1-Me;
A_my=Me*A_m; % 各翼肋站位处梁缘条所承受总弯矩
Ke_str=0.95; % 考虑梁缘条有效面积削减系数

M_str=zeros(n_spar,n_rib); % 保存各翼肋站位处各梁缘条分配弯矩（按刚度分配）
N_str=zeros(n_spar,n_rib); % 保存各翼肋站位处各梁缘条分配轴力
A_str_lower=zeros(n_spar,n_rib); % 保存各翼肋站位处下梁缘条截面积（受拉伸）
A_str_upper_001=zeros(n_spar,n_rib); % 保存各翼肋站位处下梁缘条截面积（受拉伸）
A_str_upper_002=zeros(n_spar,n_rib); % 保存各翼肋站位处下梁缘条截面积（受拉伸）
la_str_lower=zeros(n_spar,n_rib);
lb_str_lower=zeros(n_spar,n_rib);
la_str_upper_001=zeros(n_spar,n_rib);
lb_str_upper_001=zeros(n_spar,n_rib);
la_str_upper_002=zeros(n_spar,n_rib);
lb_str_upper_002=zeros(n_spar,n_rib);

% 计算各翼肋站位处各翼梁缘条弯矩大小（按刚度分配）
for k=1:n_rib
    for i=1:n_spar
        M_str(i,k)=A_my(k)*((L_spar_h_abs(i,k)^2)/K_pla(k));
        N_str(i,k)=M_str(i,k)/L_spar_h_abs(i,k);
    end
end

% 确定下缘条尺寸——受拉（由静强度确定）A=N/sigma_b
for k=1:n_rib
    for i=1:n_spar
        A_str_lower(i,k)=(N_str(i,k)/sigma_b_alum)/Ke_str;
        la_str_lower(i,k)=0.08;
        lb_str_lower(i,k)=A_str_lower(i,k)/la_str_lower(i,k);
    end
end

% 确定上缘条尺寸——受压（由压杆总体稳定性确定，两种方式）
% 方法一
for k=1:n_rib
    for i=1:n_spar
        A_str_upper_001(i,k)=(N_str(i,k)/sigma_e_alum)/Ke_str;
        la_str_upper_001(i,k)=0.08;
        lb_str_upper_001(i,k)=A_str_upper_001(i,k)/la_str_upper_001(i,k);
    end
end

% 方法二
for k=1:n_rib
    if (k<n_rib)
        l_ik=(L_rib_all(k+1)-L_rib_all(k))*bth;
    else
        l_ik=(1-L_rib_all(k))*bth;
    end
    for i=1:n_spar
        lb_str_upper_002(i,k)=(((3*N_str(i,k)*(l_ik^2))/(20*4*(pi^2)*sigma_e_alum))^(1/3))/Ke_str;
        la_str_upper_002(i,k)=0.08;
        A_str_upper_002(i,k)=la_str_upper_002(i,k)*lb_str_upper_002(i,k);
    end
end

%% 模块4：尺寸计算结果输出
fprintf('【UAV机翼主要元件尺寸计算（2020/07/10）】\n');
fprintf('\n');
fprintf('【蒙皮尺寸】\n');
fprintf('\n');
ts=max(t_skin);
fprintf('根弦段（0*普通肋）处蒙皮厚度为：%.4f（mm）\n',ts(1)*e);
fprintf('中间段（5*普通肋）处蒙皮厚度为：%.4f（mm）\n',ts(5)*e);
fprintf('梢弦段（9*普通肋）处蒙皮厚度为：%.4f（mm）\n',ts(n_rib)*e);
fprintf('\n');
fprintf('【翼梁尺寸】\n');
fprintf('\n');
fprintf('【梁腹板尺寸】（注：CATIA建模时可通过根肋和梢肋处两个梁腹板截面放样）\n');
fprintf('\n');
fprintf('1) 梁腹板高度\n');
fprintf('\n');
for i=1:n_spar
    fprintf('梁%d# 梁腹板根肋处高度为：%.4f（mm）\n',i,L_spar_h_abs(i,1)*e);
    fprintf('梁%d# 梁腹板梢肋处高度为：%.4f（mm）\n',i,L_spar_h_abs(i,n_rib)*e);
    fprintf('\n');
end
fprintf('\n');
fprintf('2) 梁腹板厚度\n');
fprintf('\n');
fprintf('情况1：不加支柱，采用LY12铝合金\n');
for i=1:n_spar
    ta=max(t_pla_alum');
    fprintf('梁%d# 梁腹板厚度为：%.4f（mm）\n',i,ta(i)*e);
end
fprintf('\n');
fprintf('情况2：加支柱，采用LY12铝合金\n');
for i=1:n_spar
    ta_add=max(t_pla_alum_add');
    fprintf('梁%d# 梁腹板厚度为：%.4f（mm）\n',i,ta_add(i)*e);
end
fprintf('\n');
fprintf('情况3：不加支柱，采用国产I型碳纤维\n');
for i=1:n_spar
    tc=max(t_pla_carbon');
    fprintf('梁%d# 梁腹板厚度为：%.4f（mm）\n',i,tc(i)*e);
end
fprintf('\n');
fprintf('情况4：加支柱，采用国产I型碳纤维\n');
for i=1:n_spar
    tc_add=max(t_pla_carbon_add');
    fprintf('梁%d# 梁腹板厚度为：%.4f（mm）\n',i,tc_add(i)*e);
end
fprintf('\n');
fprintf('【梁缘条尺寸】（采用工字梁结构）\n');
fprintf('\n');
fprintf('情况1：采用LY12铝合金\n');
for i=1:n_spar
    ta=max(A_str_lower');
    fprintf('梁%d# 下缘条截面积为：%.4f（mm^2）\n',i,ta(i)*e*e);
end
for i=1:n_spar
    la=max(la_str_lower');
    fprintf('梁%d# 下缘条宽度为：%.4f（mm）\n',i,la(i)*e);
end
for i=1:n_spar
    lb=max(lb_str_lower');
    fprintf('梁%d# 下缘条高度为：%.4f（mm）\n',i,lb(i)*e);
end
fprintf('\n');
for i=1:n_spar
    ta=max(A_str_upper_001');
    fprintf('方法一：梁%d# 上缘条截面积为：%.4f（mm^2）\n',i,ta(i)*e*e);
end
for i=1:n_spar
    la=max(la_str_upper_001');
    fprintf('方法一：梁%d# 上缘条长度为：%.4f（mm）\n',i,la(i)*e);
end
for i=1:n_spar
    lb=max(lb_str_upper_001');
    fprintf('方法一：梁%d# 上缘条宽度为：%.4f（mm）\n',i,lb(i)*e);
end
fprintf('\n');
for i=1:n_spar
    ta=max(A_str_upper_002');
    fprintf('方法二：梁%d# 上缘条截面积为：%.4f（mm^2）\n',i,ta(i)*e*e);
end
for i=1:n_spar
    la=max(la_str_upper_002');
    fprintf('方法二：梁%d# 上缘条长度为：%.4f（mm）\n',i,la(i)*e);
end
for i=1:n_spar
    lb=max(lb_str_upper_002');
    fprintf('方法二：梁%d# 上缘条宽度为：%.4f（mm）\n',i,lb(i)*e);
end
fprintf('\n');
