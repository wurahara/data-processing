function [ cell_raw_data ] = data_batch( mat )
% 数据批处理函数
rawline = size(mat, 1);

% raw data为cell类型，用于存放分类后的数据
cell_raw_data = cell(10000,1);

% 上一sampleID的寄存器
sampleID_flag = mat(1,1);
% 上一pin码的寄存器
pin_flag = mat(1,2);

cell_count = 1;
% 循环暂存数据矩阵
mat_temp = [];
for i = 1:rawline
    % 如果sampleID和PIN都未改变，就讲本条存入暂存矩阵
    if(mat(i, 1) == sampleID_flag && mat(i, 2) == pin_flag)
        mat_temp = [mat_temp; mat(i, :)];
    % 如果sampleID或PIN码发生改变，就保存暂存矩阵进cell中，清空暂存矩阵
    else
        % 刷新两个寄存器值
        sampleID_flag = mat(i, 1);
        pin_flag = mat(i, 2);
        % 保存进cell
        cell_raw_data{cell_count, 1} = mat_temp;
        
        cell_count = cell_count + 1;
        mat_temp=[];
    end
end

end

