%% ������
%% ����ͷ��csv�ļ���ȡ
% ���ݷ��ظ�ʽΪcell���ͺ�int32��������

clear;close all;clc;

% ��csv�ļ�
fid = fopen('sensor1.csv');

% ��ȡ��ͷ ���ݷ���Ϊcell���� ���ø�ʽtitle{1}
title = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter', ',');

% ��ȡ���� ����Ϊcell���� 
data = textscan(fid, '%s %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f','delimiter', ',');
fclose(fid);

%% �޸�ʱ���ʽ���ַ���->datetime->ʱ������

%�����ַ�����ʱ����ֶ�
time = cell2mat(data{1,4});

%ת��Ϊmatlabʱ���ʽ
f_time = datetime(time,'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSS''Z');

%ת��ΪMatlabʱ�����֣�Ϊdouble��
unix_time = datenum(f_time);

%% ����װ������
mat = cell2mat(data(5 : 16));

% ��ȡsampleID��pin��
sampleID = cell2mat(data(2));
pin = cell2mat(data(3));

% װ������
mat = [sampleID pin unix_time mat];

% inner sort function
mat = sortrows(mat, 3);
%% ���з���������
cell_raw_data = data_distribution_batch(mat);

%% ���в�ֵ
cell_interped_data = data_interp_batch(cell_raw_data);

%% ����������ȡ
mat_featured_data = data_feature_extraction_batch(cell_interped_data);

%% ����CSV�����
csvwrite('featuredData17082901.csv', mat_featured_data);
% title and head needed?