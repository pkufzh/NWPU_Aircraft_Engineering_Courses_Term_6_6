function Polygon_Main
    % Function Name: Polygon_Main ��Ҫʵ�ֹ��ܣ��Ե�4���ϻ�ʵ������4������N���εĺ���M�ļ����е���
    % �����д�����������
    % ѧ�ţ�2017300281
    
    % �����ʼ��
    clear all;clf;clc
    format long

    % �������д
    while (1)
        % �Ӽ������루ʹ��input������һ������N
        Para=input('���������N�������˳�����������-1����');
        fprintf('\n');
        if (Para==-1)
            fprintf('�������н�����\n');
            fprintf('\n');
            break;
        else
            Polygon_Painting(Para);
        end
    end
end
