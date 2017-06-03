line = size(mat_error, 1);
for i = 2 : line
    if(mat_error(i-1, 3) == mat_error(i, 3));
        mat_error(i, 3) = mat_error(i, 3) + 0.000000001;
    end
end