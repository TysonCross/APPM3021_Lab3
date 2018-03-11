function [ roots ] = NewtonMethodSystem(F, J, X_0, tol)
% NewtonMethodSystem find the roots to a system of two (or more) equations
% using Newton's fixed-point iterative method

sign_places = abs(log10(tol));

M = inv(J)*F;                                   % inverse jacobian * system of equations (symbolic)
X(:,1) = X_0;                                   % initial guess
u = X_0(1);                                     % (individual variable)
v = X_0(2);
i = 1;                                          % iterations

while true
       X(:,i+1) = X(:,i) - M(u,v);              % Newton Method
                         
       if (norm(double(M(u,v)),inf) < tol)      % check error tolerance
           roots = round(X,sign_places);        % assign output
           disp(['Roots: ', num2str(roots(1:end,end)'), '. Found within tolerance: ',...
                 num2str(tol), ' in ', num2str(i), ' iterations'])
           return
       else

       u = X(1,i+1);                            % update individual variables
       v = X(2,i+1);

       i = i + 1;                               % update iterations
       end
end
    
end
