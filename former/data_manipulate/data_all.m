%%
% �ó������ڽ�csv�ļ�ת��ΪMat��������ʱ����Ϣ��ʱ��������ʽ����
%% ����ͷ��csv�ļ���ȡ
% ���ݷ��ظ�ʽΪcell���ͺ�int32��������
clear;close all;clc;
% ��csv�ļ�
fid = fopen('c05.csv');
% ��ȡ��ͷ ���ݷ���Ϊcell���� ���ø�ʽtitle{1}
title = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'delimiter', ',')
% ��ȡ���� ����Ϊcell���� 
data = textscan(fid, '%s %s %s %s %f %f %f %f %f %f %f %f %f %f %f %f','delimiter', ',')
fclose(fid);

%% �޸�ʱ���ʽ���ַ���->datetime->ʱ������
%�����ַ�����ʱ���ֶ�
time = cell2mat(data{1,4});
%ת��Ϊmatlabʱ���ʽ
f_time = datetime(time,'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSS''Z');
%ת��ΪMatlabʱ�����֣�Ϊdouble��
unix_time = datenum(f_time);
%% ����װ������
% PIN��ת��Ϊchar��
PINs = cell2mat(data{1,3});
% ����double��PIN��
PINs_num = str2num(PINs);
%��ȡ��������
line = size(unix_time, 1);

% mat�洢����������������
mat = cell2mat([data(5 : 16)]);
% labeled_mat��mat�Ļ����ϼ���ʱ�����ֺ�PIN���ǩ��˫�����ͣ�
labeled_mat = [unix_time PINs_num mat];

%% �����ݷ��࣬��������cell��
cell = data_distribute(PINs, line, labeled_mat);

%% �������ֵ�㷨
cell_interp_1 = cell(25,1);
cell_interp_2 = cell(25,1);

for i = 1 : 25
    mat = cell{i ,1};
    [mat_interp_1,mat_interp_2] = data_interp(mat);
    cell_interp_1{i,1}=mat_interp_1;
    cell_interp_2{i,1}=mat_interp_2;
end
