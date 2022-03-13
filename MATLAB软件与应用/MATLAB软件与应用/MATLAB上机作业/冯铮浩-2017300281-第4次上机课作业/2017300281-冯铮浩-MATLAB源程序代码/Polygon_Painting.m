function Polygon_Painting(Para)
    % Function Name: Polygon_Painting 主要实现功能：根据不同输入量绘制正N边形
    % 输入：Para——正N边形的边数（应为大于2的自然数N）
    % 输出：带有正N边形的图案图窗
    % 函数程序编写人姓名：冯铮浩
    % 学号：2017300281
    
    % 核心条件语句实现
    if (~isempty(Para))
        % Case 2:输入量是大于2的自然数N时，绘制正N边形
        if ((Para>2) && (fix(Para)==Para))
            fprintf('输入值为大于2的自然数，绘制正%d边形如图：\n',Para);
            fprintf('\n');
            theta=0:((2*pi)/Para):(2*pi);
            [x,y]=pol2cart(theta,1);
            plot(x,y,'r-','LineWidth',2);
            xlabel('Coordinate \itx'),ylabel('Coordinate \ity');
            % 添加对应多边形边数的标题
            title(['Figure: 绘制正 ',num2str(Para),' 边形']);
            grid on;
            box on;
        else
            fprintf('错误：输入量非大于2的自然数！请重新输入！\n');
            fprintf('\n');
        end
    else
        % Case 1:没有输入量时，绘制单位圆
        fprintf('没有输入量，绘制单位圆如图：\n');
        fprintf('\n');
        theta=0:(pi/60):(2*pi);
        x=cos(theta);
        y=sin(theta);
        plot(x,y,'b-','LineWidth',2);
        xlabel('Coordinate \itx'),ylabel('Coordinate \ity'),title('Figure: 绘制单位圆');
        grid on;
        box on;
    end
end

