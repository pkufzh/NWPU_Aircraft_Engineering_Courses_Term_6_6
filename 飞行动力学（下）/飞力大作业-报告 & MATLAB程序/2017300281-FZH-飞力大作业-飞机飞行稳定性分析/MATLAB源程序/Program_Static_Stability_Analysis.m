%% 《飞行动力学》（下）课程大作业
%% N0.1：飞机纵横航三轴静稳定性、操纵面效率分析
%% 问题描述
% 试根据表1与表2中的气动数据，绘制飞机纵横航三轴静稳定性、操纵面效率
% 随高度与马赫数的变化曲线，并对曲线变化趋势及造成该趋势的原因进行分析。

%% 个人信息
% 授课老师：刘艳老师
% 姓名：冯铮浩
% 学号：2017300281
% 学院：航空学院
% 完成时间：2020年5月1日

%% 程序初始化与数据导入
% 程序初始化
clear all
clc
format short;
fprintf('【个人信息】\n');
fprintf('《飞行动力学》（下）课程大作业\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('\n');
fprintf('【Problem 1】 飞机静稳定性、操纵面效率分析程序运行结果\n');
fprintf('\n');
fprintf('图形可视化结果见图窗 Figure 1 ~ 6：\n');
fprintf('\n');
fprintf('图1.1：飞机纵向静稳定性随马赫数Ma的变化曲线（不同海拔高度H）\n');
fprintf('图1.2：飞机纵向操纵面效率随马赫数Ma的变化曲线（不同海拔高度H）\n');
fprintf('图2.1：飞机航向静稳定性随马赫数Ma的变化曲线（不同海拔高度H）\n');
fprintf('图2.2：飞机航向操纵面效率随马赫数Ma的变化曲线（不同海拔高度H）\n');
fprintf('图3.1：飞机横向静稳定性随马赫数Ma的变化曲线（不同海拔高度H）\n');
fprintf('图3.2：飞机横向操纵面效率随马赫数Ma的变化曲线（不同海拔高度H）\n');
fprintf('\n');

% 导入飞机纵向与横航向气动数据
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
LAD_num=length(LAD);
LDAD_num=length(LDAD);

%% 程序模块①-->静稳定性分析：纵向静稳定性与纵向操纵面（升降舵Elevator）效率绘图分析
%% 步骤一：提取分析纵向静稳定性与纵向操纵面效率参数矩阵
% 预设飞行高度H的取值集合
Long_H_set=[0,3,5,8,10];
Long_Ma_Sta_Mat=zeros(5,7); % 设定对应状态马赫数矩阵
Long_Sta_Mat=zeros(5,7); % 设定纵向静稳定性状态矩阵
Long_Ctrl_Mat=zeros(5,7); % 设定对应状态升降舵操纵效率矩阵
Long_Mat_num=zeros(1,5);
for i=1:LAD_num
    k=find(Long_H_set==LAD(i,1)); % 记录飞机当前所在海拔高度的对应状态编号
    Long_Mat_num(1,k)=Long_Mat_num(1,k)+1; % 计数器加1
    Long_Sta_Mat(k,Long_Mat_num(1,k))=LAD(i,9); % 记录C_m_alfa
    Long_Ma_Sta_Mat(k,Long_Mat_num(1,k))=LAD(i,2); % 记录对应Ma
    Long_Ctrl_Mat(k,Long_Mat_num(1,k))=LAD(i,5); % 记录对应C_m_det_e
end

%% 步骤二：绘制飞机纵向静稳定性随马赫数的变化曲线（共5个高度）
plot(Long_Ma_Sta_Mat',Long_Sta_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('马赫数\itMa'),ylabel('C_{m\alpha}'),title('图1.1：飞机纵向静稳定性C_{m\alpha}随马赫数Ma的变化曲线（不同海拔高度H）');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','H = 10 km','FontName','Times New Roman');
grid on;
box on;

% 设置Y坐标范围
ylim(gca,[-0.012 0]);

% 对Y方向反转
set(gca,'YDir','reverse');

%% 步骤三：绘制飞机纵向操纵面效率随马赫数的变化曲线（共5个高度）
figure;
plot(Long_Ma_Sta_Mat',Long_Ctrl_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('马赫数\itMa'),ylabel('C_{m\delta{e}}'),title('图1.2：飞机纵向操纵面（升降舵）效率C_{m\delta{e}}随马赫数Ma的变化曲线（不同海拔高度H）');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','H = 10 km','FontName','Times New Roman');
grid on;
box on;
% 对Y方向反转
set(gca,'YDir','reverse');
% 设置Y坐标范围
ylim(gca,[-0.010 -0.004]);

%% 程序模块②-->静稳定性分析：航向静稳定性与航向操纵面（方向舵Rudder）效率绘图分析
%% 步骤一：提取分析航向静稳定性与航向操纵面效率参数矩阵
Dir_H_set=[0,3,5,8];
Dir_Ma_Sta_Mat=zeros(4,7); % 设定对应状态马赫数矩阵
Dir_Sta_Mat=zeros(4,7); % 设定航向静稳定性状态矩阵
Dir_Ctrl_Mat=zeros(4,7); % 设定对应状态方向舵操纵效率矩阵
Dir_Mat_num=zeros(1,4);
for i=1:LDAD_num
    k=find(Dir_H_set==LDAD(i,1)); % 记录飞机当前所在海拔高度的对应状态编号
    Dir_Mat_num(1,k)=Dir_Mat_num(1,k)+1; % 计数器加1
    Dir_Ma_Sta_Mat(k,Dir_Mat_num(1,k))=LDAD(i,2); % 记录对应Ma
    Dir_Sta_Mat(k,Dir_Mat_num(1,k))=LDAD(i,5); % 记录C_l_beta
    Dir_Ctrl_Mat(k,Dir_Mat_num(1,k))=LDAD(i,8); % 记录对应C_n_det_r
end

%% 步骤二：绘制飞机航向静稳定性随马赫数的变化曲线（共4个高度）
figure;
plot(Dir_Ma_Sta_Mat',Dir_Sta_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('马赫数\itMa'),ylabel('C_{n\beta}'),title('图2.1：飞机航向静稳定性C_{n\beta}随马赫数Ma的变化曲线（不同海拔高度H）');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;

%% 步骤三：绘制飞机航向操纵面效率随马赫数的变化曲线（共4个高度）
figure;
plot(Dir_Ma_Sta_Mat',Dir_Ctrl_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('马赫数\itMa'),ylabel('C_{n\delta{r}}'),title('图2.2：飞机航向操纵面（方向舵）效率C_{n\delta{r}}随马赫数Ma的变化曲线（不同海拔高度H）');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;
% 对Y方向反转
set(gca,'YDir','reverse');

%% 程序模块③-->静稳定性分析：横向静稳定性与横向操纵面（副翼Ailron）效率绘图分析
%% 步骤一：提取分析横向静稳定性与横向操纵面效率参数矩阵
Lat_H_set=[0,3,5,8];
Lat_Ma_Sta_Mat=zeros(4,7); % 设定对应状态马赫数矩阵
Lat_Sta_Mat=zeros(4,7); % 设定横向静稳定性状态矩阵
Lat_Ctrl_Mat=zeros(4,7); % 设定对应状态方向舵操纵效率矩阵
Lat_Mat_num=zeros(1,4);
for i=1:LDAD_num
    k=find(Lat_H_set==LDAD(i,1)); % 记录飞机当前所在海拔高度的对应状态编号
    Lat_Mat_num(1,k)=Lat_Mat_num(1,k)+1; % 计数器加1
    Lat_Ma_Sta_Mat(k,Lat_Mat_num(1,k))=LDAD(i,2); % 记录对应Ma
    Lat_Sta_Mat(k,Lat_Mat_num(1,k))=LDAD(i,4); % 记录C_n_beta
    Lat_Ctrl_Mat(k,Lat_Mat_num(1,k))=LDAD(i,9); % 记录对应C_l_det_a
end

%% 步骤二：绘制飞机横向静稳定性随马赫数的变化曲线（共4个高度）
figure;
plot(Lat_Ma_Sta_Mat',Lat_Sta_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('马赫数\itMa'),ylabel('C_{l\beta}'),title('图3.1：飞机横向静稳定性C_{l\beta}随马赫数Ma的变化曲线（不同海拔高度H）');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;
% 对Y方向反转
set(gca,'YDir','reverse');
% 设置Y坐标范围
ylim(gca,[-0.0018 0]);

%% 步骤三：绘制飞机横向操纵面效率随马赫数的变化曲线（共4个高度）
figure;
plot(Lat_Ma_Sta_Mat',Lat_Ctrl_Mat','LineWidth',2,'MarkerSize',3,'Marker','o');
xlabel('马赫数\itMa'),ylabel('C_{l\delta{a}}'),title('图3.2：飞机横向操纵面（方向舵）效率C_{l\delta{a}}随马赫数Ma的变化曲线（不同海拔高度H）');
legend('H = 0 km','H = 3 km','H = 5 km','H = 8 km','FontName','Times New Roman');
grid on;
box on;
% 对Y方向反转
set(gca,'YDir','reverse');
% 设置Y坐标范围
ylim(gca,[-0.0014 0]);
