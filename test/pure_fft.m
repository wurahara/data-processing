%% Basis Setting
Fs = 1000;              % Sampling Frequency
T = 1 / Fs;             % Sampling Period
L = 1000;               % Length of Signal
t = (0 : L - 1) * T;    % Time vector

% Pure Signal
Signal = 0.7 * sin(2 * pi * 50 * t) + sin(2 * pi * 120 * t);

% White Gaussian Noise with Mean of 0 and Variance of 4
Noise = 2 * randn(size(t));

% Composed Signal
Xg = Signal + Noise;

%% Time Domain Analysis

% Plot Signal Xg in Time Domain
figure(1);
plot(1000 * t(1 : 50), Xg(1 : 50));
title('Signal Corrupted with Zero-Mean Random Noise');
xlabel('t (milliseconds)');
ylabel('Xg(t)');

%% Frequency Domain Analysis

% Fast Fourier Transform of Xg
Yg = fft(Xg);

% P2: Bilateral Spectrum of Xg
P2 = abs(Yg / L);
% P1: Unilateral Spectrum of Xg
P1 = P2(1 : L/2 + 1);
P1(2 : end - 1) = 2 * P1(2 : end - 1);

% Frequency Range
f = Fs * (0 : (L/2)) / L;

% Plot the Unilateral Spectrum P1
figure(2);
plot(f, P1);
title('Single-Sided Amplitude Spectrum of Xg(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

%% Frequency Domain of Pure Signal

Zg = fft(Signal);

P2z = abs(Zg / L);
P1z = P2z(1 : L/2 + 1);
P1z(2 : end - 1) = 2 * P1z(2 : end - 1);

figure(3);
plot(f, P1z);
title('Single-Sided Amplitude Spectrum of Signal(t)');
xlabel('f (Hz)');
ylabel('|P1z(f)|');
