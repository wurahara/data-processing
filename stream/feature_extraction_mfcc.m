function [ mel_coef ] = feature_extraction_mfcc( timestamp, vector_col )

% feature_extraction 特征提取函数
% timestamp: 输入的时间列向量
% vector_col: 输入的列向量，为某一段采样的某一特征值，如acc_x, rot_alpha, etc.
% mel_coef: 输出的MFCC，即梅尔频率倒谱函数

%% MFCC 梅尔频率倒谱函数
mel_freq = mfcc(timestamp, vector_col, 20, 20);
mel_coef = mel_freq';

end

