syms x1 x2;
global f x1 x2;
f = 1/4 * x1^2  + 1/2 * x2^2 - x1*x2 + x1 - x2;
X_k = [1.5 1].';
H_k = [1 0;0 1];
g_k = gradient(X_k);
P_k = -g_k;
count = 0;
e = 0.1;
xlist = [];
glist = [];
while count < 100
    count = count + 1;
    g_k = gradient(X_k);
    t_k = oneDimSearch(X_k(1), X_k(2), P_k(1), P_k(2));
    X_k = X_k + t_k*P_k;
    g_k = gradient(X_k);
    S_k = t_k*P_k;
    y_k = g_k - gradient(X_k - t_k*P_k);
    H_k = H_k + S_k*(S_k.')/((S_k.')*y_k) - H_k*y_k*(y_k.')*H_k/((y_k.')*H_k*y_k);
    P_k = -H_k*g_k;
    
%     disp("X_k =");
%     disp(X_k);
%     disp("g_k =");
%     disp(g_k);
%     disp("H_k =");
%     disp(H_k);
%     disp("P_k =");
%     disp(P_k);
    g = norm(g_k);
    xlist = [xlist X_k];
    glist = [glist g];
    fprintf("第%d次迭代:\n", count);
    disp("||g_k|| =");
    disp(g);
end
disp("迭代完成!");
% disp("X* =");
% disp(X_k);
[minValue, index] = min(glist);
disp("局部最优解:");
X = [xlist(index*2), xlist(index*2+1)];
disp(X);
disp("局部最优梯度:");
disp(minValue);
% disp("f(X)* =");
% disp(eval(subs(f, [x1 x2], [X_k(1), X_k(2)])));

function [y] = oneDimSearch(a1, a2, b1, b2)
global f;
beta = 0.618;
eta = 0.2;
a = -10;
b = 10;
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
y = [g1 g2].';
end

function [y] = func(a1, a2, b1, b2, x)
y = (a1 + b1*x)^2 + 4*(a2 + b2*x)^2;
end
