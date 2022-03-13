function Vol_Goal = volcal_allrib(L_rib_x)
%% 机翼各元件尺寸优化MATLAB目标函数
%% 模块1：机翼原始尺寸、各主要元件站位数据、材料属性导入
% 【重量信息】
Mmax=10394; % 最大起飞重量
Mh=Mmax; % 最大起飞重量的一半（用以单侧机翼气动力估算）
Mw=1160; % 单侧机翼重量估算
f=1.5; % 安全系数
g=9.8; % 重力加速度
nmax=3; % 最大正过载系数

% 【机翼主要尺寸】
e=1000; % 缩放比例
bt=35420/e; % 翼展长度
bth=bt/2; % 半翼展长度
cr=1873.3/e; % 根弦长度
ct=749.3/e; % 根梢长度
theta=atan((cr-ct)/bth); % 机翼前缘后掠角

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

% 参数化普通翼肋位置
L_rib_0=0.01;
% L_rib_3=0.302208571428571;
% L_rib_4=0.418507142857143;
% L_rib_5=0.534805714285714;
% L_rib_6=0.6511042857142861;
% L_rib_7=0.767402857142857;
% L_rib_8=0.883701428571429;
% L_rib_9=0.95;
% L_rib=[L_rib_3,L_rib_x]; % 保存各普通翼肋相对半翼展位置（除根肋与梢肋）
L_rib=L_rib_x;

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
Room_C_foil=zeros(1,n_rib); % 保存翼型周长
for k=1:n_rib
    for i=1:n_room
        dl=(L_spar(i+1)-L_spar(i))*c_rib_all(k);
        ht=L_spar_h_abs(i,k)+L_spar_h_abs(i+1,k);
        dh=abs(L_spar_h_abs(i+1,k)-L_spar_h_abs(i,k));
        Room_area(i,k)=(0.5*ht)*dl;
        Room_C(i,k)=dl+ht+sqrt(dl^2+dh^2);
    end
end
for k=1:n_rib
    Room_C_foil(k)=(Room_C(1,k)+Room_C(2,k)+Room_C(3,k))-2*(L_spar_h_abs(2,k)-L_spar_h_abs(3,k));
end

% 【材料属性】
% 碳纤维材料属性
% sigma_e_carbon; % 受压失稳临界应力（单位：Pa）
% LY12铝合金材料属性
E_alum=68e9; % 拉伸杨氏模量（单位：Pa）
sigma_s_alum=325e6; % 屈服极限（单位：Pa）
rou_alum=2770; % 材料密度

%% 模块2：机翼各翼肋位置外载信息导入与计算
% 机翼展向各翼肋位置的剪力Q与弯矩M分布估算（采用公式方法）
syms x; % 设置积分符号变量x
A_q=zeros(1,n_rib); % 保存各机翼展向普通翼肋站位剪力Fy值
A_m=zeros(1,n_rib); % 保存各机翼展向普通翼肋站位弯矩Mz值
A_mt=zeros(1,n_rib); % 保存各机翼展向普通翼肋站位扭矩Mt值

% 对各翼肋站位的外载进行计算
for i=1:n_rib
    L=L_rib_all(i)*bth; % 取出当前计算翼肋位置
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

% 【翼肋腹板厚度确定】（厚度t_rib）
t_rib=zeros(1,n_rib);
for k=1:n_rib
    a_rib=(L_spar_2-L_spar_1)*c_rib_all(k);
    b_rib=L_spar_h_abs(1,k);
    K_rib=5.6+(3.78/((a_rib/b_rib)^2));
    t_rib(k)=(abs((q_pla(1,k)*b_rib*b_rib))/(0.9*K_rib*E_alum))^(1/3);
end

%% 模块4：结构重量（各元件体积）计算
% 计算各盒段长度
dis_long=zeros(1,n_rib);
for k=1:n_rib-1
    dis_long(k)=(L_rib_all(k+1)-L_rib_all(k))*bth;
end
dis_long(n_rib)=(1-L_rib_all(n_rib))*bth;

% 蒙皮壁板重量（体积）计算
Vol_Skin=0;
t_skin_max=max(t_skin);
for i=1:n_rib
    Vol_Skin=Vol_Skin+(t_skin_max(i)*Room_C_foil(i)*dis_long(i));
end

% 翼肋腹板重量（体积）计算
Vol_Rib=0;
for i=1:n_rib
    Vol_Rib=Vol_Rib+((Room_area(1,i)+Room_area(2,i)+Room_area(3,i))*t_rib(i));
end

% 计算元件总体积为Vol_Goal
Vol_Goal=(Vol_Skin+Vol_Rib)*rou_alum;

end

