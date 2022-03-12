function f = myfactor(n)  %这是（主）函数
%MYFACTOR get n!
%input    : n
%output : f
if n<=1
    f = 1;
else
    f = myfactor(n-1)*n;  %递归调用求(n-1)!
end
myfactor_sub1(n,f)


function myfactor_sub1(x,y) %这是（子）函数，仅在本文件内部有效
fprintf('%d!=%d\n',x,y)
