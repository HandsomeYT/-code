global x1;
global x2;
global f;
syms x1 x2;
f = x1^2 + 4*x2^2;
X_k = [1 1];
e = 0.01;
P_k = - gradient(X_k);
count = 0;

while 1
    count = count + 1;
    fprintf("\n第%d次迭代:\n", count);
    if count == 1
        fprintf("选取初始点: X = ");
        disp(X_k);
        fprintf("P_k = ")
        disp(P_k);
    end
    t = oneDimSearch(X_k(1), X_k(2), P_k(1), P_k(2));
    X_k = getNext_X(X_k, t, P_k);
    if norm(gradient(X_k)) <= e
        fprintf("||g(X)||=%f <= e=%f 迭代完成!\n", norm(gradient(X_k)), e);
        fprintf("最优解 = ");
        disp(X_k);
        fprintf("最优值 = %f", vpa(subs(f, [x1 x2], [X_k(1) X_k(2)])));
        break;
    end
    lamda = (norm(gradient(X_k)))^2 / (norm(gradient(X_k - t*P_k)))^2;
    P_k = -gradient(X_k) + lamda*P_k;
    fprintf("X_k = ");
    disp(X_k);
    fprintf("g(X) = ");
    disp(gradient(X_k));
    fprintf("P_k+1=");
    disp(P_k);
    fprintf("t = %f lamda = %f ||g(X)|| = %f ", t, lamda, norm(gradient(X_k)));
end


function [y] = oneDimSearch(a1, a2, b1, b2)
global f;
beta = 0.618;
eta = 0.2;
a = -3;
b = 5;
t1 = 9;
t2 = 99;
count = 0;
while abs(t1 - t2) > 0.0001
    t2 = a + (1 - beta) * (b - a);
    t1 = a + b - t2;
    if(func(a1, a2, b1, b2, t1) < func(a1, a2, b1, b2, t2))
        a = t2;
    elseif(func(a1, a2, b1, b2, t1) > func(a1, a2, b1, b2, t2))
        b = t1;
    elseif(func(a1, a2, b1, b2, t1) == func(a1, a2, b1, b2, t2))
        a = t2;
        b = t1;
    count = count + 1;
    end
    y = (t1 + t2) / 2;
end
end

function [y] = gradient(X)
global f x1 x2;
g1 = vpa(subs(diff(f,x1),[x1,x2],[X(1),X(2)]));
g2 = vpa(subs(diff(f,x2),[x1,x2],[X(1),X(2)]));
y = [g1 g2];
end

function [y] = func(a1, a2, b1, b2, x)
y = (a1 + b1*x)^2 + 4*(a2 + b2*x)^2;
end

function [y] = getNext_X(X_pre, t_k, P_k)
y = X_pre + t_k * P_k;
end