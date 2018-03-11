% APPM3021 Lab 3, Exercise 1

clc
clear all
format long 

equation = @(x) x^2 -x - 2;
I_0 = [1, 4];
tol = 0.00001;

it_root_bisec = bisectionSearch(equation, tol, I_0);

