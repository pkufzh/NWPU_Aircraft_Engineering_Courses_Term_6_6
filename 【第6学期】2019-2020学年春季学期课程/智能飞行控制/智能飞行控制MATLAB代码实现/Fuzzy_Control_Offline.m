%% �����ܷ��п��ơ�ģ��������MATLAB����ʵ�֣����߲�ѯ��
%% ��������
% ����E��EC��U������{-6,-5,...,-1,0,1,...,5,6};
% E��EC��U������7������ֵ{NB,NM,NS,Z,PS,PM,PB};
% �Ѹ���������ֵ�������Ⱥ������������Ǻ�������������Input_1_Terms_Membership��Input_2_Terms_Membership��Output_Terms_Membership������ͬ��
% �Ѹ������ƹ��������������ֵ��Ӧ����ľ���Rule

%% ����һ������ģ����������ģ�����Ʋ�ѯ�����ߣ�
%% �����ʼ��
clear all
clc

%% ����1������������ֵ��ʼ��
% ��������ֵ������1~7�ֱ��Ӧ7������ֵ{NB,NM,NS,Z,PS,PM,PB}��
Input_1_Terms=[1,2,3,4,5,6,7];
Input_2_Terms=[1,2,3,4,5,6,7];
Output_Terms=[1,2,3,4,5,6,7];
Input_1=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6];
Input_2=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6];
Output=[-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6];
n_Terms=length(Input_1_Terms);

% ���������ֵ�������Ⱥ������������Ǻ�����
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

% ����ģ�����ƹ����
Rule=[1,1,1,1,2,4,4;
      1,1,1,1,2,4,4;
      2,2,2,2,4,5,5;
      2,2,3,4,5,6,6;
      3,3,4,6,6,6,6;
      4,4,6,7,7,7,7;
      4,4,6,7,7,7,7];

%% ����2���ܽ�ģ����ϵ��������ϵ����R
% ��ʼ�����й���ģ����ϵ�Ĳ�������R
for i=1:(n_Membership^2)
    for j=1:n_Membership
        R(i,j)=0;
    end
end

% �������й���ģ����ϵ�Ĳ�������R
for Input_1_Terms_Index=1:n_Terms
    for Input_2_Terms_Index=1:n_Terms
        % Input_1_Terms_Index��������E����ֵ����ţ�Input_2_Terms_Index��������EC����ֵ����ţ�Output_Terms_Index�������U����ֵ�����
        Output_Terms_Index=Rule(Input_1_Terms_Index,Input_2_Terms_Index);
        A=Input_1_Terms_Membership(Input_1_Terms_Index,:); % A��������E��ģ��ֵ
        B=Input_2_Terms_Membership(Input_2_Terms_Index,:); % B��������EC��ģ��ֵ
        C=Output_Terms_Membership(Output_Terms_Index,:); % C�������U��ģ��ֵ
        for i=1:n_Membership
            for j=1:n_Membership
                R1(i,j)=min(A(i),B(j)); % R1 = A * B
            end
        end
        R2=[];
        for k=1:n_Membership
            R2=[R2;R1(k,:)']; % R2 = R1^T��ת�úϲ�Ϊ�У�
        end
        for i=1:(n_Membership^2)
            for j=1:n_Membership
                R3(i,j)=min(R2(i),C(j)); % ����ģ����ϵR3 = R2 * C
            end
        end     
        R=max(R,R3); % �������й���ģ����ϵ�Ĳ�������R
    end
end

%% ����3���ܽ�ģ����ѯ�����ߣ�
% ע����ÿ�ֿ��ܵ�E��EC�ľ�ȷȡֵ���� a)ģ����;b)ģ������;c)ȥģ���� ��������̿��Եõ�ģ����ѯ��Fuzzy_Table
for Input_1_Value_Index=1:n_Membership
    for Input_2_Value_Index=1:n_Membership

        % a) ģ��������
        % ע��Input_1_Value_Index��ʾ����E�ľ�ȷֵ�����
        %     Input_1_Value_MembershipΪE�ľ�ȷֵ���������ģ��ֵ����������ɵ�����
        Input_1_Value_Membership=Input_1_Terms_Membership(:,Input_1_Value_Index);
        % ע��Max_Input_1_Index��ʾ����������ģ��ֵ�����
        %     Max_Input_1_ValueΪ��֮��Ӧ��������
        [Max_Input_1_Value,Max_Input_1_Index]=max(Input_1_Value_Membership);
        % ע��AdΪ������E�ľ�ȷֵ���Ӧ������������ģ��ֵ��Ҳ����ģ�������E��ģ��ֵ
        Ad=Input_1_Terms_Membership(Max_Input_1_Index,:);
        % ͬ�����Եõ�����ECģ�������ģ��ֵBd
        Input_2_Value_Membership=Input_2_Terms_Membership(:,Input_2_Value_Index);
        [Max_Input_2_Value,Max_Input_2_Index]=max(Input_2_Value_Membership);
        % ע��BdΪ������EC�ľ�ȷֵ���Ӧ������������ģ��ֵ��Ҳ����ģ�������EC��ģ��ֵ
        Bd=Input_2_Terms_Membership(Max_Input_2_Index,:);
        
        % b) ģ������
        for i=1:n_Membership
            for j=1:n_Membership
                Rd1(i,j)=min(Ad(i),Bd(j)); % Rd1 = Ad * Bd
            end
        end
        Rd2=[];
        for k=1:n_Membership
            Rd2=[Rd2;Rd1(k,:)']; % Rd2 = Rd1^T��ת�ó��У�
        end
        for j=1:n_Membership
            Cd(j)=max(min(Rd2,R(:,j))); % Cd = Rd2 o R����CdΪģ�������õ���ģ�����
        end
        
        % c) ȥģ����
        sum1=0;
        sum2=0;
        for i=1:n_Membership
            sum1=sum1+Cd(i);
            sum2=sum2+Cd(i)*Output(i);
        end
        OUT=round(sum2/sum1);
        
        % ����ģ����ѯ��Fuzzy_Table
        Fuzzy_Table(Input_1_Value_Index,Input_2_Value_Index)=OUT;
        
    end
end
