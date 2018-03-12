% APPM3021 Lab 3, Exercise 3

clc
clear global variable

syms x;
f = @(x) x^2 + x - 2;
x_0 = 0.5;
tol = 0.00001;

tic;
fprime = matlabFunction( diff(f(x)) );                          % include in timing
it_root_newton = NewtonMethodScaler(f, fprime, x_0, tol);
t_newton = toc;
disp(['Solution converged in ', num2str(t_newton*1000), ' milli-seconds'])
