clear;clc;
%% filter bank basic settings
load('mat_interped_test.mat');
sig = mat_test;
length = size(sig, 1);

total_time = sig(length, 1) - sig(1, 1);
total_time = total_time * 24 * 60 * 60;

fs = length / total_time;                   % Sampling Frequency
Period = 1 / fs;                            % Sampling Period

Time_vector = sig(:,1);                     % Time vector
acc_x = sig(:,3);

bank = filter_bank_mel(20, 1000, fs, 0, 0.5);

bank = full(bank);                          % full() convert sparse matrix to full matrix  
bank = bank / max(bank(:));                 % bank normalize

%% DCT Coefficient
for k=1:12
    n=0:19;
    DCT_coef(k, :)=cos( (2*n + 1) * k * pi / (2*24) );
end

w = 1 + 6 * sin( pi*(1 : 12) ./ 12);        %归一化倒谱提升窗口
w = w / max(w);                             %预加重滤波器


%%
acc_x_double = double(acc_x);

windowed = acc_x_double .* hamming(length);
frq_acc_x = abs(fft(windowed));
frq_acc_x = frq_acc_x .^ 2;
c1 = DCT_coef * log(bank * frq_acc_x(1:501));
mfcc = c1 .* w';