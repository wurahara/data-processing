%% TEST 测试函数，用于计算TTP和TTC
% TTP, The average time from a sample to a peak, 波峰到达平均时间
% TTC, The average time from a sample to a crest, 波谷到达平均时间

clear;clc;

load('IndMax.mat');
load('IndMin.mat');
load('mat_exp_1.mat');

m1 = [mat1(:, 1) mat1(:, 3)];

line1 = size(IndMax, 1);
line2 = size(IndMin, 1);

acc_x_peak = [];
acc_x_crest = [];

for i = 1 : line1
    acc_x_peak = [ acc_x_peak ; m1( IndMax(i, 1),: ) ];
end

acc_x_peak = [ acc_x_peak ones(line1, 1)];

for i = 1 : line2
    acc_x_crest = [ acc_x_crest ; m1( IndMin(i, 1),: ) ];
end

acc_x_crest = [ acc_x_crest (-1) * ones(line2, 1)];

acc_x_extremum = [acc_x_peak; acc_x_crest];

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
%% 试样作图
plot(m1(:, 1), m1(:, 2), acc_x_extremum(:,1), acc_x_extremum(:,2), 'ro');







