%% MATLAB软件与应用（第4次上机MATLAB程序源代码：实验内容1）
%% 授课老师：宋科老师
%% 姓名：冯铮浩
%% 学号：2017300281
%% 学院：航空学院
%% 完成时间：2020年4月15日

%% MATLAB程序源代码（题号已用注释标注）
% 程序初始化
clear all
clc
format short
fprintf('MATLAB软件与应用（第4次上机MATLAB程序源代码）\n');
fprintf('姓名：冯铮浩\n');
fprintf('学号：2017300281\n');
fprintf('学院：航空学院\n');
fprintf('完成时间：2020年4月15日\n');
fprintf('\n');
fprintf('实验内容1的运行结果如下：\n');
fprintf('\n');

%% Problem_001（实验内容1）
while (1)
    % 从键盘输入（使用input函数）一个百分制成绩
    score=input('请输入一个百分制成绩（如需退出程序，请输入-1）：');
    if (score==-1)
        fprintf('\n');
        fprintf('程序运行结束！\n');
        fprintf('\n');
        break;
    end
    %% 方法一：利用if条件语句实现要求
    fprintf('\n');
    fprintf('方法一：利用if条件语句实现要求\n');
    if (score>=0 && score<=100)
        if (score>=90)
            disp('您输入的成绩等级为：A');
        elseif (score>=80)
            disp('您输入的成绩等级为：B');
        elseif (score>=70)
            disp('您输入的成绩等级为：C');
        elseif (score>=60)
            disp('您输入的成绩等级为：D');
        else
            disp('您输入的成绩等级为：E');
        end
    else
        disp('输入的成绩不满足在0~100之间！请重新输入！');
    end
    fprintf('\n');

    %% 方法二：利用switch条件语句实现要求
    fprintf('方法二：利用switch条件语句实现要求\n');
    switch (score)
        case num2cell(90:100)
            disp('您输入的成绩等级为：A');
        case num2cell(80:89)
            disp('您输入的成绩等级为：B');
        case num2cell(70:79)
            disp('您输入的成绩等级为：C');
        case num2cell(60:69)
            disp('您输入的成绩等级为：D');
        case num2cell(0:59)
            disp('您输入的成绩等级为：E');
        otherwise
            disp('输入的成绩不满足在0~100之间！请重新输入！');
    end
    fprintf('\n');
end