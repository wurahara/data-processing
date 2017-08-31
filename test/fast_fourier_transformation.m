clear;clc;

load('mat_interped_test.mat');
mat = mat_test;

Length = size(mat, 1);                      % Length of Signal

Total_time = mat(Length, 1) - mat(1, 1);
Total_time = Total_time * 24 * 60 * 60;

Fs = Length / Total_time;                   % Sampling Frequency
Period = 1 / Fs;                            % Sampling Period
Time_vector = mat(:,1);                     % Time vector


acc_x = mat(:,3);

figure(1);
plot(Time_vector, acc_x);
title('Time Domain of Acc_x');
xlabel('t (days)');
ylabel('Acc_x(t)');

freq_acc_x = fft(acc_x);
P2 = abs(freq_acc_x / Length);  
P1 = P2(1 : Length/2 + 1);
P1(2 : end - 1) = 2 * P1(2 : end - 1);

freq_vec = Fs * (0 : (Length/2)) / Length;

figure(2);
plot(freq_vec(1:50), P1(1:50));
title('Single-Sided Amplitude Spectrum of Acc_x');
xlabel('frequency(Hz)');
ylabel('|P1(f)|');
%axis([0, 50, 0, 0.1]);
