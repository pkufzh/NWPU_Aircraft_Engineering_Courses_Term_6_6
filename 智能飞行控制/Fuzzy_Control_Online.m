%% �����ܷ��п��ơ�ģ����������������MATLAB����ʵ��
%% ��������
% ����E��EC��U������{-6,-5,...,-1,0,1,...,5,6};
% E��EC��U������7������ֵ{NB,NM,NS,Z,PS,PM,PB};
% ����������ֵ�������Ⱥ������������Ǻ�������������Input_1_Terms_Membership��Input_2_Terms_Membership��Output_Terms_Membership������ͬ��
% �������ƹ��������������ֵ��Ӧ����ľ���Rule

%% �����������ģ�����Ƶ��������д���
%% �����ʼ��
clear all
clc

%% ģ������������д��루�ѵõ�ģ����ϵ��Fuzzy_Table��
e_k=refk-yk; % �����k���������ڵ��������仯��
ec_k=(ek-ek1)/t;
E=round(ke*(ek-((eh+el)/2))); % ��E������ת����ģ��������������
if (E>6)
    E=6;
elseif (E<-6)
    E=-6;
end
EC=round(kec*(eck-((ech+ecl)/2)));  % ��EC������ת����ģ��������������
if (EC>6)
    EC=6;
elseif (EC<-6)
    EC=-6;
end
U=Fuzzy_Table(E+7,EC+7); % ��ѯģ�����Ʋ�ѯ��õ����ֵU
u=Ku*U+(uh+ul)/2; % �����ת����ʵ������
