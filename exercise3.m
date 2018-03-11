% APPM3021 Lab 3, Exercise 3

clc
clear all
format long

syms x;
f = @(x) x^2 -x - 2;
fprime = matlabFunction( diff(f(x)) );
x_0 = 0;
tol = 0.00001;

tic;
it_root_newton = NewtonMethodScaler(f, fprime, x_0, tol);
t_newton = toc;
disp(['Solution converged in ', num2str(t_newton*1000), ' milli-seconds'])
