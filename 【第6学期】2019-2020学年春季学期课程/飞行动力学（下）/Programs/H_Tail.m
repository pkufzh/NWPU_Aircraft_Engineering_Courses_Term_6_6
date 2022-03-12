% 平尾剪刀图
% 根据重心与平尾面积比的关系，确定平尾尺寸与重心位置
% 所有参数的单位均采用国际标准单位制

%% 输入原始数据
m = 21800;        % 飞机重量
g = 9.81;         % 重力加速度
Iy  = 450000;     % 俯仰惯性矩
lh  = 12.48;      % 平尾力臂
cbar = 2.811;     % 机翼平均气动弦长
cebar = 1.93*0.33;% 升降舵平均气动弦长
x_ac = 0.25;      % 翼身组合体焦点相对位置
S = 74.98;        % 机翼面积
kq = 0.9;         % 速度阻滞系数
ea = 0.15;        % 平尾下洗导数
CLawb = 3.8;      % 翼身组合体升力线斜率
CL0 = 0.2;        % 零迎角升力系数
CLha = 3.0;       % 平尾升力线斜率
Se_Sh = 0.3;      % 升降舵与平尾面积之比
Chd = -0.42;      % 铰链力矩相对操纵面偏角的导数
Cha = -0.24;      % 铰链力矩相对迎角的导数
G = 0.4;          % 传动比
Vtr = 200;        % 计算飞行状态的飞行速度
rho = 1.255*0.5;  % 计算飞行状态的大气密度
iw = 3/57.3;      % 机翼安装角

%% 飞行品质要求
Knmin = 0.016*lh/cbar;       % 握杆静稳定裕度
dFe_dvmin = 0.15*9.81;       % 杆力速度梯度最小值
dFe_dvmax = 36/0.7/63*9.81;  % -----------最大值
Kmmin = 0.1;                 % 握杆机动裕度
dFe_dnmin = 2.7*9.81;        % 杆力过载梯度最小值
dFe_dnmax = 54.48*9.81;      % -----------最大值
zetamin  = 0.35;             % 短周期阻尼比
CAPmin = 0.085;              % 操纵期望参数

%% 握杆静稳定性
% 对应重心后限
Sbar = [0:0.025:0.5];                           % 平尾相对面积，绘制剪刀图用
CLa = CLawb + kq*(1-ea)*Sbar*CLha;              % 全机升力线斜率
Xn = x_ac + kq*(1-ea)*lh/cbar * Sbar*CLha./CLa;  % 握杆中性点
Xcg1 = Xn - Knmin;                              % 握杆静稳定性对应的重心位置
plot(Xcg1,Sbar,'b-')
axis([0 1 0 0.5])             

%% 松杆静稳定
% 对应1个重心前限和1个重心后限
CLha1 = CLha *(1- Cha/Chd*sqrt(Se_Sh));          % 松杆时平尾的升力线斜率
CLa1 = CLa - CLha1*kq*(1-ea).*Sbar;              % 松杆时的升力线斜率
CLhd = CLha * sqrt(Se_Sh);
Xn1 = x_ac+kq*(1-ea)*Sbar*lh/cbar * CLha1./CLa1; % 松杆中性点
Xcg2min = Xn1 + dFe_dvmin*Vtr*lh*CLhd/(2*m*g*cbar*G*cebar*Chd)/Se_Sh; % 松杆静稳定性对应的重心位置1，后限
Xcg2max = Xn1 + dFe_dvmax*Vtr*lh*CLhd/(2*m*g*cbar*G*cebar*Chd)/Se_Sh; % 松杆静稳定性对应的重心位置2，前限
plot(Xcg2min,Sbar,'b--',Xcg2max,Sbar,'b.-')
axis([0 1 0 0.5])

%% 握杆机动性
% 重心后限
Xm = Xn + 0.55*rho*S*lh*lh*CLha/m/cbar*Sbar;    % 握杆机动点
Xcg3 = Xm - Kmmin;                              % 握杆机动性对应的重心位置
plot(Xcg3,Sbar,'r-')
axis([0 1 0 0.5])

%% 松杆机动性
% 对应1个重心前限和1个重心后限
Xm1 = Xn1 + 0.55*rho*S*lh*lh*CLha1/m/cbar*Sbar; % 松杆机动点
Xcg4min = Xm1 + dFe_dnmin*lh*CLhd/(m*g*cebar*cbar*Se_Sh*G*Chd); % 松杆机动性对应的重心位置1，后限
Xcg4max = Xm1 + dFe_dnmax*lh*CLhd/(m*g*cebar*cbar*Se_Sh*G*Chd); % 松杆机动性对应的重心位置2，前限
plot(Xcg4min,Sbar,'r--',Xcg4max,Sbar,'r.-')
axis([0 1 0 0.5])

%% 短周期阻尼比
% 重心后限
Ky2 = Iy/(m*cbar*cbar);     % 俯仰惯性矩的无因次量   
muc = 2*m/(rho*S*cbar);     % 纵向相对密度 
damp = (Ky2*CLa + 1.1*CLha.*Sbar*(lh/cbar)*(lh/cbar)*(1+ea)).^2./(8*Ky2*muc*CLa*zetamin*zetamin);
Xcg5 = Xm - damp;           % 短周期阻尼比要求对应的重心位置
plot(Xcg5,Sbar,'m-')
axis([0 1 0 0.5])

