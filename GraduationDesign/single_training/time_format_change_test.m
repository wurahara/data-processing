time_number_1 = time_manip_1;

time_string = [];

line_time = size(time_number_1,2);

for i = 1 : line_time
    time_string(1, i) = datestr(time_number_1(1, i), 'MM:SS.FFF');
end