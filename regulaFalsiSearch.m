function [ root ] = regulaFalsiSearch(f, tol, I_0, keep_iterations)
% regulaFalsiSearch returns the root of an equation f, within tolerance tol
% with initial bracket I_0 = [a_initial, b_initial]
% regular falsi does a linear interpolation between two points,
% finding the x-intercept and using this intercept for the new interval

if nargin<4
    keep_iterations = false;
end


% initial values
a = I_0(1);
b = I_0(2);
c = [ b-a ];
root_found = false;

if f(a)*f(b) > 0                                                   % must have opposite signs
    error(['No root can be found within the interval [',...
        num2str(a),',', num2str(b),'] with the equation ',func2str(f)])
end

sign_places = abs(log10(tol))+1;
i=2;

while true
    if f(b)==f(a)
        error(['Interval is zero between [',...
        num2str(a),',', num2str(b),']'])
    end
    
    c(i) = ( a*f(b) - b*f(a) ) / ( f(b) - f(a) );
    
    % stopping criteria
    if round(f(c(i)),sign_places) == 0                                                % root found!
        root_found = true;
    elseif c(i)==0
        error('Division by zero (cannot test stopping criteria)')
    end
    
    if abs(c(i)-c(i-1)) / abs(c(i)) < tol || root_found
        if keep_iterations
            root = round(c,sign_places);
        else
            root = round(c(end),sign_places);
        end
        disp(['Root = ',num2str(root(end)),...
            ' found by Regula-Falsi method within tolerance: ',...
            num2str(tol), ' in ', num2str(i), ' iterations'])
        return
    end
    
    % prepare for next loop
    if f(c(i)) > 0
        b = c(i);
    else                                                           % f(c(i)) > 0
        a = c(i);
    end
end
end