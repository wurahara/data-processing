clear;
clc;
x = [1, 2, 3, 4, 5, 6, 7, 8];
y = rand(8, 1);

xp = 1: 0.1 :8;
y_interp = interp1(x, y, xp,'spline');

figure(1);
plot(x, y, 'ko','linewidth', 1.5);
figure(2);
plot(x, y, 'ko', xp, y_interp, 'k--','linewidth', 1.5);