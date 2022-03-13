function eq = myeq001(f)
    x=f(1);
    y=f(2);
    eq(1)=x^3-y^2;
    eq(2)=exp(-x)-y;
end

options = optimoptions('fsolve','FiniteDifferenceType','central');