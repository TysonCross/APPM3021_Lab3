% APPM3021 Lab 3, Question 1 (a) (II)

clc
clear all

syms x;
f = @(x) 1 - 2/(x^2 - 2*x + 2)
x_0 = 0;
I_0 = [-1, 1];
tol = 0.00001;

% measurements
tic;
root_bisec = bisectionSearch(f, tol, I_0);
t_bisec = toc; tic;
root_falsi = regulaFalsiSearch(f, tol, I_0);
t_falsi = toc; tic;
fprime = matlabFunction( diff(f(x)) );                      % included in Newton timing 
root_newton = NewtonMethodScaler(f, fprime, x_0, tol);
t_newton = toc;

% iterations
iter_bisec = length(root_bisec);
iter_falsi = length(root_falsi);
iter_newton = length(root_newton);

% relative error
error_bisec(1) = I_0(2)-I_0(1);
error_falsi(1) = I_0(2)-I_0(1);
error_newton(1) = x_0;

for index=2:iter_bisec
    difference = abs(root_bisec(:,index) - root_bisec(:,index-1));
    error_bisec(index) = max(difference)/max(abs(root_bisec(:,index)));
end
for index=2:iter_falsi
    difference = abs(root_falsi(:,index) - root_falsi(:,index-1));
    error_falsi(index) = max(difference)/max(abs(root_falsi(:,index)));
end
for index=2:iter_newton
    difference = abs(root_newton(:,index) - root_newton(:,index-1));
    error_newton(index) = max(difference)/max(abs(root_newton(:,index)));
end

% time
disp(' ')
disp(['Bisection root converged in ', num2str(t_bisec*1000), ' milli-seconds'])
disp(['Regula Falsi root converged in ', num2str(t_falsi*1000), ' milli-seconds'])
disp(['Newton fixed-point root converged in ', num2str(t_newton*1000), ' milli-seconds'])