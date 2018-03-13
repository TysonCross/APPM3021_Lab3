% APPM3021 Lab 3, Question 2 (a)

clc; clear all;

% system of equations
syms f g h u v w;
f(u,v,w) = u^2 +4*u*v - 2;
g(u,v,w) = u*v - u^2 + v^2;
h(u,v,w) = u^2 + w;
F = [f;g;h];
J = jacobian(F, [u, v, w]);

X_0 = [ 1 1 1 ];
tol = 0.0000001;

tic;
it_root_newton_sys = NewtonMethodSystem(F, J, X_0, tol);
t_newton_sys = toc;
disp(['Solution converged in ', num2str(t_newton_sys*1000), ' milli-seconds (including calculation of f'')'])