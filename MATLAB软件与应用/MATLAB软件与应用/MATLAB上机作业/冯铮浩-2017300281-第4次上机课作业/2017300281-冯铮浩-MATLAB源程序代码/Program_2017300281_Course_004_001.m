%% MATLAB�����Ӧ�ã���4���ϻ�MATLAB����Դ���룺ʵ������1��
%% �ڿ���ʦ���ο���ʦ
%% ���������
%% ѧ�ţ�2017300281
%% ѧԺ������ѧԺ
%% ���ʱ�䣺2020��4��15��

%% MATLAB����Դ���루�������ע�ͱ�ע��
% �����ʼ��
clear all
clc
format short
fprintf('MATLAB�����Ӧ�ã���4���ϻ�MATLAB����Դ���룩\n');
fprintf('���������\n');
fprintf('ѧ�ţ�2017300281\n');
fprintf('ѧԺ������ѧԺ\n');
fprintf('���ʱ�䣺2020��4��15��\n');
fprintf('\n');
fprintf('ʵ������1�����н�����£�\n');
fprintf('\n');

%% Problem_001��ʵ������1��
while (1)
    % �Ӽ������루ʹ��input������һ���ٷ��Ƴɼ�
    score=input('������һ���ٷ��Ƴɼ��������˳�����������-1����');
    if (score==-1)
        fprintf('\n');
        fprintf('�������н�����\n');
        fprintf('\n');
        break;
    end
    %% ����һ������if�������ʵ��Ҫ��
    fprintf('\n');
    fprintf('����һ������if�������ʵ��Ҫ��\n');
    if (score>=0 && score<=100)
        if (score>=90)
            disp('������ĳɼ��ȼ�Ϊ��A');
        elseif (score>=80)
            disp('������ĳɼ��ȼ�Ϊ��B');
        elseif (score>=70)
            disp('������ĳɼ��ȼ�Ϊ��C');
        elseif (score>=60)
            disp('������ĳɼ��ȼ�Ϊ��D');
        else
            disp('������ĳɼ��ȼ�Ϊ��E');
        end
    else
        disp('����ĳɼ���������0~100֮�䣡���������룡');
    end
    fprintf('\n');

    %% ������������switch�������ʵ��Ҫ��
    fprintf('������������switch�������ʵ��Ҫ��\n');
    switch (score)
        case num2cell(90:100)
            disp('������ĳɼ��ȼ�Ϊ��A');
        case num2cell(80:89)
            disp('������ĳɼ��ȼ�Ϊ��B');
        case num2cell(70:79)
            disp('������ĳɼ��ȼ�Ϊ��C');
        case num2cell(60:69)
            disp('������ĳɼ��ȼ�Ϊ��D');
        case num2cell(0:59)
            disp('������ĳɼ��ȼ�Ϊ��E');
        otherwise
            disp('����ĳɼ���������0~100֮�䣡���������룡');
    end
    fprintf('\n');
end