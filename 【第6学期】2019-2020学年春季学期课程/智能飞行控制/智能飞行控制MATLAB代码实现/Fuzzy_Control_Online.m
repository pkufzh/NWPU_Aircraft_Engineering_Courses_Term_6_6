%% 《智能飞行控制》模糊控制器在线运行MATLAB代码实现
%% 问题描述
% 假设E、EC和U的论域：{-6,-5,...,-1,0,1,...,5,6};
% E、EC和U定义了7个语言值{NB,NM,NS,Z,PS,PM,PB};
% 给出各语言值的隶属度函数（采用三角函数），即矩阵Input_1_Terms_Membership、Input_2_Terms_Membership与Output_Terms_Membership（均相同）
% 给出控制规则表，即关于语言值对应规则的矩阵Rule

%% 问题二：给出模糊控制的在线运行代码
%% 程序初始化
clear all
clc

%% 模拟控制在线运行代码（已得到模糊关系表Fuzzy_Table）
e_k=refk-yk; % 计算第k个采样周期的误差和误差变化率
ec_k=(ek-ek1)/t;
E=round(ke*(ek-((eh+el)/2))); % 将E的论域转换到模糊控制器的论域
if (E>6)
    E=6;
elseif (E<-6)
    E=-6;
end
EC=round(kec*(eck-((ech+ecl)/2)));  % 将EC的论域转换到模糊控制器的论域
if (EC>6)
    EC=6;
elseif (EC<-6)
    EC=-6;
end
U=Fuzzy_Table(E+7,EC+7); % 查询模糊控制查询表得到输出值U
u=Ku*U+(uh+ul)/2; % 将输出转换到实际论域
