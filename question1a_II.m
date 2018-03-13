% APPM3021 Lab 3, Question 1 (a) (II)

clc; clear all;

syms f x;
f = @(x) 1 - 2/(x^2 - 2*x + 2)
x_0 = 0;
I_0 = [-1, 1];
tol = 0.0001;

% measurements
root_bisec = bisectionSearch(f, tol, I_0);
root_falsi = regulaFalsiSearch(f, tol, I_0);
fprime = matlabFunction( diff(f(x)) ); 
root_newton = NewtonMethodScaler(f, fprime, x_0, tol);