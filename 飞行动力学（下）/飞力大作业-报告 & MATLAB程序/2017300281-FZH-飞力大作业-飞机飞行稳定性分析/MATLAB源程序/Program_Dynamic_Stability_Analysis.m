%% 《飞行动力学》（下）课程大作业
%% N0.2：飞机动稳定性、各运动模态特性分析
%% 问题描述
% Using the data of the given aircraft to 
%	1. Calculate the short-period, roll-subsidence and Dutch-roll mode parameters, including ζ_sp, ω_sp, T_r, ζ_d, ω_d;
%	2. Evaluate the flying quality for Category A flight phases;
% 	3. Design proper flight control system to make the aircraft has Level I flying quality
% For the given flight condition: ① H=5000m, M=0.8; ② H=8000m, M=0.8; ③ H=14000m, M=1.4.

%% 求解关键步骤
% Step 1: Define the flight condition;
% Step 2: Define the geometry and mass data;
% Step 3: Calculate the airspeed and density based on flight condition,using the atmosphere model;
% Step 4: Load aerodynamic data;
% Step 5: Calculate the aerodynamic derivatives based on the flight condition using interpolation;
% Step 6: Calculate the matrix A_long,B_long, A_lat, B_lat;
% Step 7: Calculate the mode parameters, i.e., ζ_sp, ω_sp, CAP,and T_r,ζ_d, ω_d;

%% 个人信息
% 授课老师：刘艳老师
% 姓名：冯铮浩
% 学号：2017300281
% 学院：航空学院
% 完成时间：2020年5月1日

%% 程序初始化与环境设置
clear all
clc
format short;
fprintf('【个人信息】\n');
fprintf('《飞行动力学》（下）课程大作业\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('\n');
fprintf('【Problem 2】 飞机动稳定性、运动模态分析程序运行结果\n');
fprintf('\n');

%% Question 1（特征模态计算：Calculate the short-period, roll-subsidence and Dutch-roll mode parameters, including ζ_sp, ω_sp, T_r, ζ_d, ω_d;）
fprintf('【Question 1】 飞机飞行特征模态计算：\n');
fprintf('\n');

%% Step 1: 定义飞行状态
% 导入飞机飞行数据
H=5000; % 定义飞行高度（可调整输入变量）
Ma=0.8; % 定义飞行马赫数（可调整输入变量）
g=9.807; % 北纬45度地区的重力加速度值

% 定义飞机水平定值飞行各角度状态
alfa=0; % 迎角
beta=0; % 侧滑角

psi=0; % 偏航角
theta=alfa; % 俯仰角
phi=0; % 滚转角

%% Step 2: 定义飞机几何与质量参数
fprintf('【Part 1】 飞机的主要几何与质量参数\n');
fprintf('\n');
% 导入飞机几何相关数据
S=23; % 参考机翼面积（单位：m^2）
b=7.15; % 机翼翼展长度（单位：m）
c_mean=4.002; % 机翼平均气动弦长（单位：m）

fprintf('飞机的主要几何尺寸：\n');
fprintf('参考机翼面积 S = %.4f m^2\n',S);
fprintf('机翼翼展长度 b = %.4f m\n',b);
fprintf('机翼平均气动弦长 c_mean = %.4f m\n',c_mean);
fprintf('\n');

% 导入飞机质量相关数据
m=6000; % 全机重量（单位：kg）
Ix=4312; % 全机绕x轴主惯性矩（单位：kg*m^2）
Iy=45374; % 全机绕y轴主惯性矩（单位：kg*m^2）
Iz=48216; % 全机绕z轴主惯性矩（单位：kg*m^2）
Ixz=0; % 全机绕x轴,z轴惯性积（单位：kg*m^2）

fprintf('飞机的主要质量参数：\n');
fprintf('全机重量 m = %.4f kg\n',m);
fprintf('全机绕x轴主惯性矩 Ix = %.4f kg*m^2\n',Ix);
fprintf('全机绕y轴主惯性矩 Iy = %.4f kg*m^2\n',Iy);
fprintf('全机绕z轴主惯性矩 Iz = %.4f kg*m^2\n',Iz);
fprintf('全机绕x轴,z轴惯性积 Ixz = %.4f kg*m^2\n',Ixz);
fprintf('\n');

%% Step 3: 根据飞机飞行状态，结合大气模型，计算飞行速度与当地大气密度
% 计算当前飞行海拔高度下的温度T与压强p
if (H<11000)     % 对流层高度
    T=288.15-0.0065*H;
    p=101325*((1-2.25577*H*(1e-5)).^(5.2588)); % 压强p与海拔高度H之间关系计算公式一
%   p=101.3*1000*((288.15./(288.15-6.5*H*0.001)).^(34.17./(-6.5))); % 压强p与海拔高度H之间关系计算公式二
elseif (H<20000) % 同温层高度
    T=216.65;
    p=22631*exp(-((H-11000)*g)/(287*216.65));
else
    fprintf('\n');
    fprintf('错误：当前飞行海拔高度大于20000m！请调整状态参数后重新启动程序！\n');
    fprintf('\n');
    exit;
end

% 计算当前飞行速度
a=sqrt(1.4*287*T); % 计算当地音速
V=Ma*a; % 计算飞行速度

% 计算当地大气密度
rou=p/(287*T);

% 输出当前飞行状态信息
fprintf('【Part 2】 飞机当前设定飞行状态\n');
fprintf('\n');

fprintf('飞行海拔高度：H = %d（m）\n',H);
fprintf('飞行马赫数：Ma = %.2f\n',Ma);
fprintf('当地温度：T = %.2f（K）\n',T);
fprintf('当地大气压强：p = %.2f（Pa）\n',p);
fprintf('当地大气密度：ρ = %.2f（kg/m^3）\n',rou);
fprintf('当地音速：a = %.2f（m/s）\n',a);
fprintf('当前飞行速度：V = %.2f（m/s）\n',V);
fprintf('\n');

%% Step 4: 导入给定飞机气动数据
LAD=load('Longitudinal Aerodynamic Data.txt');
% 纵向气动数据各列代表变量说明
% 1 - H（高度）；2 - Ma（马赫数）；3 - C_L_alfa（升力线斜率）；4 - C_m_CL；
% 5 - C_m_det_e（升降舵操纵效率）；6 - C_L_det_e；7 - C_m_q（阻尼动导数）；
% 8 - C_m_alfa_dot（阻尼动导数）；9 - C_m_alfa（纵向静稳定性指标，俯仰力矩对迎角导数的导数）；
% 10 - C_m0（零升俯仰力矩系数）

% 导入飞机横航向气动数据
LDAD=load('Lateral-Directional Aerodynamic Data.txt');
% 横航向气动数据各列代表变量说明
% 1 - H（高度）；2 - Ma（马赫数）；3 - C_y_beta；4 - C_l_beta（横向静稳定性指标，升力对侧滑角的导数）；
% 5 - C_n_beta（航向静稳定性指标，偏航力矩对侧滑角的导数）；6 - C_y_det_r；7 - C_l_det_r；
% 8 - C_n_det_r（方向舵操纵效率）；9 - C_l_det_a（操纵副翼操纵效率）；
% 10 - C_l_p（滚转阻尼动导数）；11 - C_n_r（偏航阻尼动导数）；12 - C_n_p（交叉阻尼动导数）；13 - C_l_r（交叉阻尼导数）

% 提取纵横航向状态的个数
LAD_num=length(LAD); % 纵向状态个数
LDAD_num=length(LDAD); % 横航向状态个数

%% Step 5: 计算给定飞行状态下的气动导数（利用插值方法）
% 纵向气动导数获取计算
Long_Num=8; % 纵向气动导数共有8个
H_LAD=[0,3,5,8,10]; % 纵向气动数据表格中给定高度集合
N_Ma_long=[5,6,7];
H1=H/1000;
times_long=(H1-H_LAD(end))/(H_LAD(end)-H_LAD(end-1));
Long_Com=zeros(length(H_LAD),Long_Num);
% Case 1: 若飞行高度在表格中给定集合中，则提取对应高度数据，再通过插值马赫数获得气动导数数据
% Case 2: 否则，采用两次插值（先插值马赫数，再插值高度）获得气动导数数据
% Case 1:
if (~isempty(find(H_LAD==H1,1)))
    % 步骤一：提取对应高度数据
    cnt=0;
    for i=1:LAD_num
        if (LAD(i,1)==H1)
            cnt=cnt+1;
            Long_Ori_Data(cnt,:)=LAD(i,:);
        end
    end
    % 步骤二：对Ma插值获得当前飞行状态下的各纵向气动导数
    if (Ma>max(LAD(:,2)))
        Long_Ma=Long_Ori_Data(:,2);
        Long_003=Long_Ori_Data(:,3);
        Long_004=Long_Ori_Data(:,4);
        Long_005=Long_Ori_Data(:,5);
        Long_006=Long_Ori_Data(:,6);
        Long_007=Long_Ori_Data(:,7);
        Long_008=Long_Ori_Data(:,8);
        Long_009=Long_Ori_Data(:,9);
        Long_010=Long_Ori_Data(:,10);
        C_l_alfa=interp1(Long_Ma(N_Ma_long),Long_003(N_Ma_long),Ma,'spline');
        C_m_Cl=interp1(Long_Ma(N_Ma_long),Long_004(N_Ma_long),Ma,'spline');
        C_m_det_e=interp1(Long_Ma(N_Ma_long),Long_005(N_Ma_long),Ma,'spline');
        C_l_det_e=interp1(Long_Ma(N_Ma_long),Long_006(N_Ma_long),Ma,'spline');
        C_m_q=interp1(Long_Ma(N_Ma_long),Long_007(N_Ma_long),Ma,'spline');
        C_m_alfa_dot=interp1(Long_Ma(N_Ma_long),Long_008(N_Ma_long),Ma,'spline');
        C_m_alfa=interp1(Long_Ma(N_Ma_long),Long_009(N_Ma_long),Ma,'spline');
        C_m0=interp1(Long_Ma(N_Ma_long),Long_010(N_Ma_long),Ma,'spline');     
    else
        C_l_alfa=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,3),Ma,'linear');
        C_m_Cl=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,4),Ma,'linear');
        C_m_det_e=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,5),Ma,'linear');
        C_l_det_e=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,6),Ma,'linear');
        C_m_q=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,7),Ma,'linear');
        C_m_alfa_dot=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,8),Ma,'linear');
        C_m_alfa=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,9),Ma,'linear');
        C_m0=interp1(Long_Ori_Data(:,2),Long_Ori_Data(:,10),Ma,'linear');      
    end