%% 期望操纵参数
% 重心后限
Xcg6 = Xm - CAPmin*Iy/(m*g*cbar);  % CAP要求所对应的重心位置
plot(Xcg6,Sbar,'c-*') 
axis([0 1 0 0.5])

%% 飞机失速要求
% 重心前限
Cmac = 0.15;            % 翼身组合体焦点处的俯仰力矩系数
alfa = 15/57.3;         % 失速迎角
de = -19/57.3;          % 升降舵最大上偏角
eaS=0.4;                % 失速迎角附近的下洗系数
CLh = CLha*(alfa*(1-eaS)+0.6*de); % 假定CLhd=0.6*CLha
CLmax = 1.2;            % 翼身组合体最大升力系数
Xcg7 = x_ac - (Cmac-CLh*kq*Sbar*lh/cbar)./(CLmax+CLh*kq*Sbar);  % 飞机失速要求对应的重心位置
plot(Xcg7,Sbar,'g-s') 
axis([0 1 0 0.5])

%% 起飞抬前轮
% 重心前限
Cmac0 = 0.15;
Xg = 12.67;         % 主起落架距机头位置，m
Xh = 23;            % 平尾距机头位置无原始数据，随便取的，m
T = 2*2200*9.8;     % 发动机推力,双发
Zcg = 2;            % 重心距主起落架的高度，m
ZT = 0.3;           % 发动机距重心高度，发动机在重心之下为正
nh = kq*(Xh-Xg)/lh; % 尾翼效率因子1
thetaRdot = 5/57.3; % 起飞抬前轮的俯仰角速度
VS = 63;            % 失速速度
VR = 1.05*VS;       % 起飞抬前轮速度
alfa = 3/57.3;      % 抬前轮时迎角
CLh = CLhd*de+CLha*alfa*(1-ea);  %抬头时平尾负升力
nq = 1 + CLha/CLh*thetaRdot*(Xh-Xg)/VR; % 尾翼效率因子2
CLR = CL0+(alfa+iw)*CLa;  % 抬前轮时的升力系数，不会太大
X25 = Xg - 0.8;     % 焦点距机头位置
Xc = 11;            % 平均气动弦前缘距机头距离
Xcg8 = lh*CLh*nq*nh/(CLmax*0.907*cbar)*Sbar+(Xg/cbar+T*(Zcg-ZT)/(m*g*cbar))-(Cmac0+CLR*(Xg-X25)/cbar)/CLmax/0.907-Xc/cbar;
plot(Xcg8,Sbar,'k-s') 
axis([0 1 0 0.5])

%% 进场与复飞
% 重心前限
ahmin = -0.25;    % 平尾失速迎角(负迎角)
Xcg9 = x_ac+1/0.7*(nh*CLha*lh/cbar*(ahmin/CLmax+0.39*(1-eaS)./CLa).*Sbar-Cmac/CLmax);
plot(Xcg9,Sbar,'b-s') 
axis([0 1 0 0.5])

%% 着陆拉平 
% 重心前限
Cmac0 = 0.15;
Xg = 12.67;         % 主起落架距机头位置
Xh = 23;            % 无原始数据，随便取的
nh = kq*(Xh-Xg)/lh; % 尾翼效率因子1
thetaRdot = 5/57.3;
VS = 63;            % 失速速度,m/s
VT = 1.3*VS;
alfa = 6/57.3;
CLh = CLhd*de+CLha*alfa*(1-ea);  %接地时平尾负升力
nq = 1 + CLha/CLh*thetaRdot*(Xh-Xg)/VR; % 尾翼效率因子2
CLT = CL0+(alfa+iw)*CLa;  %接地时的升力系数
X25 = Xg - 0.8;  %焦点距机头位置
Xc = 11;
Xcg10 = lh*CLh*nq*nh/(CLmax*0.907*cbar)*Sbar+Xg/cbar-(Cmac0+CLT*(Xg-X25)/cbar)/CLmax/0.907-Xc/cbar;
plot(Xcg10,Sbar,'c-+')
axis([0 1 0 0.5])

%% 完整剪刀图
% plot(Xcg1,Sbar,'b-',  Xcg2min,Sbar,'b--',  Xcg2max,Sbar,'b.-',  Xcg3,Sbar,'r-',  Xcg4min,Sbar,'r--',  Xcg4max,Sbar,'r.-',...
%      Xcg5,Sbar,'m-',  Xcg6,Sbar,'c-',  Xcg7,Sbar,'g-s',  Xcg8,Sbar,'k-s',  Xcg9,Sbar,'b-s',  Xcg10,Sbar,'c-+')
plot(Xcg1,Sbar,'b-',  Xcg2min,Sbar,'b--',  Xcg2max,Sbar,'b.-',  Xcg3,Sbar,'r-',  Xcg4min,Sbar,'r--',  Xcg4max,Sbar,'r.-',...
     Xcg8,Sbar,'k-s', Xcg10,Sbar,'c-+')
axis([0 1 0 0.5])

%{
title('平尾剪刀图');
text(0.5,0.08,'不带符号的曲线表示重心后限')
text(0.5,0.055,'带符号的曲线表示重心前限')
text(0.5,0.03,'所包围的即为满足要求的区域')
%}