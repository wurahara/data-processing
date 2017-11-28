function [ mfcc_coef ] = mfcc( time_vector, signal, bank_num, mfcc_num )
%MFCC Calculate the MFCC coefficient of input signal

length = size(signal, 1);

total_time = time_vector(length) - time_vector(1);
total_time = total_time * 24 * 60 * 60;

fs = length / total_time;                               % Sampling Frequency
% Period = 1 / fs;                                      % Sampling Period

bank = filter_bank_mel(bank_num, 1000, fs, 0, 0.5);

bank = full(bank);                                      % full() convert sparse matrix to full matrix
bank = bank / max(bank(:));                             % bank normalize

%% DCT Coefficient
n = 0 : bank_num - 1;
for k=1 : mfcc_num
    DCT_coef(k, :) = cos((2*n + 1) * k * pi / (2 * bank_num));
end

w = 1 + 6 * sin( pi*(1 : mfcc_num) ./ mfcc_num);        % normalize cepstrum lift window
w = w / max(w);                                         % pre-emphasis filter


%%
signal_double = double(signal);

windowed = signal_double .* hamming(length);
frq_acc_x = abs(fft(windowed));
frq_acc_x = frq_acc_x .^ 2;
mfcc_pre = DCT_coef * log(bank * frq_acc_x(1:501));
mfcc_coef = mfcc_pre .* w';

end

