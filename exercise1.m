% APPM3021 Lab 3, Exercise 1

clc; clear all;

equation = @(x) x^2 -x - 2;
I_0 = [1, 4];
tol = 0.00001;

tic;
it_root_bisec = bisectionSearch(equation, tol, I_0);
t_bisec = toc;
disp(['Solution converged in ', num2str(t_bisec*1000), ' milli-seconds'])