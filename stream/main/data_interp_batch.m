function [ cell_interped_data ] = data_interp_batch( cell_raw_data )
% ������ֵ������ѭ�����ú���data_interp���в�ֵ
cell_new_data = cell_raw_data;

% ɾ����Ԫ��
cell_new_data(cellfun(@isempty,cell_new_data)) = [];
cell_row = size(cell_new_data, 1);

mat_batch_temp = [];
mat_interp_1 = [];
mat_interp_2 = [];

cell_interped_data = cell(cell_row, 2);
count = 0;
for i = 1 : cell_row
    mat_batch_temp = cell_new_data{i, 1};
    [ mat_interp_1, mat_interp_2 ] = data_interp( mat_batch_temp );
    cell_interped_data{i, 1} = mat_interp_1;
    cell_interped_data{i, 2} = mat_interp_2;
    count = count + 1;
end

end

