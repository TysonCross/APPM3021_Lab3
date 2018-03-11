function [ root ] = NewtonMethodScaler(f, fprime, x_0, tol)
% NewtonMethodScaler returns the root of an equation f, within tolerance tol
% using initial guess x_0, with the iterative approximation taken as the
% intersection of f and derivative f'

% initial values
x = x_0;

sign_places = abs(log10(tol))+1;
i=2;
iteration_limit = 1000;

while true
    
    if fprime(x(i-1))==0
        error('Division by zero, fprime = 0')
    else
        x(i) =  x(i-1) - ( f(x(i-1) ) / fprime(x(i-1)) );
    end
    
    % stopping criteria 
    if f(x(i)) == 0                                                % root found!
        root = x;
        disp(['Exact root: ', num2str(root(end)) ,...
            '. Newton Found in ', num2str(i), ' iterations'])
        return
    end
    
    if abs( x(i) - x(i-1) ) / abs(x(i)) < tol
        root = round(x,sign_places);
        disp(['Root: ',num2str(root(end)), '. Newton found within tolerance: ',...
            num2str(tol), ' in ', num2str(i), ' iterations'])
        return
    end
    
    if i>iteration_limit
        error(['Unable to find root within ', num2str(iteration_limit),...
            ' iterations'])
    else
        i=i+1;
    end
end
end

