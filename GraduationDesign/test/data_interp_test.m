
% ²åÖµº¯Êý
line = size(testmat2, 1);

acc_x = testmat2(:,4);
ox_gamma = testmat2(:,13);
PIN = testmat2(1, 2);

mat_1 = [];
mat_2 = [];

for i = 1 : line
    if( isnan(acc_x(i)) ~= true)
        mat_1 = [mat_1; testmat2(i , 1:12)];
    end
end

for i = 1 : line
    if( isnan(ox_gamma(i)) ~= true)
        mat_2 = [mat_2; testmat2(i, 1:3) testmat2(i , 13:15)];
    end
end
time_1 = mat_1(:,3);
time_2 = mat_2(:,3);

acc_x = mat_1(:,4);
acc_y = mat_1(:,5);
acc_z = mat_1(:,6);

gacc_x = mat_1(:,7);
gacc_y = mat_1(:,8);
gacc_z = mat_1(:,9);

rot_alpha = mat_1(:,10);
rot_beta = mat_1(:,11);
rot_gamma = mat_1(:,12);

ox_gamma = mat_2(:,4);
oy_beta = mat_2(:,5);
oz_alpha = mat_2(:,6);

line_mat_1 = size(mat_1, 1);
line_mat_2 = size(mat_2, 1);

time_deploy_1 = 9999;
time_deploy_2 = 9999;

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

mat_interp_1 = [time_manip_1' PIN_1...
    acc_x_interp' acc_y_interp' acc_z_interp'...
    gacc_x_interp' gacc_y_interp' gacc_z_interp'...
    rot_alpha_interp' rot_beta_interp' rot_gamma_interp'];

mat_interp_2 = [time_manip_2' PIN_2 ...
   ox_gamma_interp' oy_beta_interp' oz_alpha_interp'];


pd = time_1_left :inter_1*1000: time_1_right + 0.000000900;


figure(1);
subplot(3,1,1);
plot(time_1, acc_x, 'r.');
set(gca,'XTick', pd); 
set(gca,'XTickLabel',{'0','75','150','225','300','375','450','525','600','675','750','825'});
set(gca,'fontsize',10);
xlabel('Time/ms');
ylabel('acc\_x/(m/s^2)');
%axis([time_1_left time_1_right -1 1]);

subplot(3,1,2);
plot(time_1, acc_y, 'g.')
set(gca,'XTick', pd); 
set(gca,'XTickLabel',{'0','75','150','225','300','375','450','525','600','675','750','825'});
xlabel('Time/ms');
ylabel('acc\_y/(m/s^2)');
%axis([time_1_left time_1_right -1 1]);

subplot(3,1,3);
plot(time_1, acc_z, 'b.')
set(gca,'XTick', pd); 
set(gca,'XTickLabel',{'0','75','150','225','300','375','450','525','600','675','750','825'});
xlabel('Time/ms');
ylabel('acc\_z/(m/s^2)');
ylim([-0.5 0.5]);


figure(2);
subplot(3,1,1);
plot(time_1, acc_x, 'r.', time_manip_1, acc_x_interp);
set(gca,'XTick', pd); 
set(gca,'XTickLabel',{'0','75','150','225','300','375','450','525','600','675','750','825'});
xlabel('Time/ms');
ylabel('acc\_x/(m/s^2)');
%axis([time_1_left time_1_right -1 1]);


subplot(3,1,2);
plot(time_1, acc_y, 'g.', time_manip_1, acc_y_interp)
set(gca,'XTick', pd); 
set(gca,'XTickLabel',{'0','75','150','225','300','375','450','525','600','675','750','825'});
xlabel('Time/ms');
ylabel('acc\_y/(m/s^2)');
%axis([time_1_left time_1_right -1 1]);

subplot(3,1,3);
plot(time_1, acc_z, 'b.', time_manip_1, acc_z_interp)
set(gca,'XTick', pd); 
set(gca,'XTickLabel',{'0','75','150','225','300','375','450','525','600','675','750','825'});
xlabel('Time/ms');
ylabel('acc\_z/(m/s^2)');
ylim([-0.5 0.5]);

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

