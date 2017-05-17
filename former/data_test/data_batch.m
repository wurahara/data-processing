clear;
clc;

load('cell.mat');

cell_interp_1 = cell(25,1);
cell_interp_2 = cell(25,1);

for i = 1 : 25
    mat = cell{i ,1};
    [mat_interp_1,mat_interp_2] = data_interp(mat);
    cell_interp_1{i,1}=mat_interp_1;
    cell_interp_2{i,1}=mat_interp_2;
end