% Case 2:
else
    % 步骤一：对已知高度（H=0,3,5,8,10km）下在飞行马赫数状态进行插值，并合并数据
    for k=1:length(H_LAD)
        cnt=0;
        for i=1:LAD_num
            if (LAD(i,1)==H_LAD(k))
                cnt=cnt+1;
                Long_Data_k(cnt,:)=LAD(i,:);
            end
        end
        Long_Ma=Long_Data_k(:,2);
        for j=1:8
            if (Ma>max(Long_Ma))
                Long_para=Long_Data_k(:,(j+2));
                Long_Com(k,j)=interp1(Long_Ma(N_Ma_long),Long_para(N_Ma_long),Ma,'spline');
            else
                Long_Com(k,j)=interp1(Long_Ma,Long_Data_k(:,(j+2)),Ma,'linear');
            end            
        end
        clear Long_Data_k;
    end
    % 步骤二：对给定飞行高度状态进行插值（内插或外插），获得各个纵向气动导数
    if (H1>max(H_LAD))
        C_l_alfa=Long_Com(5,1)+(times_long*(Long_Com(5,1)-Long_Com(4,1)));
        C_m_Cl=Long_Com(5,2)+(times_long*(Long_Com(5,2)-Long_Com(4,2)));
        C_m_det_e=Long_Com(5,3)+(times_long*(Long_Com(5,3)-Long_Com(4,3)));
        C_l_det_e=Long_Com(5,4)+(times_long*(Long_Com(5,4)-Long_Com(4,4)));
        C_m_q=Long_Com(5,5)+(times_long*(Long_Com(5,5)-Long_Com(4,5)));
        C_m_alfa_dot=Long_Com(5,6)+(times_long*(Long_Com(5,6)-Long_Com(4,6)));
        C_m_alfa=Long_Com(5,7)+(times_long*(Long_Com(5,7)-Long_Com(4,7)));
        C_m0=Long_Com(5,8)+(times_long*(Long_Com(5,8)-Long_Com(4,8)));       
    else
        C_l_alfa=interp1(H_LAD,Long_Com(:,1)',H1,'linear');
        C_m_Cl=interp1(H_LAD,Long_Com(:,2)',H1,'linear');
        C_m_det_e=interp1(H_LAD,Long_Com(:,3)',H1,'linear');
        C_l_det_e=interp1(H_LAD,Long_Com(:,4)',H1,'linear');
        C_m_q=interp1(H_LAD,Long_Com(:,5)',H1,'linear');
        C_m_alfa_dot=interp1(H_LAD,Long_Com(:,6)',H1,'linear');
        C_m_alfa=interp1(H_LAD,Long_Com(:,7)',H1,'linear');
        C_m0=interp1(H_LAD,Long_Com(:,8)',H1,'linear');        
    end
end

% 横航向气动导数获取计算
Lat_Dir_Num=11; % 横航向气动导数共有11个
H_LDAD=[0,3,5,8]; % 横航向气动数据表格中给定高度集合
H2=H/1000;
times_lat=(H2-H_LDAD(end))/(H_LDAD(end)-H_LDAD(end-1));
N_Ma_lat=[5,6,7];
Lat_Dir_Com=zeros(length(H_LDAD),Lat_Dir_Num);
% Case 1: 若飞行高度在表格中给定集合中，则提取对应高度数据，再通过插值马赫数获得气动导数数据
% Case 2: 否则，采用两次插值（先插值马赫数，再插值高度）获得气动导数数据
% Case 1:
if (~isempty(find(H_LDAD==H2,1)))
    % 步骤一：提取对应高度数据
    cnt=0;
    for i=1:LDAD_num
        if (LDAD(i,1)==H2)
            cnt=cnt+1;
            Lat_Dir_Ori_Data(cnt,:)=LDAD(i,:);
        end
    end
    % 步骤二：对Ma插值获得当前飞行状态下的各纵向气动导数
    if (Ma>max(LDAD(:,2)))
        Lat_Ma=Lat_Dir_Ori_Data(:,2);
        Lat_003=Lat_Dir_Ori_Data(:,3);
        Lat_004=Lat_Dir_Ori_Data(:,4);
        Lat_005=Lat_Dir_Ori_Data(:,5);
        Lat_006=Lat_Dir_Ori_Data(:,6);
        Lat_007=Lat_Dir_Ori_Data(:,7);
        Lat_008=Lat_Dir_Ori_Data(:,8);
        Lat_009=Lat_Dir_Ori_Data(:,9);
        Lat_010=Lat_Dir_Ori_Data(:,10);
        Lat_011=Lat_Dir_Ori_Data(:,11);
        Lat_012=Lat_Dir_Ori_Data(:,12);
        Lat_013=Lat_Dir_Ori_Data(:,13);
        C_y_beta=interp1(Lat_Ma(N_Ma_lat),Lat_003(N_Ma_lat),Ma,'spline');
        C_l_beta=interp1(Lat_Ma(N_Ma_lat),Lat_004(N_Ma_lat),Ma,'spline');
        C_n_beta=interp1(Lat_Ma(N_Ma_lat),Lat_005(N_Ma_lat),Ma,'spline');
        C_y_det_r=interp1(Lat_Ma(N_Ma_lat),Lat_006(N_Ma_lat),Ma,'spline');
        C_l_det_r=interp1(Lat_Ma(N_Ma_lat),Lat_007(N_Ma_lat),Ma,'spline');
        C_n_det_r=interp1(Lat_Ma(N_Ma_lat),Lat_008(N_Ma_lat),Ma,'spline');
        C_l_det_a=interp1(Lat_Ma(N_Ma_lat),Lat_009(N_Ma_lat),Ma,'spline');
        C_l_p=interp1(Lat_Ma(N_Ma_lat),Lat_010(N_Ma_lat),Ma,'spline');
        C_n_r=interp1(Lat_Ma(N_Ma_lat),Lat_011(N_Ma_lat),Ma,'spline');
        C_n_p=interp1(Lat_Ma(N_Ma_lat),Lat_012(N_Ma_lat),Ma,'spline');
        C_l_r=interp1(Lat_Ma(N_Ma_lat),Lat_013(N_Ma_lat),Ma,'spline');
    else
        C_y_beta=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,3),Ma,'linear');
        C_l_beta=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,4),Ma,'linear');
        C_n_beta=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,5),Ma,'linear');
        C_y_det_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,6),Ma,'linear');
        C_l_det_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,7),Ma,'linear');
        C_n_det_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,8),Ma,'linear');
        C_l_det_a=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,9),Ma,'linear');
        C_l_p=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,10),Ma,'linear');
        C_n_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,11),Ma,'linear');
        C_n_p=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,12),Ma,'linear');
        C_l_r=interp1(Lat_Dir_Ori_Data(:,2),Lat_Dir_Ori_Data(:,13),Ma,'linear');
    end
