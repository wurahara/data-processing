clear;
clc;

load('matA.mat');
mat = mat22;
line = size(mat, 1);
PIN = mat(1, 2);

acc_x = mat(:,3);
ox_gamma = mat(:,12);
mat_1 = [];
mat_2 = [];
for i = 1 : line
    if( isnan(acc_x(i)) ~= true)
        mat_1 = [mat_1; mat(i , 1:11)];
    end
end

for i = 1 : line
    if( isnan(ox_gamma(i)) ~= true)
        mat_2 = [mat_2; mat(i, 1:2) mat(i , 12:14)];
    end
end
time_1 = mat_1(:,1);
time_2 = mat_2(:,1);

acc_x = mat_1(:,3);
acc_y = mat_1(:,4);
acc_z = mat_1(:,5);

gacc_x = mat_1(:,6);
gacc_y = mat_1(:,7);
gacc_z = mat_1(:,8);

rot_alpha = mat_1(:,9);
rot_beta = mat_1(:,10);
rot_gamma = mat_1(:,11);

ox_gamma = mat_2(:,3);
oy_beta = mat_2(:,4);
oz_alpha = mat_2(:,5);

line_mat_1 = size(mat_1, 1);
line_mat_2 = size(mat_2, 1);

time_deploy_1 = 999;
time_deploy_2 = 999;

time_1_left = time_1(1);
time_1_right = time_1(line_mat_1);
inter_1 = (time_1_right - time_1_left) / time_deploy_1;
time_manip_1 = time_1_left :inter_1: time_1_right;

time_2_left = time_2(1);
time_2_right = time_2(line_mat_2);
inter_2 = (time_2_right - time_2_left) / time_deploy_2;
time_manip_2 = time_2_left :inter_2: time_2_right;

acc_x_interp = interp1(time_1, acc_x, time_manip_1, 'spline');
acc_y_interp = interp1(time_1, acc_y, time_manip_1, 'spline');
acc_z_interp = interp1(time_1, acc_z, time_manip_1, 'spline');

gacc_x_interp = interp1(time_1, gacc_x, time_manip_1, 'spline');
gacc_y_interp = interp1(time_1, gacc_y, time_manip_1, 'spline');
gacc_z_interp = interp1(time_1, gacc_z, time_manip_1, 'spline');

rot_alpha_interp = interp1(time_1, rot_alpha, time_manip_1, 'spline');
rot_beta_interp = interp1(time_1, rot_beta, time_manip_1, 'spline');
rot_gamma_interp = interp1(time_1, rot_gamma, time_manip_1, 'spline');

ox_gamma_interp = interp1(time_2, ox_gamma, time_manip_2, 'spline');
oy_beta_interp = interp1(time_2, oy_beta, time_manip_2, 'spline');
oz_alpha_interp = interp1(time_2, oz_alpha, time_manip_2, 'spline');

PIN_1 = PIN * ones(time_deploy_1 + 1, 1);
PIN_2 = PIN * ones(time_deploy_2 + 1, 1);

% mat_interp_1 = [time_manip_1' PIN_1...
%     acc_x_interp' acc_y_interp' acc_z_interp'...
%     gacc_x_interp' gacc_y_interp' gacc_z_interp'...
%     rot_alpha_interp' rot_beta_interp' rot_gamma_interp'];
% 
% mat_interp_2 = [time_manip_2' PIN_2 ...
%    ox_gamma_interp' oy_beta_interp' oz_alpha_interp'];

% subplot(3,1,1);
% plot(time_1, acc_x, 'r.', time_manip_1, acc_x_interp);
% subplot(3,1,2);
% plot(time_1, acc_y, 'g.', time_manip_1, acc_y_interp);
% subplot(3,1,3);
% plot(time_1, acc_z, 'b.', time_manip_1, acc_z_interp);

% 用sym6小波对信号做5层分解
wname ='sym6'; lev=7;
[c,l] = wavedec(acc_z_interp,lev,wname);
% 通过第1层的细节系数估算信号的噪声强度 
sigma = wnoisest(c,l,1);
% 使用penalty策略确定降噪的阈值
alpha=1.5;
thr1 = wbmpen(c,l,sigma,alpha);
% 使用Birge-Massart策略确定降噪的阈值
[thr2,nkeep] = wdcbm(c,l,alpha);
xd1 = wdencmp('gbl',c,l,wname,lev,thr1,'s',1);
% 用缺省的阈值确定的时候使用硬阈值时系数进行处理
[xd2,cxd,lxd,perf0,perf2]= wdencmp('lvd',c,l,wname,lev,thr2,'h');
% 求得缺省的阈值
[thr,sorh,keepapp] = ddencmp('den','wv',time_manip_1);
% 重建降噪信号
xd3 = wdencmp('gbl',c,l,wname,lev,thr,'s',1);
figure
subplot(411); plot(acc_z_interp); title('原始信号','fontsize',10);
subplot(412); plot(xd1); title('使用penalty阈值降噪后信号','fontsize',10);
subplot(413); plot(xd2); title('使用Birge-Massart阈值降噪后信号','fontsize',10);
subplot(414); plot(xd2); title('使用缺省阈值降噪后信号', 'fontsize',10);


% subplot(3,1,1);
% plot(time_1, gacc_x, 'r.', time_manip_1, gacc_x_interp);
% subplot(3,1,2);
% plot(time_1, gacc_y, 'g.', time_manip_1, gacc_y_interp);
% subplot(3,1,3);
% plot(time_1, gacc_z, 'b.', time_manip_1, gacc_z_interp);

% subplot(3,1,1);
% plot(time_1, rot_alpha, 'r.', time_manip_1, rot_alpha_interp);
% subplot(3,1,2);
% plot(time_1, rot_beta, 'g.', time_manip_1, rot_beta_interp);
% subplot(3,1,3);
% plot(time_1, rot_gamma, 'b.', time_manip_1, rot_gamma_interp);

% subplot(6,1,4);
% plot(time_2, ox_gamma, 'r.', time_manip_1, ox_gamma_interp);
% subplot(6,1,5);
% plot(time_2, oy_beta, 'g.', time_manip_1, oy_beta_interp);
% subplot(6,1,6);
% plot(time_2, oz_alpha, 'b.', time_manip_1, oz_alpha_interp);


