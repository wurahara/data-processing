function [ mel_coef ] = feature_extraction_mfcc( timestamp, vector_col )

% feature_extraction ������ȡ����
% timestamp: �����ʱ��������
% vector_col: �������������Ϊĳһ�β�����ĳһ����ֵ����acc_x, rot_alpha, etc.
% mel_coef: �����MFCC����÷��Ƶ�ʵ��׺���

%% MFCC ÷��Ƶ�ʵ��׺���
mel_freq = mfcc(timestamp, vector_col, 20, 20);
mel_coef = mel_freq';

end

