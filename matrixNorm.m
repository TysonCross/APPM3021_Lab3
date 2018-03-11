function [ output_norm ] = matrixNorm( A )
% Returns the norm of a given matrix

n = length(A);

output_norm =[];
for row=1:n
    row_sum = 0;
    for column=1:n
        row_sum = row_sum + abs(A(row,column));
    end
output_norm = max([max(row_sum) output_norm]);
end

end