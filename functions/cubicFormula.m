function W = cubicFormula(a, x)
    if abs(x) <= 1
        W = (a + 2)*(abs(x)^3) - (a + 3)*(abs(x)^2) + 1;
    elseif abs(x) >= 2
        W = 0;
    else
        W = a*(abs(x)^3) - (5*a)*(abs(x)^2) + (8*a)*x - (4*a);
    end
end