clear;clc;

load('mat_interped_test.mat');
mat = mat_test;

timestamp = mat(:,1);
acc_x = mat(:,3);

fast = fft(acc_x);