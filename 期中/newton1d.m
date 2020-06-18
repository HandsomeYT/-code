syms x;
g(x) = x^2 + 4*cos(x);
diffG1(x) = diff(g(x));
diffG2(x) = diff(g(x),2);
x0 = 1;
e = 10^(-5);
x_ = 0;
count = 0;
while count<2
    count = count + 1;
    x_ = x0 - diffG1(x0) / diffG2(x0);
    fprintf("µÚ%d´Îµü´ú: x = %f\n",count,x_); 
    if(abs(x_ - x0) <= 0.3)
        fprintf("x* = %f g(x)* = %f", x_,g(x_));
        break;
    else
        x0 = x_;
        x0 = vpa(x_);
    end
end
fprintf("x* = %f g(x)* = %f [x, x0] = [%f, %f]", x_,g(x_), x_, (x_+diffG1(x0) / diffG2(x0))); 
