function [ feature_row ] = feature_extraction( timestamp, vector_col )

% feature_extraction 特征提取函数
% timestamp: 输入的时间列向量
% vector_col: 输入的列向量，为某一段采样的某一特征值，如acc_x, rot_alpha, etc.
% feature_row: 输出的行向量，为提取的特征向量，按照下列格式：
% |最大值-|-最小值-|-均方根-|-均方误差-|-期望-|--峰数--|-谷数--|-幅度域面积-|--倾斜度--|-峰度系数-|-波峰时间-|-波谷时间-|
% |--Max--|--Min--|--RMS--|---RMSE---|-Mean-|-NumMax-|NumMin|----SMA-----|-Skewness-|Kurtosis-|---TTP---|---TTC---|
% 上面的格式太丑了

%% Max 区间内最大值
% max_num 最大值
% max_row 最大值所在行
[Max,~] = max(vector_col);

%% Min 区间内最小者
% min_num 最小值
% min_row 最小值所在行
[Min,~] = min(vector_col);

%% Mean 区间内均值
Mean = mean(vector_col);

%% RMS 均方根
RMS = rms(vector_col);

%% RMSE 均方根误差
RMSE = std(vector_col);

%% NumMax 区间内峰数
IndMax = find(diff(sign(diff(vector_col)))<0)+1;
NumMax = size(IndMax, 1);

%% NumMin 区间内谷数
IndMin = find(diff(sign(diff(vector_col)))>0)+1;
NumMin = size(IndMin, 1);

%% SMA 信号幅度区域面积
Abs = abs(vector_col);
SMA = trapz(timestamp, Abs);

%% Skewness 曲线倾斜度 偏移量
Skewness = skewness(vector_col, 1);

%% Kurtosis 峰度系数
Kurtosis = kurtosis(vector_col, 1);

%% TTP 到达波峰平均时间 TTC 到达波谷平均时间
[ TTP, TTC ] = TTP_TTC( timestamp, vector_col, IndMax, IndMin );

%% 作图试一试
% plot(time_max, acc_max,'ro',time_min, acc_min,'go',time, accx);

%% 输出
feature_row = [Max Min RMS RMSE Mean NumMax NumMin SMA Skewness Kurtosis TTP TTC];
end

