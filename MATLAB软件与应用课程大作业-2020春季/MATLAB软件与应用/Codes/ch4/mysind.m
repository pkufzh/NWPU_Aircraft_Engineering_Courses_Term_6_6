function [ y ] = mysind111( x )  %调用该函数时，应使用文件名mysind, 而不是这里的名字mysind111, 建议这两个名字一致
%   MYSIND this is a test function
%   to get y=sin(x degree) (-720~+720)
%                =0                    (other)
%   input:    x (degree)
%   output: y
% 该函数演示了在用户自建M函数文件内，可执行复杂的编程操作，
% 可调用其他用户自建M函数，也可调用系统内部函数
% 该函数的具体设置要求必须有输入参数，如果调用时不给输入就会出错
% 该函数的情况，是否能在菜单中用“运行”来执行
disp('My defined test function ''mysin''')
if x<720 & x>-720 %可执行复杂的编程操作，例如这里的if选择结构
    x=mydeg2rad(x) %可调用其他用户自建M函数
    y=sin(x);  % 可调用系统内部函数例如sin
else
    y=0;
end
end

