function [ mat_featured_data ] = data_feature_extraction_batch( cell_interped_data )
%data_feature_extraction_batch 批量特征提取函数

line = size(cell_interped_data, 1);
mat_featured_data = [];

for i = 1 : line
    mat1 = cell_interped_data{i, 1};
    mat2 = cell_interped_data{i, 2};
    
    line1 = size(mat1, 1);
    line2 = size(mat2, 1);
    
    pin_this = mat1(1, 2);
    % 计算欧几里得距离
    time1 = mat1(:, 1);
    time2 = mat2(:, 1);
    
    acc = mat1(:, 3:5);
    gacc = mat1(:, 6:8);
    rot = mat1(:, 9:11);
    ori = mat2(:, 3:5);
    
    euc_acc = [];
    euc_gacc = [];
    euc_rot = [];
    euc_ori = [];
    
    for j = 1 : line1
        euc_acc = [euc_acc; norm(acc(j,:), 2)];
        euc_gacc = [euc_gacc; norm(gacc(j,:),2)];
        euc_rot = [euc_rot; norm(rot(j,:),2)];
    end
    
    for k = 1 : line2
        euc_ori = [euc_ori; norm(ori(k,:),2)];
    end
    
    acc = [acc euc_acc];
    gacc = [gacc euc_gacc];
    rot = [rot euc_rot];
    ori = [ori euc_ori];
    
    full_data = [acc gacc rot];
    col1 = size(full_data, 2);
    col2 = size(ori, 2);
    
    
    % 特征提取
    feature1 = [];
    feature2 = [];
    for itr1 = 1 : col1
        feature1 = [feature1 feature_extraction(time1, full_data(:, itr1))];
    end
    
    for itr2 = 1 : col2
        feature2 = [feature2 feature_extraction(time2, ori(:, itr2))];
    end
    feature = [feature1 feature2 pin_this];
  
    % 数据装配
    mat_featured_data = [mat_featured_data; feature];
end

end