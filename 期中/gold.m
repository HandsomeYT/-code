syms x;
f(x) = x^2 + 4*cos(x);

beta = 0.618;
eta = 0.2;
a = 1;
b = 2;
t1 = 9;
t2 = 99;
count = 0;

while abs(t1 - t2) > eta
    t2 = a + (1 - beta) * (b - a);
    t1 = a + b - t2;
    if f(t1) < f(t2)
        a = t2;
    elseif f(t1) > f(t2)
        b = t1;
    elseif f(t1) == f(t2)
        a = t2;
        b = t1;
    end
    count = count + 1;
    fprintf("µÚ%d²½µü´ú: t1 = %f f(t1) = %f t2 = %f f(t2) = %f\n", count, t1, f(t1), t2, f(t2));
end
fprintf("t* = %f f(x)* = %f [t1, t2] = [%f, %f] ", (t1+t2)/2, f((t1+t2)/2), t2, t1);