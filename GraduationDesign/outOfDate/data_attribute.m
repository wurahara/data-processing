%% ��������������
clear;
clc;

load('matrix.mat');
line = size(mat, 1);

% raw dataΪcell���ͣ����ڴ�ŷ���������
cell_raw_data = cell(10000,1);

% ��һsampleID�ļĴ���
sampleID_flag = mat(1,1);
% ��һpin��ļĴ���
pin_flag = mat(1,2);

cell_count = 1;
% ѭ���ݴ����ݾ���
mat_temp = [];
for i = 1:line
    % ���sampleID��PIN��δ�ı䣬�ͽ����������ݴ����
    if(mat(i, 1) == sampleID_flag && mat(i, 2) == pin_flag)
        mat_temp = [mat_temp; mat(i, :)];
    % ���sampleID��PIN�뷢���ı䣬�ͱ����ݴ�����cell�У�����ݴ����
    else
        % ˢ�������Ĵ���ֵ
        sampleID_flag = mat(i, 1);
        pin_flag = mat(i, 2);
        % �����cell
        cell_raw_data{cell_count, 1} = mat_temp;
        
        cell_count = cell_count + 1;
        mat_temp=[];
    end
end

% mat_test = cell_raw_data{35,1};
% [mat_interp_1, mat_interp_2] = data_interp_test(mat_test);