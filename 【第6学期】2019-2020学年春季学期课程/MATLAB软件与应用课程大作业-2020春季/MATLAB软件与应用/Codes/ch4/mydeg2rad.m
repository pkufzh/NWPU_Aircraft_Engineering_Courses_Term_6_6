function [ y,z ] = mydeg2rad( x )
% MYDEG2RAD convert degree to radian
% �����ӱ�������������Ϊ��Ҫ����ʱ��
% Ҳ��ͨ�����ⷽ����������û���������
% �ú���������������ڲ˵����á����С���ִ��
% ����Ҫע�⣬����ֵ֪��������ȡ
if nargin==0  %���ⷽ��
    disp('no input, give pi/180 as output');
    y=pi/180;
    z=0;
else
    y=x/180*pi;
    z=0;
end
end
