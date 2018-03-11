% APPM3021 Lab 3, Exercise 5

clc
clear all

% system of equations
syms f g x y;
f(x,y) = x^2 + y^2 - 2.12;
g(x,y) = y^2 - x^2*y - 0.04;

F = [f;g];
J = jacobian(F, [x, y]);

X_0 = [ 1 1 ];
tol = 0.00001;

tic;
it_root_newton_sys = NewtonMethodSystem(F, J, X_0, tol);
t_newton_sys = toc;
disp(['Solution converged in ', num2str(t_newton_sys*1000), ' milli-seconds'])

