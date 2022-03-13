%% MATLAB软件与应用（第4次上机MATLAB程序源代码：实验内容4）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月15日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format long
fprintf('MATLAB软件与应用（第4次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月15日\n');
fprintf('\n');
fprintf('实验内容4的运行结果如下：\n');
fprintf('\n');

%% Problem_004（实验内容4，计算K值）
while (1)
    % 从键盘输入（使用input函数）一个参数N
    Para=input('请输入参数N（如需退出程序，请输入-1）：');
    fprintf('\n');
    if (Para==-1)
        fprintf('程序运行结束！\n');
        fprintf('\n');
        break;
    end
    if (~isempty(Para))
        % Case 2:输入量是大于2的自然数N时，绘制正N边形
        if ((Para>2) && (fix(Para)==Para))
            fprintf('输入值为大于2的自然数，绘制正%d边形如图：\n',Para);
            fprintf('\n');
            theta=0:((2*pi)/Para):(2*pi);
            [x,y]=pol2cart(theta,1);
            plot(x,y,'r-','LineWidth',2);
    %         axis equal;
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
