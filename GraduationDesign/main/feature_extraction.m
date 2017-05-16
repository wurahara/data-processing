function [ feature_row ] = feature_extraction( timestamp, vector_col )

% feature_extraction ������ȡ����
% timestamp: �����ʱ��������
% vector_col: �������������Ϊĳһ�β�����ĳһ����ֵ����acc_x, rot_alpha, etc.
% feature_row: �������������Ϊ��ȡ�������������������и�ʽ��
% |���ֵ-|-��Сֵ-|-������-|-�������-|-����-|--����--|-����--|-���������-|--��б��--|-���ϵ��-|-����ʱ��-|-����ʱ��-|
% |--Max--|--Min--|--RMS--|---RMSE---|-Mean-|-NumMax-|NumMin|----SMA-----|-Skewness-|Kurtosis-|---TTP---|---TTC---|
% ����ĸ�ʽ̫����

%% Max ���������ֵ
% max_num ���ֵ
% max_row ���ֵ������
[Max,~] = max(vector_col);

%% Min ��������С��
% min_num ��Сֵ
% min_row ��Сֵ������
[Min,~] = min(vector_col);

%% Mean �����ھ�ֵ
Mean = mean(vector_col);

%% RMS ������
RMS = rms(vector_col);

%% RMSE ���������
RMSE = std(vector_col);

%% NumMax �����ڷ���
IndMax = find(diff(sign(diff(vector_col)))<0)+1;
NumMax = size(IndMax, 1);

%% NumMin �����ڹ���
IndMin = find(diff(sign(diff(vector_col)))>0)+1;
NumMin = size(IndMin, 1);

%% SMA �źŷ����������
Abs = abs(vector_col);
SMA = trapz(timestamp, Abs);

%% Skewness ������б�� ƫ����
Skewness = skewness(vector_col, 1);

%% Kurtosis ���ϵ��
Kurtosis = kurtosis(vector_col, 1);

%% TTP ���ﲨ��ƽ��ʱ�� TTC ���ﲨ��ƽ��ʱ��
[ TTP, TTC ] = TTP_TTC( timestamp, vector_col, IndMax, IndMin );

%% ��ͼ��һ��
% plot(time_max, acc_max,'ro',time_min, acc_min,'go',time, accx);

%% ���
feature_row = [Max Min RMS RMSE Mean NumMax NumMin SMA Skewness Kurtosis TTP TTC];
end

