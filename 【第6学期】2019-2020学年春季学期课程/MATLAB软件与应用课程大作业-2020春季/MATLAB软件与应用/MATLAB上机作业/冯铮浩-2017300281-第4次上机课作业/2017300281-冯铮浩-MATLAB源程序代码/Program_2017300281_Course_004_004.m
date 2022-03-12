%% MATLAB�����Ӧ�ã���4���ϻ�MATLAB����Դ���룺ʵ������4��
%% �ڿ���ʦ���ο���ʦ
%% ���������
%% ѧ�ţ�2017300281
%% ѧԺ������ѧԺ
%% ���ʱ�䣺2020��4��15��

%% MATLAB����Դ���루�������ע�ͱ�ע��
% �����ʼ��
clear all
clc
format long
fprintf('MATLAB�����Ӧ�ã���4���ϻ�MATLAB����Դ���룩\n');
fprintf('���������\n');
fprintf('ѧ�ţ�2017300281\n');
fprintf('ѧԺ������ѧԺ\n');
fprintf('���ʱ�䣺2020��4��15��\n');
fprintf('\n');
fprintf('ʵ������4�����н�����£�\n');
fprintf('\n');

%% Problem_004��ʵ������4������Kֵ��
while (1)
    % �Ӽ������루ʹ��input������һ������N
    Para=input('���������N�������˳�����������-1����');
    fprintf('\n');
    if (Para==-1)
        fprintf('�������н�����\n');
        fprintf('\n');
        break;
    end
    if (~isempty(Para))
        % Case 2:�������Ǵ���2����Ȼ��Nʱ��������N����
        if ((Para>2) && (fix(Para)==Para))
            fprintf('����ֵΪ����2����Ȼ����������%d������ͼ��\n',Para);
            fprintf('\n');
            theta=0:((2*pi)/Para):(2*pi);
            [x,y]=pol2cart(theta,1);
            plot(x,y,'r-','LineWidth',2);
    %         axis equal;
            xlabel('Coordinate \itx'),ylabel('Coordinate \ity');
            % ��Ӷ�Ӧ����α����ı���
            title(['Figure: ������ ',num2str(Para),' ����']);
            grid on;
            box on;
        else
            fprintf('�����������Ǵ���2����Ȼ�������������룡\n');
            fprintf('\n');
        end
    else
        % Case 1:û��������ʱ�����Ƶ�λԲ
        fprintf('û�������������Ƶ�λԲ��ͼ��\n');
        fprintf('\n');
        theta=0:(pi/60):(2*pi);
        x=cos(theta);
        y=sin(theta);
        plot(x,y,'b-','LineWidth',2);
        xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),title('Figure: ���Ƶ�λԲ');
        grid on;
        box on;
    end
end
