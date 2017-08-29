function [ TTP, TTC ] = TTP_TTC( timestamp, vector_col, IndMax, IndMin )
%TTP_TTC 提取特征TTP和TTC
% TTP, The average time from a sample to a peak, 波峰到达平均时间
% TTC, The average time from a sample to a crest, 波谷到达平均时间

raw_row = [timestamp vector_col];

line1 = size(IndMax, 1);
line2 = size(IndMin, 1);

peak = [];
crest = [];

for i = 1 : line1
    peak = [ peak ; raw_row( IndMax(i, 1),: ) ];
end

peak = [ peak ones(line1, 1)];

for i = 1 : line2
    crest = [ crest ; raw_row( IndMin(i, 1),: ) ];
end

crest = [ crest (-1) * ones(line2, 1)];

acc_x_extremum = [peak; crest];

acc_x_extremum = sortrows(acc_x_extremum, 1);
line3 = size(acc_x_extremum, 1);

ascending = [];
descending = [];

for i = 1 : line3 - 1
    if( acc_x_extremum(i, 3) == 1 && acc_x_extremum(i+1, 3) == -1 )
        descending = [ descending; acc_x_extremum(i+1, 1) - acc_x_extremum(i, 1)];
    end
    
    if( acc_x_extremum(i, 3) == -1 && acc_x_extremum(i+1, 3) == 1 )
        ascending = [ ascending; acc_x_extremum(i+1, 1) - acc_x_extremum(i, 1)];
    end
end

TTP = mean(ascending);
TTC = mean(descending);
end