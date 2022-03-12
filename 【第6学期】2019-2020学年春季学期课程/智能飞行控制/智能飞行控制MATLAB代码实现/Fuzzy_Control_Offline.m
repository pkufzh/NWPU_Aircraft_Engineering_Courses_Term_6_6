%% 《智能飞行控制》模糊控制器MATLAB代码实现（离线查询表）
%% 问题描述
% 假设E、EC和U的论域：{-6,-5,...,-1,0,1,...,5,6};
% E、EC和U定义了7个语言值{NB,NM,NS,Z,PS,PM,PB};
% 已给出各语言值的隶属度函数（采用三角函数），即矩阵Input_1_Terms_Membership、Input_2_Terms_Membership与Output_Terms_Membership（均相同）
% 已给出控制规则表，即关于语言值对应规则的矩阵Rule

%% 问题一：建立模糊控制器的模糊控制查询表（离线）
%% 程序初始化
clear all
clc

%% 步骤1：论域与语言值初始化
% 定义语言值（数字1~7分别对应7个语言值{NB,NM,NS,Z,PS,PM,PB}）
Input_1_Terms=[1,2,3,4,5,6,7];
Input_2_Terms=[1,2,3,4,5,6,7];
Output_Terms=[1,2,3,4,5,6,7];
Input_1=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6];
Input_2=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6];
Output=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6];
n_Terms=length(Input_1_Terms);

% 定义各语言值的隶属度函数（采用三角函数表）
Input_1_Terms_Membership=[1,0.5,0,0,0,0,0,0,0,0,0,0,0;
                          0,0.5,1,0.5,0,0,0,0,0,0,0,0,0;
                          0,0,0,0.5,1,0.5,0,0,0,0,0,0,0;
                          0,0,0,0,0,0.5,1,0.5,0,0,0,0,0;
                          0,0,0,0,0,0,0,0.5,1,0.5,0,0,0;
                          0,0,0,0,0,0,0,0,0,0.5,1,0.5,0;
                          0,0,0,0,0,0,0,0,0,0,0,0.5,1];
Input_2_Terms_Membership=Input_1_Terms_Membership;
Output_Terms_Membership=Input_1_Terms_Membership;
n_Membership=length(Input_1_Terms_Membership);

% 定义模糊控制规则表
Rule=[1,1,1,1,2,4,4;
      1,1,1,1,2,4,4;
      2,2,2,2,4,5,5;
      2,2,3,4,5,6,6;
      3,3,4,6,6,6,6;
      4,4,6,7,7,7,7;
      4,4,6,7,7,7,7];

%% 步骤2：总结模糊关系，构建关系矩阵R
% 初始化所有规则模糊关系的并集矩阵R
for i=1:(n_Membership^2)
    for j=1:n_Membership
        R(i,j)=0;
    end
end

% 构建所有规则模糊关系的并集矩阵R
for Input_1_Terms_Index=1:n_Terms
    for Input_2_Terms_Index=1:n_Terms
        % Input_1_Terms_Index代表输入E语言值的序号，Input_2_Terms_Index代表输入EC语言值的序号，Output_Terms_Index代表输出U语言值的序号
        Output_Terms_Index=Rule(Input_1_Terms_Index,Input_2_Terms_Index);
        A=Input_1_Terms_Membership(Input_1_Terms_Index,:); % A代表输入E的模糊值
        B=Input_2_Terms_Membership(Input_2_Terms_Index,:); % B代表输入EC的模糊值
        C=Output_Terms_Membership(Output_Terms_Index,:); % C代表输出U的模糊值
        for i=1:n_Membership
            for j=1:n_Membership
                R1(i,j)=min(A(i),B(j)); % R1 = A * B
            end
        end
        R2=[];
        for k=1:n_Membership
            R2=[R2;R1(k,:)']; % R2 = R1^T（转置合并为列）
        end
        for i=1:(n_Membership^2)
            for j=1:n_Membership
                R3(i,j)=min(R2(i),C(j)); % 创建模糊关系R3 = R2 * C
            end
        end     
        R=max(R,R3); % 构建所有规则模糊关系的并集矩阵R
    end
end

%% 步骤3：总结模糊查询表（离线）
% 注：对每种可能的E、EC的精确取值进行 a)模糊化;b)模糊推理;c)去模糊化 的运算过程可以得到模糊查询表Fuzzy_Table
for Input_1_Value_Index=1:n_Membership
    for Input_2_Value_Index=1:n_Membership

        % a) 模糊化操作
        % 注：Input_1_Value_Index表示输入E的精确值的序号
        %     Input_1_Value_Membership为E的精确值属于其各个模糊值的隶属度组成的向量
        Input_1_Value_Membership=Input_1_Terms_Membership(:,Input_1_Value_Index);
        % 注：Max_Input_1_Index表示隶属度最大的模糊值的序号
        %     Max_Input_1_Value为与之对应的隶属度
        [Max_Input_1_Value,Max_Input_1_Index]=max(Input_1_Value_Membership);
        % 注：Ad为与输入E的精确值相对应的隶属度最大的模糊值，也就是模糊化后的E的模糊值
        Ad=Input_1_Terms_Membership(Max_Input_1_Index,:);
        % 同理，可以得到输入EC模糊化后的模糊值Bd
        Input_2_Value_Membership=Input_2_Terms_Membership(:,Input_2_Value_Index);
        [Max_Input_2_Value,Max_Input_2_Index]=max(Input_2_Value_Membership);
        % 注：Bd为与输入EC的精确值相对应的隶属度最大的模糊值，也就是模糊化后的EC的模糊值
        Bd=Input_2_Terms_Membership(Max_Input_2_Index,:);
        
        % b) 模糊推理
        for i=1:n_Membership
            for j=1:n_Membership
                Rd1(i,j)=min(Ad(i),Bd(j)); % Rd1 = Ad * Bd
            end
        end
        Rd2=[];
        for k=1:n_Membership
            Rd2=[Rd2;Rd1(k,:)']; % Rd2 = Rd1^T（转置成列）
        end
        for j=1:n_Membership
            Cd(j)=max(min(Rd2,R(:,j))); % Cd = Rd2 o R，即Cd为模糊推理后得到的模糊输出
        end
        
        % c) 去模糊化
        sum1=0;
        sum2=0;
        for i=1:n_Membership
            sum1=sum1+Cd(i);
            sum2=sum2+Cd(i)*Output(i);
        end
        OUT=round(sum2/sum1);
        
        % 构建模糊查询表Fuzzy_Table
        Fuzzy_Table(Input_1_Value_Index,Input_2_Value_Index)=OUT;
        
    end
end
