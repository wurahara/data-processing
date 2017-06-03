function [ time_string ] = time_format_change( time_number )
time_number_1 = time_number';

time_string = [];

line_time = size(time_number_1,1);
for i = 1 : line_time
    time_string(i, 1) = datestr(time_number_1(i, 1), 'MM:SS.FFF');
end

end