% Case 2:
else
    % 步骤一：对已知高度（H=0,3,5,8km）下在飞行马赫数状态进行插值，并合并数据
    for k=1:length(H_LDAD)
        cnt=0;
        for i=1:LDAD_num
            if (LDAD(i,1)==H_LDAD(k))
                cnt=cnt+1;
                Lat_Dir_Data_k(cnt,:)=LDAD(i,:);
            end
        end
        Lat_Ma=Lat_Dir_Data_k(:,2);
        Lat_003=Lat_Dir_Data_k(:,3);
        Lat_004=Lat_Dir_Data_k(:,4);
        Lat_005=Lat_Dir_Data_k(:,5);
        Lat_006=Lat_Dir_Data_k(:,6);
        Lat_007=Lat_Dir_Data_k(:,7);
        Lat_008=Lat_Dir_Data_k(:,8);
        Lat_009=Lat_Dir_Data_k(:,9);
        Lat_010=Lat_Dir_Data_k(:,10);
        Lat_011=Lat_Dir_Data_k(:,11);
        Lat_012=Lat_Dir_Data_k(:,12);
        Lat_013=Lat_Dir_Data_k(:,13);
        Lat_Dir_Com(k,1)=interp1(Lat_Ma(N_Ma_lat),Lat_003(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,2)=interp1(Lat_Ma(N_Ma_lat),Lat_004(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,3)=interp1(Lat_Ma(N_Ma_lat),Lat_005(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,4)=interp1(Lat_Ma(N_Ma_lat),Lat_006(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,5)=interp1(Lat_Ma(N_Ma_lat),Lat_007(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,6)=interp1(Lat_Ma(N_Ma_lat),Lat_008(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,7)=interp1(Lat_Ma(N_Ma_lat),Lat_009(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,8)=interp1(Lat_Ma(N_Ma_lat),Lat_010(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,9)=interp1(Lat_Ma(N_Ma_lat),Lat_011(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,10)=interp1(Lat_Ma(N_Ma_lat),Lat_012(N_Ma_lat),Ma,'spline');
        Lat_Dir_Com(k,11)=interp1(Lat_Ma(N_Ma_lat),Lat_013(N_Ma_lat),Ma,'spline');
        clear Lat_Dir_Data_k;
    end
    % 步骤二：对给定飞行高度状态进行插值（内插或外插），获得各个纵向气动导数
    if (H2>max(H_LDAD))
        C_y_beta=Lat_Dir_Com(4,1)+(times_lat*(Lat_Dir_Com(4,1)-Lat_Dir_Com(3,1)));
        C_l_beta=Lat_Dir_Com(4,2)+(times_lat*(Lat_Dir_Com(4,2)-Lat_Dir_Com(3,2)));
        C_n_beta=Lat_Dir_Com(4,3)+(times_lat*(Lat_Dir_Com(4,3)-Lat_Dir_Com(3,3)));
        C_y_det_r=Lat_Dir_Com(4,4)+(times_lat*(Lat_Dir_Com(4,4)-Lat_Dir_Com(3,4)));
        C_l_det_r=Lat_Dir_Com(4,5)+(times_lat*(Lat_Dir_Com(4,5)-Lat_Dir_Com(3,5)));
        C_n_det_r=Lat_Dir_Com(4,6)+(times_lat*(Lat_Dir_Com(4,6)-Lat_Dir_Com(3,6)));
        C_l_det_a=Lat_Dir_Com(4,7)+(times_lat*(Lat_Dir_Com(4,7)-Lat_Dir_Com(3,7)));
        C_l_p=Lat_Dir_Com(4,8)+(times_lat*(Lat_Dir_Com(4,8)-Lat_Dir_Com(3,8)));
        C_n_r=Lat_Dir_Com(4,9)+(times_lat*(Lat_Dir_Com(4,9)-Lat_Dir_Com(3,9)));
        C_n_p=Lat_Dir_Com(4,10)+(times_lat*(Lat_Dir_Com(4,10)-Lat_Dir_Com(3,10)));
        C_l_r=Lat_Dir_Com(4,11)+(times_lat*(Lat_Dir_Com(4,11)-Lat_Dir_Com(3,11)));
    else
        C_y_beta=interp1(H_LDAD,Lat_Dir_Com(:,1)',H2,'linear');
        C_l_beta=interp1(H_LDAD,Lat_Dir_Com(:,2)',H2,'linear');
        C_n_beta=interp1(H_LDAD,Lat_Dir_Com(:,3)',H2,'linear');
        C_y_det_r=interp1(H_LDAD,Lat_Dir_Com(:,4)',H2,'linear');
        C_l_det_r=interp1(H_LDAD,Lat_Dir_Com(:,5)',H2,'linear');
        C_n_det_r=interp1(H_LDAD,Lat_Dir_Com(:,6)',H2,'linear');
        C_l_det_a=interp1(H_LDAD,Lat_Dir_Com(:,7)',H2,'linear');
        C_l_p=interp1(H_LDAD,Lat_Dir_Com(:,8)',H2,'linear');
        C_n_r=interp1(H_LDAD,Lat_Dir_Com(:,9)',H2,'linear');
        C_n_p=interp1(H_LDAD,Lat_Dir_Com(:,10)',H2,'linear');
        C_l_r=interp1(H_LDAD,Lat_Dir_Com(:,11)',H2,'linear');
    end
end

%% Step 6: 计算纵向系统矩阵A_long，纵向操纵矩阵B_long；横航向系统矩阵A_lat，横航向操纵矩阵B_lat
fprintf('【Part 3】 飞机的线化小扰动运动方程各系统与操纵矩阵计算结果\n');
fprintf('\n');

%% ① 纵向运动方程矩阵A_long与B_long计算
% 对插值得到的气动参数进行per度数(deg)-->per弧度(rad)的转化（对于所有关于角度的导数）
mk=(180/pi); % 定义转化因子
% 纵向气动参数转化
C_l_alfa=C_l_alfa*mk;
C_m_det_e=C_m_det_e*mk;
C_l_det_e=C_l_det_e*mk;
C_m_alfa=C_m_alfa*mk;
% 横航向气动参数转化
C_y_beta=C_y_beta*mk;
C_l_beta=C_l_beta*mk;
C_n_beta=C_n_beta*mk;
C_y_det_r=C_y_det_r*mk;
C_l_det_r=C_l_det_r*mk;
C_n_det_r=C_n_det_r*mk;
C_l_det_a=C_l_det_a*mk;

% 由于原数据中未给出阻力系数（极曲线）信息，故参考查阅米格-21/歼-7飞机参数
% 假设阻力极曲线为 CD = 0.012 + 0.07*CL^2 (CD = CD0 + k*CL^2)（0.025）
% 主要气动参数计算
W=m*g; % 飞机重量
L=W; % 水平定值
CL=L/(0.5*rou*V*V*S); % 升力系数计算
C_D0=0.012; % 零升阻力系数
ke=0.07; % 诱导阻力系数
CD=C_D0+ke*(CL^2); % 阻力系数计算
E=CL/CD; % 升阻比计算
C_D_det_e=0;

% 更多气动导数定义
C_D_u=0;
C_D_alfa_dot=0;
C_l_alfa_dot=0;
C_D_alfa=2*ke*CL*C_l_alfa;
C_D_q=0;
C_l_q=0;
C_l_u=0;
C_m_u=0;

% 定义新符号变量
m1=(2*m)/(rou*V*S);
c1=c_mean/(2*V);
q=0.5*rou*V*V;
qc=q;
Iy1=Iy/(qc*S*c_mean);

C_x_u=-(2*CD)-C_D_u;
C_x_alfa_dot=(-1)*C_D_alfa_dot;
C_z_alfa_dot=(-1)*C_l_alfa_dot;
C_x_alfa=CL-C_D_alfa;
C_x_q=(-1)*C_D_q;
C_z_q=(-1)*C_l_q;
C_x_theta=(-1)*CL*cos(theta);
C_z_alfa=(-1)*C_l_alfa+(-1)*CD;
C_x_det_e=(-1)*C_D_det_e;
C_z_theta=(-1)*CL*sin(theta);
C_z_u=(-2)*CL+(-1)*C_l_u;
C_z_det_e=(-1)*C_l_det_e;

Eps1=(C_x_alfa_dot*c1)/m1;
Eps2=(C_m_alfa_dot*c1)/m1;

% 计算纵向系统矩阵A_long各元素
A11_long=(C_x_u+(Eps1*C_z_u))/m1;
A12_long=(C_x_alfa+(Eps1*C_z_alfa))/m1;
A13_long=(C_x_q+Eps1*(m1+(C_z_q*c1)))/m1;
A14_long=(C_x_theta+(Eps1*C_z_theta))/m1;
A21_long=C_z_u/m1;
A22_long=C_z_alfa/m1;
A23_long=(m1+(C_z_q*c1))/m1;
A24_long=C_z_theta/m1;
A31_long=(C_m_u+(Eps2*C_z_u))/Iy1;
A32_long=(C_m_alfa+(Eps2*C_z_alfa))/Iy1;
A33_long=((C_m_q*c1)+(Eps2*(m1+(C_z_q*c1))))/Iy1;
A34_long=(Eps2*C_z_theta)/Iy1;
A41_long=0;
A42_long=0;
A43_long=1;
A44_long=0;

% 计算完整纵向系统矩阵A_long
fprintf('[3.1] 纵向运动方程主要系数矩阵如下：\n');
fprintf('\n');
fprintf('纵向系统矩阵A_long：\n');

A_long=[A11_long A12_long A13_long A14_long
        A21_long A22_long A23_long A24_long
        A31_long A32_long A33_long A34_long
        A41_long A42_long A43_long A44_long];
% 输出纵向系统矩阵A_long
A_long

% 计算纵向操纵矩阵B_long各元素
B11_long=(C_x_det_e+(Eps1*C_z_det_e))/m1;
B21_long=C_z_det_e/m1;
B31_long=(C_m_det_e+(Eps2*C_z_det_e))/Iy1;
B41_long=0;

% 计算完整纵向操纵矩阵B_long
fprintf('纵向操纵矩阵B_long：\n');

B_long=[B11_long
        B21_long
        B31_long
        B41_long];
% 输出纵向操纵矩阵B_long
B_long

%% ② 横航向运动方程矩阵A_lat与B_lat计算
% 定义新符号变量
C_y_phi=(m*g*cos(phi))/(q*S);
b1=b/(2*V);
Ix1=Ix/(qc*S*b);
Iz1=Iz/(qc*S*b);
Ixz1=Ixz/(qc*S*b);
Ix1_dot=Ix1/((Ix1*Iz1)-(Ixz1^2));
Iz1_dot=Iz1/((Ix1*Iz1)-(Ixz1^2));
Ixz1_dot=Ixz1/((Ix1*Iz1)-(Ixz1^2));
Eps3=Iz1_dot*C_l_beta;
Eps4=Ix1_dot*C_n_beta;

% 定义更多气动导数
C_y_p=0;
C_y_r=0;
C_y_det_a=0;
C_n_det_a=0;

% 计算横航向系统矩阵A_lat各元素
A11_lat=C_y_beta/m1;
A12_lat=C_y_phi/m1;
A13_lat=C_y_p*b1/m1;
A14_lat=(-1)*((m1-(b1*C_y_r))/m1);
A21_lat=0;
A22_lat=0;
A23_lat=1;
A24_lat=0;
A31_lat=(C_l_beta*Iz1_dot)+(C_n_beta*Ixz1_dot)+(b1*Eps3*A11_lat);
A32_lat=(Eps3*b1*A12_lat);
A33_lat=b1*((C_l_p*Iz1_dot)+(C_n_p*Ixz1_dot)+(Eps3*A13_lat));
A34_lat=b1*((C_l_r*Iz1_dot)+(C_n_r*Ixz1_dot)+(Eps3*A14_lat));
A41_lat=(Ix1_dot*C_n_beta)+(Ixz1_dot*C_l_beta)+(b1*Eps4*A11_lat);
A42_lat=Eps4*b1*A12_lat;
A43_lat=b1*((C_n_p*Ix1_dot)+(C_l_p*Ixz1_dot)+(Eps4*A13_lat));
A44_lat=b1*((Ix1_dot*C_n_r)+(Ixz1_dot*C_l_r)+(Eps4*A14_lat));

% 计算完整横航向系统矩阵A_lat
fprintf('[3.2] 横航向运动方程主要系数矩阵如下：\n');
fprintf('\n');
fprintf('横航向系统矩阵A_lat：\n');

A_lat=[A11_lat A12_lat A13_lat A14_lat
       A21_lat A22_lat A23_lat A24_lat
       A31_lat A32_lat A33_lat A34_lat
       A41_lat A42_lat A43_lat A44_lat];
% 输出横航向系统矩阵A_lat
A_lat

% 计算横航向操纵矩阵B_lat各元素
B11_lat=C_y_det_a/m1;
B12_lat=C_y_det_r/m1;
B21_lat=0;
B22_lat=0;
B31_lat=(C_l_det_a*Iz1_dot)+(C_n_det_a*Ixz1_dot)+(Eps3*b1*B11_lat);
B32_lat=(C_l_det_a*Iz1_dot)+(C_n_det_r*Ixz1_dot)+(Eps3*b1*B12_lat);
B41_lat=(C_n_det_a*Ix1_dot)+(C_l_det_a*Ixz1_dot)+(Eps4*b1*B11_lat);
B42_lat=(C_n_det_r*Ix1_dot)+(C_l_det_r*Ixz1_dot)+(Eps4*b1*B12_lat);

% 计算完整横航向操纵矩阵B_lat
fprintf('横航向操纵矩阵B_lat：\n');
B_lat=[B11_lat B12_lat
       B21_lat B22_lat
       B31_lat B32_lat
       B41_lat B42_lat];
% 输出横航向操纵矩阵B_lat
B_lat

%% Step 7: 计算short-period（短周期），roll-subsidence（滚转收敛）and Dutch-roll（荷兰滚）模态参数ζ_sp, ω_sp, CAP,and T_r,ζ_d, ω_d; 
%% ① 计算短周期（short-period）模态参数ζ_sp, ω_sp 与 CAP
% 计算A_long矩阵的特征值，判断纵向稳定性与各模态参数
fprintf('【Part 4】 飞机的纵向、横航向各特征模态分析\n');
fprintf('\n');
fprintf('[4.2] 飞机的纵向特征模态分析：\n');
fprintf('\n');
fprintf('纵向系统矩阵A_long的特征值为：\n');
A_long_eig=eig(A_long);
% 输出纵向系统矩阵A_long的特征值
A_long_eig
A_long_eig_real=real(A_long_eig); % 计算A_long矩阵特征值的实部
A_long_eig_imag=imag(A_long_eig); % 计算A_long矩阵特征值的虚部

% 由A_long矩阵的特征值（对应模态）计算结果获得对应重阻尼、高频的短周期模态
% 飞机纵向模态说明
% 【特征根 I】 一对较大共轭复根——对应短周期模态
Lambda_sp_1=A_long_eig(1);
Lambda_sp_2=A_long_eig(2);
fprintf('[纵向模态提取 I：短周期（short-period）模态]\n');
fprintf('\n');
fprintf('对应短周期模态的一对共轭复根 Lambda_sp = %.4f +(-) %.4fi\n',(real(Lambda_sp_1)),abs(imag(Lambda_sp_1)));
fprintf('\n');
Omega_sp=sqrt((real(Lambda_sp_1))^2+(imag(Lambda_sp_1))^2); % 短周期模态自由频率ω_sp
Zeta_sp=(-1)*real(Lambda_sp_1)/Omega_sp; % 短周期模态阻尼比ζ_sp
n_alfa=(1/(2*W))*rou*V*V*S*C_l_alfa;
CAP_sp=(Omega_sp^2)/n_alfa; % 短周期模态操纵期望参数CAP
fprintf('短周期模态 阻尼比（直接） ζ_sp = %.4f\n',Zeta_sp);
fprintf('短周期模态 自由频率（直接） ω_sp = %.4f\n',Omega_sp);
fprintf('短周期模态 操纵期望参数（直接） CAP = %.4f\n',CAP_sp);
fprintf('\n');

% 利用短周期近似计算模态特征参数
Omega_sp_appro=sqrt(((C_z_alfa*c1*C_m_q)/(m1*Iy1))-(C_m_alfa/Iy1));
Zeta_sp_appro=(-1)*(C_z_alfa/m1+(c1/Iy1)*(C_m_q+C_m_alfa_dot))/(2*sqrt(((C_z_alfa*c1*C_m_q)/(m1*Iy1))-(C_m_alfa/Iy1)));
CAP_sp_appro=(Omega_sp_appro^2)/n_alfa;
fprintf('短周期模态 阻尼比（近似） ζ_sp_appro = %.4f\n',Zeta_sp_appro);
fprintf('短周期模态 自由频率（近似） ω_sp_appro = %.4f\n',Omega_sp_appro);
fprintf('短周期模态 操纵期望参数（近似） CAP_appro = %.4f\n',CAP_sp_appro);
fprintf('\n');

% 短周期模态直接与近似计算模态特征参数误差比较
Omega_sp_error=(abs(Omega_sp-Omega_sp_appro))/(Omega_sp);
Zeta_sp_error=(abs(Zeta_sp-Zeta_sp_appro))/(Zeta_sp);
CAP_sp_error=(abs(CAP_sp-CAP_sp_appro))/(CAP_sp);
fprintf('短周期模态 阻尼比（近似与直接计算误差） ζ_sp_error = %.4f %%\n',Zeta_sp_error*100);
fprintf('短周期模态 自由频率（近似与直接计算误差） ω_sp_error = %.4f %%\n',Omega_sp_error*100);
fprintf('短周期模态 操纵期望参数（近似与直接计算误差） CAP_error = %.4f %%\n',CAP_sp_error*100);
fprintf('\n');

% 【特征根 II】 一对较小共轭复根——对应长周期模态（浮沉模态）
Lambda_p_1=A_long_eig(3);
Lambda_p_2=A_long_eig(4);
fprintf('[纵向模态提取 II：长周期（long-period/phugoid）模态]\n');
fprintf('\n');
fprintf('对应长周期模态的一对共轭复根 Lambda_p = %.4f +(-) %.4fi\n',(real(Lambda_p_1)),abs(imag(Lambda_p_1)));
fprintf('\n');
Omega_p=sqrt((real(Lambda_p_1))^2+(imag(Lambda_p_1))^2);
Zeta_p=(-1)*real(Lambda_p_1)/Omega_p;
fprintf('长周期模态 阻尼比（直接） ζ_p = %.4f\n',Zeta_p);
fprintf('长周期模态 自由频率（直接） ω_p = %.4f\n',Omega_p);
fprintf('\n');

%% ② 计算roll-subsidence（滚转收敛）and Dutch-roll（荷兰滚）模态参数 T_r,ζ_d, ω_d
% 计算A_lat矩阵的特征值，判断横航向稳定性与各模态参数
fprintf('[4.3] 飞机的横航向特征模态分析：\n');
fprintf('\n');
fprintf('横航向系统矩阵A_lat的特征值为：\n');
A_lat_eig=eig(A_lat);
% 输出横航向系统矩阵A_lat的特征值
A_lat_eig
A_lat_eig_real=real(A_lat_eig); % 计算A_lat矩阵特征值的实部
A_lat_eig_imag=imag(A_lat_eig); % 计算A_lat矩阵特征值的虚部

% 飞机横航向各模态说明
% 【特征根 I】 一个较大负实根——对应滚转收敛模态（响应快速）
Lambda_r=A_lat_eig(3);
fprintf('[横航向模态提取 I：滚转收敛（roll-subsidence）模态]\n');
fprintf('\n');
fprintf('对应滚转收敛模态（响应快速）的一个较大负实根 Lambda_r = %.4f\n',Lambda_r);
fprintf('\n');

% 计算roll-subsidence（滚转收敛）滚转收敛时间常数T_r
T_r=(-1)*(1/Lambda_r);
fprintf('滚转收敛模态 滚转收敛时间常数（直接） T_r = %.4f\n',T_r);
fprintf('\n');

% 利用滚转收敛近似计算模态特征参数
Lambda_r_appro=(C_l_p*b1)/Ix1;
T_r_appro=(-1)*(1/Lambda_r_appro);
fprintf('滚转收敛模态 滚转收敛时间常数（近似） T_r_appro = %.4f\n',T_r_appro);
fprintf('\n');

% 滚转收敛模态直接与近似计算模态特征参数误差比较
T_r_error=(abs(T_r-T_r_appro))/(T_r);
fprintf('滚转收敛模态 滚转收敛时间常数（近似与直接计算误差） T_r_error = %.4f %%\n',T_r_error*100);
fprintf('\n');

% 【特征根 II】 一对中等共轭复根——对应荷兰滚模态（响应中等）
Lambda_d_1=A_lat_eig(1);
Lambda_d_2=A_lat_eig(2);
fprintf('[横航向模态提取 II：荷兰滚（Dutch-roll）模态]\n');
fprintf('\n');
fprintf('对应荷兰滚模态（响应中等）的一对中等共轭复根 Lambda_d = %.4f +(-) %.4fi\n',(real(Lambda_d_1)),abs(imag(Lambda_d_1)));
fprintf('\n');

% 计算Dutch-roll（荷兰滚）ζ_d, ω_d
Omega_d=sqrt((real(Lambda_d_1))^2+(imag(Lambda_d_1))^2);
Zeta_d=(-1)*real(Lambda_d_1)/Omega_d;
Zeta_d_Omega_d=Omega_d*Zeta_d;
fprintf('荷兰滚模态 阻尼比（直接） ζ_d = %.4f\n',Zeta_d);
fprintf('荷兰滚模态 自由频率（直接） ω_d = %.4f\n',Omega_d);
fprintf('荷兰滚模态 阻尼比*自由频率（直接） ζ_d*ω_d = %.4f\n',Zeta_d_Omega_d);
fprintf('\n');

% 利用荷兰滚近似计算模态特征参数
Omega_d_appro=sqrt((1/(m1*Iz1))*((C_y_beta*C_n_r*b1)+C_n_beta*(m1-(b1*C_y_r))));
Zeta_d_appro=(-1)*(1/(2*Omega_d))*((C_y_beta/m1)+((b1*C_n_r)/Iz1));
Zeta_d_Omega_d_appro=Zeta_d_appro*Omega_d_appro;
fprintf('荷兰滚模态 阻尼比（近似） ζ_d_appro = %.4f\n',Zeta_d_appro);
fprintf('荷兰滚模态 自由频率（近似） ω_d_appro = %.4f\n',Omega_d_appro);
fprintf('荷兰滚模态 阻尼比*自由频率（近似） ζ_d*ω_d_appro = %.4f\n',Zeta_d_Omega_d_appro);
fprintf('\n');

%荷兰滚模态直接与近似计算模态特征参数误差比较
Omega_d_error=(abs(Omega_d-Omega_d_appro))/(Omega_d);
Zeta_d_error=(abs(Zeta_d-Zeta_d_appro))/(Zeta_d);
Zeta_d_Omega_d_error=(abs(Zeta_d_Omega_d-Zeta_d_Omega_d_appro))/(Zeta_d_Omega_d);
fprintf('荷兰滚模态 阻尼比（近似与直接计算误差） ζ_d_error = %.4f %%\n',Zeta_d_error*100);
fprintf('荷兰滚模态 自由频率（近似与直接计算误差） ω_d_error = %.4f %%\n',Omega_d_error*100);
fprintf('荷兰滚模态 阻尼比*自由频率（近似与直接计算误差） ζ_d*ω_d_error = %.4f %%\n',Zeta_d_Omega_d_error*100);
fprintf('\n');

% 【特征根 III】 一个较小负实根——对应螺旋模态（响应缓慢）
Lambda_s=A_lat_eig(4);
fprintf('[横航向模态提取 III：螺旋（spiral）模态]\n');
fprintf('\n');
fprintf('对应螺旋模态（响应缓慢）的一个较小负实根 Lambda_s = %.4f\n',Lambda_s);
fprintf('\n');

%% Question 2（飞行品质评估：Evaluate the flying quality for Category A flight phases;）
fprintf('【Question 2】 飞机飞行飞行品质评估：\n');
fprintf('\n');

%% Step 8：评估飞机在非场域A种飞行阶段的飞行品质（拓展功能plus）
% 定义需要评估飞行品质的对象信息
Flight_phases='A'; % 定义需要评估飞行品质的飞行阶段类型
Airplane_Class='IV'; % 定义需要评估飞行品质的飞机类型
fprintf('【Part 5】 定义需要评估飞行品质的对象信息如下：\n');
fprintf('需要评估飞行品质的飞行阶段类型为：%s级\n',Flight_phases);
fprintf('需要评估飞行品质的飞机类型为：%s级\n',Airplane_Class);
fprintf('\n');

% 【纵向飞行品质】评估
%  短周期模态品质要求评估（ζ_sp, ω_sp 与 CAP）
fprintf('【Part 6】 纵向飞行品质要求评估：\n');
fprintf('\n');
fprintf('[6.1] 短周期模态品质要求评估（ζ_sp, ω_sp 与 CAP）：\n');
fprintf('\n');

% ① 阻尼比ζ_sp要求
if ((Flight_phases=='A') || (Flight_phases=='C'))
    if ((Zeta_sp>=0.35) && (Zeta_sp<=1.30))
        Type_Zeta_sp='I';
    elseif ((Zeta_sp>=0.25) && (Zeta_sp<=2.00))
        Type_Zeta_sp='II';
    elseif (Zeta_sp>=0.15)
        Type_Zeta_sp='III';
    else
        Type_Zeta_sp='Unknown';
    end
else
    if ((Zeta_sp>=0.30) && (Zeta_sp<=2.00))
        Type_Zeta_sp='I';
    elseif ((Zeta_sp>=0.20) && (Zeta_sp<=2.00))
        Type_Zeta_sp='II';
    elseif (Zeta_sp>=0.15)
        Type_Zeta_sp='III';
    else
        Type_Zeta_sp='Unknown';
    end
end
fprintf('短周期模态 阻尼比 ζ_sp 等级为：%s级\n',Type_Zeta_sp);

% ② 操纵期望参数CAP要求
if (Flight_phases=='A')
    if ((CAP_sp>=0.28) && (CAP_sp<=3.60))
        Type_CAP_sp='I';
    elseif ((CAP_sp>=0.16) && (CAP_sp<=10.00))
        Type_CAP_sp='II';
    elseif (CAP_sp>=0.16)
        Type_CAP_sp='III';
    else
        Type_CAP_sp='Unknown';
    end
elseif (Flight_phases=='B')
    if ((CAP_sp>=0.085) && (CAP_sp<=3.60))
        Type_CAP_sp='I';
    elseif ((CAP_sp>=0.038) && (CAP_sp<=10.00))
        Type_CAP_sp='II';
    elseif (CAP_sp>=0.038)
        Type_CAP_sp='III';
    else
        Type_CAP_sp='Unknown';
    end
else
    if ((CAP_sp>=0.16) && (CAP_sp<=3.6))
        Type_CAP_sp='I';
    elseif ((CAP_sp>=0.096) && (CAP_sp<=10.00))
        Type_CAP_sp='II';
    elseif (CAP_sp>=0.096)
        Type_CAP_sp='III';
    else
        Type_CAP_sp='Unknown';
    end
end
fprintf('短周期模态 操纵期望参数CAP 等级为：%s级\n',Type_CAP_sp);
fprintf('\n');

% 短周期模态最终飞行品质评估
% 比较阻尼比ζ_sp与操纵期望参数CAP的等级，取等级较小者
if (length(Type_Zeta_sp)>length(Type_CAP_sp))
    Type_sp=Type_Zeta_sp;
else
    Type_sp=Type_CAP_sp;
end
fprintf('短周期模态 最终飞行品质评估 等级为：%s级\n',Type_sp);
fprintf('\n');

% 【横航向飞行品质】评估
%  滚转收敛模态品质要求评估（T_r）
fprintf('【Part 7】 纵向飞行品质要求评估：\n');
fprintf('\n');

% 滚转收敛时间常数T_r要求
fprintf('[7.1] 滚转收敛模态品质要求评估（T_r）：\n');
fprintf('\n');
if ((Flight_phases=='A') || (Flight_phases=='C'))
    if ((strcmp(Airplane_Class,'I')==1) || (strcmp(Airplane_Class,'IV')==1))
        if (T_r<=1.0)
            Type_T_r='I';
        elseif (T_r<=1.4)
            Type_T_r='II';
        elseif (T_r<=10.0)
            Type_T_r='III';
        else
            Type_T_r='Unknown';
        end
    else
        if (T_r<=1.0)
            Type_T_r='I';
        elseif (T_r<=1.4)
            Type_T_r='II';
        elseif (T_r<=10.0)
            Type_T_r='III';
        else
            Type_T_r='Unknown';
        end
    end
else
    if (T_r<=1.4)
        Type_T_r='I';
    elseif (T_r<=3.0)
        Type_T_r='II';
    elseif (T_r<=10.0)
        Type_T_r='III';
    else
        Type_T_r='Unknown';
    end
end
fprintf('滚转收敛模态 最终飞行品质评估 等级为：%s级\n',Type_T_r);
fprintf('\n');

% 横航向飞行品质：荷兰滚模态品质要求评估（ζ_d, ζ_d*ω_d, ω_d）
fprintf('[7.2] 荷兰滚模态品质要求评估（ζ_d, ζ_d*ω_d, ω_d）：\n');
fprintf('\n');
% ① 阻尼比ζ_d要求、ζ_d*ω_d要求、自然频率ω_d要求
if (Flight_phases=='A')
    if ((strcmp(Airplane_Class,'I')==1) || (strcmp(Airplane_Class,'IV')==1))
        if ((Zeta_d>=0.19) && (Zeta_d_Omega_d>=0.35) && (Omega_d>=1.0))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    else
        if ((Zeta_d>=0.19) && (Zeta_d_Omega_d>=0.35) && (Omega_d>=0.4))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    end
elseif (Flight_phases=='B')
    if ((Zeta_d>=0.08) && (Zeta_d_Omega_d>=0.15) && (Omega_d>=0.4))
        Type_dutch_roll='I';
    elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
        Type_dutch_roll='II';
    elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
        Type_dutch_roll='III';
    else
        Type_dutch_roll='Unknown';
    end
else
    if ((strcmp(Airplane_Class,'I')==1) || (strcmp(Airplane_Class,'II_C_b')==1) || (strcmp(Airplane_Class,'IV')==1))
        if ((Zeta_d>=0.08) && (Zeta_d_Omega_d>=0.15) && (Omega_d>=1.0))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    else
        if ((Zeta_d>=0.08) && (Zeta_d_Omega_d>=0.15) && (Omega_d>=0.4))
            Type_dutch_roll='I';
        elseif ((Zeta_d>=0.02) && (Zeta_d_Omega_d>=0.05) && (Omega_d>=0.4))
            Type_dutch_roll='II';
        elseif ((Zeta_d>=0.02) && (Omega_d>=0.4))
            Type_dutch_roll='III';
        else
            Type_dutch_roll='Unknown';
        end
    end
end
fprintf('荷兰滚模态 最终飞行品质评估 等级为：%s级\n',Type_dutch_roll);
fprintf('\n');
