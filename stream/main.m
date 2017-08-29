%% 主函数
%% 含表头的csv文件读取
% 数据返回格式为cell类型和int32数据类型

clear;close all;clc;

% 打开csv文件
fid = fopen('sensor1.csv');

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

% 装配数据
mat = [sampleID pin unix_time mat];

% inner sort function
mat = sortrows(mat, 3);
%% 进行分类批处理
cell_raw_data = data_distribution_batch(mat);

%% 进行插值
cell_interped_data = data_interp_batch(cell_raw_data);

%% 进行特征提取
mat_featured_data = data_feature_extraction_batch(cell_interped_data);

%% 制作CSV输出表
csvwrite('featuredData17082901.csv', mat_featured_data);
% title and head needed?