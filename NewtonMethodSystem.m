function [ roots ] = NewtonMethodSystem(F, J, X_0, tol, keep_iterations)
% NewtonMethodSystem find the roots to a system of two (or more) equations
% using Newton's fixed-point iterative method

if nargin<5
    keep_iterations = false;
end

sign_places = abs(log10(tol));

% M = inv(J)*F;
M = J\F;                                            % inverse jacobian * system of equations (symbolic)
X(:,1) = X_0;                                       % initial guess
variables = num2cell(X_0);                          % seperate out individual inputs to function
% u = X_0(1);                                      	% (individual variable)
% v = X_0(2);
i = 1;                                              % iterations

while true
% 	X(:,i+1) = X(:,i) - M(u,v);                     % Newton Method
    X(:,i+1) = X(:,i) - M(variables{:});
            
   if (norm(double(M(variables{:})),inf) < tol)    	% check error tolerance
       if keep_iterations
        roots = round(X,sign_places);               % assign output
       else
           roots = round(X(1:end,end),sign_places); % assign output
       end
       disp('roots = ')
       disp(roots(1:end,end))
       disp(['Roots found by Newton (system) method within tolerance: ',...
             num2str(tol), ' in ', num2str(i), ' iterations'])
       return
   else

   variables = num2cell(X(:,i+1));                   % update individual variables

   i = i + 1;                                        % update iterations
   end
end
    
end