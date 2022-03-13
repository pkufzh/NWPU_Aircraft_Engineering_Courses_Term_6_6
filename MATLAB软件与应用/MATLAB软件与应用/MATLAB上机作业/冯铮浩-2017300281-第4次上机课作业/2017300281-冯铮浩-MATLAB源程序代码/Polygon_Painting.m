function Polygon_Painting(Para)
    % Function Name: Polygon_Painting ��Ҫʵ�ֹ��ܣ����ݲ�ͬ������������N����
    % ���룺Para������N���εı�����ӦΪ����2����Ȼ��N��
    % �����������N���ε�ͼ��ͼ��
    % ���������д�����������
    % ѧ�ţ�2017300281
    
    % �����������ʵ��
    if (~isempty(Para))
        % Case 2:�������Ǵ���2����Ȼ��Nʱ��������N����
        if ((Para>2) && (fix(Para)==Para))
            fprintf('����ֵΪ����2����Ȼ����������%d������ͼ��\n',Para);
            fprintf('\n');
            theta=0:((2*pi)/Para):(2*pi);
            [x,y]=pol2cart(theta,1);
            plot(x,y,'r-','LineWidth',2);
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

