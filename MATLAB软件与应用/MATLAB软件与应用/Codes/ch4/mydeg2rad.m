function [ y,z ] = mydeg2rad( x )
% MYDEG2RAD convert degree to radian
% 该例子表明，函数设置为需要输入时，
% 也能通过特殊方法，来处理没有输入情况
% 该函数的情况，可以在菜单中用“运行”来执行
% 但需要注意，返回值知否正常获取
if nargin==0  %特殊方法
    disp('no input, give pi/180 as output');
    y=pi/180;
    z=0;
else
    y=x/180*pi;
    z=0;
end
end
