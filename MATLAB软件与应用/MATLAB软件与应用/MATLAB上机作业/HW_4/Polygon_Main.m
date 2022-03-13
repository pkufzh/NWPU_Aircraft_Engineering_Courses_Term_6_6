function Polygon_Main
    % Function Name: Polygon_Main 主要实现功能：对第4次上机实验内容4绘制正N边形的函数M文件进行调用
    % 程序编写人姓名：冯铮浩
    % 学号：2017300281
    
    % 程序初始化
    clear all;clf;clc
    format long

    % 主程序编写
    while (1)
        % 从键盘输入（使用input函数）一个参数N
        Para=input('请输入参数N（如需退出程序，请输入-1）：');
        fprintf('\n');
        if (Para==-1)
            fprintf('程序运行结束！\n');
            fprintf('\n');
            break;
        else
            Polygon_Painting(Para);
        end
    end
end
