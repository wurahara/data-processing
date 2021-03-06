%% 主函数
%% 含表头的csv文件读取
% 数据返回格式为cell类型和int32数据类型

clear;close all;clc;

% 打开csv文件
fid = fopen('sensor5.csv');

% 读取表头 数据返回为cell类型 调用格式title{1}
title = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter', ',');

% 读取数据 返回为cell类型 
data = textscan(fid, '%s %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f','delimiter', ',');
fclose(fid);

%% 修改时间格式，字符串->datetime->时间数字

%读出字符串中时间戳字段
time = cell2mat(data{1,4});

%转化为matlab时间格式
f_time = datetime(time,'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSS''Z');

%转化为Matlab时间数字，为double型
unix_time = datenum(f_time);

%% 重新装配数据
mat = cell2mat(data(5 : 16));

% 提取sampleID和pin码
sampleID = cell2mat(data(2));
pin = cell2mat(data(3));

% 装配数据l
mat = [sampleID pin unix_time mat];

% inner sort function
mat = sortrows(mat, 3);
%% 进行分类批处理
cell_raw_data = data_distribution_batch(mat);

%% 进行插值
cell_interped_data = data_interp_batch(cell_raw_data);

%% 进行特征提取
mat_featured_data = data_feature_extraction_batch(cell_interped_data);
mat_featured_data_mfcc = data_feature_extraction_mfcc_batch(cell_interped_data);
mat_featured_data_all = [mat_featured_data(:, 1:192), mat_featured_data_mfcc];

%% NN准备
% time-domain
mat_input = mat_featured_data(:, 1:192);
mat_target = mat_featured_data(:, 193);
mat_target = spare_target(mat_target);

% time-domain & frequency-domain
size_all = size(mat_featured_data_all, 2);
mat_input_all = mat_featured_data_all(:, 1 : size_all-1);
mat_target_all = mat_featured_data_all(:, size_all);
mat_target_all = spare_target(mat_target_all);

%% 制作CSV输出表
local_time = datestr(now, 'yymmddHHMMSS');
name_1 = strcat('10 feature_set_free', local_time, '.csv');
name_2 = strcat('10 feature_set_mfcc', local_time, '.csv');
name_3 = strcat('10 feature_set_all', local_time, '.csv');

csvwrite(name_1, mat_featured_data);
csvwrite(name_2, mat_featured_data_mfcc);
csvwrite(name_3, mat_featured_data_all);
% title and head needed?