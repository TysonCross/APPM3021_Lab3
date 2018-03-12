% APPM3021 Lab 3, Exercise 2

clc
clear global variable

equation = @(x) x^2 -x - 2;
I_0 = [1, 4];
tol = 0.00001;

tic;
it_root_falsi = regulaFalsiSearch(equation, tol, I_0);
t_falsi = toc;
disp(['Solution converged in ', num2str(t_falsi*1000), ' milli-seconds'])