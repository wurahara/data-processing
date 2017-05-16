%% 数据预处理
clear;
clc;

load('mat_exp_1.mat');
load('mat_exp_2.mat');

m1 = mat1;
time = m1(:, 1);
accx = m1(:, 3);


%% Max 区间内最大值
% acc_x_max 最大值 acc_x_max_row 最大值所在行
[acc_x_max,acc_x_max_row] = max(m1(: , 3));

% time_acc_x_max 最大值对应时间
time_acc_x_max = m1(acc_x_max_row , 1);

%% Min 区间内最小者
% acc_x_min 最小值 acc_x_min_row 最小值所在行
[acc_x_min,acc_x_min_row] = min(m1(: , 3));

% time_acc_x_min 最小值对应时间
time_acc_x_min = m1(acc_x_min_row , 1);

%% Mean 区间内均值
acc_x_mean = mean(m1(: , 3));

%% RMS 均方根
acc_x_rms = rms(m1(: , 3));

%% RMSE 均方根误差
acc_x_std = std(m1(:, 3));
%% NumMax 区间内峰数
IndMax = find(diff(sign(diff(m1(: , 3))))<0)+1;
NumMax = size(IndMax, 1);
%% NumMin 区间内谷数
IndMin = find(diff(sign(diff(m1(: , 3))))>0)+1;
NumMin = size(IndMin, 1);
%% SMA 信号幅度区域面积
abs_acc_x = abs(m1(:, 3));
% plot(time, abs_acc_x, 'r');
SMA = trapz(m1(:, 1),abs_acc_x);
%% Skewness 曲线倾斜度 偏移量
Skewness = skewness(m1(: , 3), 1);

%% Kurtosis 峰度系数
Kurtosis = kurtosis(m1(: , 3), 1);

%% TTP 到达波峰平均时间 TTC 到达波谷平均时间
line1 = size(IndMax, 1);
line2 = size(IndMin, 1);

time_max = [];
acc_max = [];

time_min = [];
acc_min = [];

for i = 1 : line1
    time_max = [time_max; m1(IndMax(i, 1), 1)];
    acc_max = [acc_max; m1(IndMax(i, 1), 3)];
end

for i = 1 : line2
    time_min = [time_min; m1(IndMin(i, 1), 1)];
    acc_min = [acc_min; m1(IndMin(i, 1), 3)];
end

% head and tail
% function realize
%% 试样作图
% plot(time_max, acc_max,'ro',time_min, acc_min,'go',time, accx);
