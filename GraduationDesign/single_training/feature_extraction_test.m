%% ����Ԥ����
m1 = [time2 ori];
%% Max ���������ֵ
% acc_x_max ���ֵ acc_x_max_row ���ֵ������
[acc_x_max,acc_x_max_row] = max(m1(: , 2));

% time_acc_x_max ���ֵ��Ӧʱ��
time_acc_x_max = m1(acc_x_max_row , 1);

%% Min ��������С��
% acc_x_min ��Сֵ acc_x_min_row ��Сֵ������
[acc_x_min,acc_x_min_row] = min(m1(: , 2));

% time_acc_x_min ��Сֵ��Ӧʱ��
time_acc_x_min = m1(acc_x_min_row , 1);

%% Mean �����ھ�ֵ
acc_x_mean = mean(m1(: , 2));

%% RMS ������
acc_x_rms = rms(m1(: , 2));

%% RMSE ���������
acc_x_std = std(m1(:, 2));
%% NumMax �����ڷ���
IndMax = find(diff(sign(diff(m1(: , 2))))<0)+1;
NumMax = size(IndMax, 1);
%% NumMin �����ڹ���
IndMin = find(diff(sign(diff(m1(: , 2))))>0)+1;
NumMin = size(IndMin, 1);
%% SMA �źŷ����������
abs_acc_x = abs(m1(:, 2));
% plot(time, abs_acc_x, 'r');
SMA = trapz(m1(:, 1),abs_acc_x);
%% Skewness ������б�� ƫ����
Skewness = skewness(m1(: , 2), 1);

%% Kurtosis ���ϵ��
Kurtosis = kurtosis(m1(: , 2), 1);

%% TTP ���ﲨ��ƽ��ʱ�� TTC ���ﲨ��ƽ��ʱ��
line1 = size(IndMax, 1);
line2 = size(IndMin, 1);

time_max = [];
acc_max = [];

time_min = [];
acc_min = [];

for i = 1 : line1
    time_max = [time_max; m1(IndMax(i, 1), 1)];
    acc_max = [acc_max; m1(IndMax(i, 1), 3)];
end

for i = 1 : line2
    time_min = [time_min; m1(IndMin(i, 1), 1)];
    acc_min = [acc_min; m1(IndMin(i, 1), 3)];
end

% head and tail
%% ������ͼ
plot(time_max, acc_max,'ro',time_min, acc_min,'go',time2, ori(:,1));
