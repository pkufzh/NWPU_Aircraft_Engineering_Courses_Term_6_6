function [ y ] = mysind111( x )  %���øú���ʱ��Ӧʹ���ļ���mysind, ���������������mysind111, ��������������һ��
%   MYSIND this is a test function
%   to get y=sin(x degree) (-720~+720)
%                =0                    (other)
%   input:    x (degree)
%   output: y
% �ú�����ʾ�����û��Խ�M�����ļ��ڣ���ִ�и��ӵı�̲�����
% �ɵ��������û��Խ�M������Ҳ�ɵ���ϵͳ�ڲ�����
% �ú����ľ�������Ҫ�����������������������ʱ��������ͻ����
% �ú�����������Ƿ����ڲ˵����á����С���ִ��
disp('My defined test function ''mysin''')
if x<720 & x>-720 %��ִ�и��ӵı�̲��������������ifѡ��ṹ
    x=mydeg2rad(x) %�ɵ��������û��Խ�M����
    y=sin(x);  % �ɵ���ϵͳ�ڲ���������sin
else
    y=0;
end
end

