function f = myfactor(n)  %���ǣ���������
%MYFACTOR get n!
%input    : n
%output : f
if n<=1
    f = 1;
else
    f = myfactor(n-1)*n;  %�ݹ������(n-1)!
end
myfactor_sub1(n,f)


function myfactor_sub1(x,y) %���ǣ��ӣ����������ڱ��ļ��ڲ���Ч
fprintf('%d!=%d\n',x,y)
