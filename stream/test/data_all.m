%%
% 该程序用于将csv文件转储为Mat矩阵，其中时间信息以时间数字形式储存
%% 含表头的csv文件读取
% 数据返回格式为cell类型和int32数据类型
clear;close all;clc;
% 打开csv文件
fid = fopen('c05.csv');
% 读取表头 数据返回为cell类型 调用格式title{1}
title = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter', ',')
% 读取数据 返回为cell类型 
data = textscan(fid, '%s %s %s %s %f %f %f %f %f %f %f %f %f %f %f %f','delimiter', ',')
fclose(fid);

%% 修改时间格式，字符串->datetime->时间数字
%读出字符串中时间字段
time = cell2mat(data{1,4});
%转化为matlab时间格式
f_time = datetime(time,'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSS''Z');
%转化为Matlab时间数字，为double型
unix_time = datenum(f_time);
%% 重新装配数据
% PIN码转化为char型
PINs = cell2mat(data{1,3});
% 生成double型PIN码
PINs_num = str2num(PINs);
%获取数据行数
line = size(unix_time, 1);

% mat存储各传感器各轴数据
mat = cell2mat([data(5 : 16)]);
% labeled_mat在mat的基础上加上时间数字和PIN码标签（双精度型）
labeled_mat = [unix_time PINs_num mat];

%% 将数据分类，并储存在cell中
cell = data_distribute(PINs, line, labeled_mat);

%% 批处理插值算法
cell_interp_1 = cell(25,1);
cell_interp_2 = cell(25,1);

for i = 1 : 25
    mat = cell{i ,1};
    [mat_interp_1,mat_interp_2] = data_interp(mat);
    cell_interp_1{i,1}=mat_interp_1;
    cell_interp_2{i,1}=mat_interp_2;
end
