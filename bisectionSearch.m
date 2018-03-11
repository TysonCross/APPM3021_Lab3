function [ root ] = bisectionSearch( f, tol, I_0 )
% bisectionSearch returns the root of an equation f, within tolerance tol
% with initial bracket I_0 = [a_initial, b_initial]
% The method is based on continual bisection of the interval
% containing the root (by evaluating the sign of of the input
% equation over the two halves of the current interval)

% initial values
a = I_0(1);
b = I_0(2);
c = [ b-a ];
root_found = false;
    
if f(a)*f(b) > 0                                                % must have opposite signs
    error(['No root can be found within the interval [',...
        num2str(a),',', num2str(b),'] with the equation ',func2str(f)])
end

sign_places = abs(log10(tol))+1;
max_iterations = ceil(log2(2*(b-a)/tol))-1;

for i = 2:max_iterations

    c(i) = (a+b)/2;

    % stopping criteria
    if f(c(i)) == 0                                            	% root found!
        root_found = true;
    elseif c(i)==0
        error('Division by zero (cannot test stopping criteria)')
    elseif (abs(c(i)-c(i-1)) / abs(c(i)) < tol) || root_found
        root = round(c,sign_places);
        disp(['Root = ',num2str(root(end)),...
            ' found by bisection method within tolerance: ',...
            num2str(tol), ' in ', num2str(i), ' iterations'])
        return
    end
    
    % prepare for next loop
    if f(a)*f(c(i)) < 0
        b = c(i);
    else                                                        % f(a)*f(c(i)) > 0, i.e. same signs
        a = c(i);
    end
end
end