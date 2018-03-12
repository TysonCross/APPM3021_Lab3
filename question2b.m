% APPM3021 Lab 3, Exercise 5

clc
clear all

% system of equations
syms f g x y;
f(x,y) = x^3 + y^3 -3 ;
g(x,y) = x^2 - y^2 -2;
F = [f;g];
J = jacobian(F, [x, y]);

X_0 = [ 1 1 ; -1 -1 ];
tol = 0.000001;

for i=1:length(X_0)
    root = NewtonMethodSystem(F, J, X_0(i,:), tol);
    if isempty(root(:)) || isnan(sum(root)) || isinf(sum(root(:)))
    else
        root_newton(:,i) = [root(1),root(2)]';
    end
end
