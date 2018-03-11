function [ root ] = regulaFalsiSearch(f, tol, I_0)
% regulaFalsiSearch returns the root of an equation f, within tolerance tol
% with initial bracket I_0 = [a_initial, b_initial]
% regular falsi does a linear interpolation between two points,
% finding the x-intercept and using this intercept for the new interval


% initial values
a = I_0(1);
b = I_0(2);
c = [ b-a ];

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
    else
        c(i) = ( a*f(b) - b*f(a) ) / ( f(b) - f(a) );
    end
    
    % stopping criteria
    if f(c(i)) == 0                                                % root found!
        root = c;
        disp(['Exact root: ', num2str(root(i)) ,'. Found in ',...
            num2str(i), ' iterations'])
        return
    end
    if c(i)==0
        error('Division by zero (cannot test stopping criteria)')
    elseif abs(c(i)-c(i-1)) / abs(c(i)) < tol
        root = round(c,sign_places);
        disp(['Root: ',num2str(root(i)), '. Found within tolerance: ',...
            num2str(tol), ' in ', num2str(i), ' iterations'])
        return
    end
    
    if f(c(i)) > 0
        b = c(i);
    else                                                           % f(c(i)) > 0
        a = c(i);
    end
    i=i+1;
end
end