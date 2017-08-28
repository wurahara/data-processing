function [ mat_interp_1, mat_interp_2 ] = data_interp( cellmat )
% 插值函数
% 用于单个条目的插值

%% 数据组格式化
cellmat_line = size(cellmat, 1);

% 标记，用于确认该行数据属于acc, rot还是ori
acc_x = cellmat(:,4);
ox_gamma = cellmat(:,13);

% 该组数据对应的PIN码
PIN_Interp = cellmat(1, 2);

mat_1 = [];
mat_2 = [];

% 时间重复检测和处理
for i = 2 : cellmat_line
    if(cellmat(i-1, 3) == cellmat(i, 3))
        cellmat(i, 3) = cellmat(i, 3) + 0.0000000001;
    end
end

%% 将数据按照字段分类到 mat_1 和 mat_2
for i = 1 : cellmat_line
    if( isnan(acc_x(i)) ~= true)
        mat_1 = [mat_1; cellmat(i , 1:12)];
    end
end

for i = 1 : cellmat_line
    if( isnan(ox_gamma(i)) ~= true)
        mat_2 = [mat_2; cellmat(i, 1:3) cellmat(i , 13:15)];
    end
end

%% 各字段定义

% 时间参数
time_1 = mat_1(:,3);
time_2 = mat_2(:,3);

% acc
acc_x = mat_1(:,4);
acc_y = mat_1(:,5);
acc_z = mat_1(:,6);

% gacc
gacc_x = mat_1(:,7);
gacc_y = mat_1(:,8);
gacc_z = mat_1(:,9);

% rot
rot_alpha = mat_1(:,10);
rot_beta = mat_1(:,11);
rot_gamma = mat_1(:,12);

% ori
ox_gamma = mat_2(:,4);
oy_beta = mat_2(:,5);
oz_alpha = mat_2(:,6);

% 数据组大小
line_mat_1 = size(mat_1, 1);
line_mat_2 = size(mat_2, 1);

% 插值长度设定
time_deploy_1 = 999;
time_deploy_2 = 999;

% 插值时间点分配
time_1_left = time_1(1);
time_1_right = time_1(line_mat_1);
inter_1 = (time_1_right - time_1_left) / time_deploy_1;
time_manip_1 = time_1_left :inter_1: time_1_right;

time_2_left = time_2(1);
time_2_right = time_2(line_mat_2);
inter_2 = (time_2_right - time_2_left) / time_deploy_2;
time_manip_2 = time_2_left :inter_2: time_2_right;

%% 插值算法

% acc 插值
acc_x_interp = interp1(time_1, acc_x, time_manip_1, 'spline');
acc_y_interp = interp1(time_1, acc_y, time_manip_1, 'spline');
acc_z_interp = interp1(time_1, acc_z, time_manip_1, 'spline');

% gacc 插值
gacc_x_interp = interp1(time_1, gacc_x, time_manip_1, 'spline');
gacc_y_interp = interp1(time_1, gacc_y, time_manip_1, 'spline');
gacc_z_interp = interp1(time_1, gacc_z, time_manip_1, 'spline');

% rot插值
rot_alpha_interp = interp1(time_1, rot_alpha, time_manip_1, 'spline');
rot_beta_interp = interp1(time_1, rot_beta, time_manip_1, 'spline');
rot_gamma_interp = interp1(time_1, rot_gamma, time_manip_1, 'spline');

% ori 插值
ox_gamma_interp = interp1(time_2, ox_gamma, time_manip_2, 'spline');
oy_beta_interp = interp1(time_2, oy_beta, time_manip_2, 'spline');
oz_alpha_interp = interp1(time_2, oz_alpha, time_manip_2, 'spline');

%% 数据重新装配

% PIN码向量
PIN_1 = PIN_Interp * ones(time_deploy_1 + 1, 1);
PIN_2 = PIN_Interp * ones(time_deploy_2 + 1, 1);

% mat_1 的插值
mat_interp_1 = [time_manip_1' PIN_1...
    acc_x_interp' acc_y_interp' acc_z_interp'...
    gacc_x_interp' gacc_y_interp' gacc_z_interp'...
    rot_alpha_interp' rot_beta_interp' rot_gamma_interp'];

% mat_2 的插值
mat_interp_2 = [time_manip_2' PIN_2 ...
   ox_gamma_interp' oy_beta_interp' oz_alpha_interp'];

end

