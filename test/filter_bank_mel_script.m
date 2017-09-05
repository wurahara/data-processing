clear;clc;

%% parameters definition

bank_num = 20;
length = 200;
fs = 100;
frq_low = 0;
frq_high = 0.5;


%% process the parameters
side = 2;
freq_range = [frq_low frq_high] * fs;
mel_freq_range = freq_to_mel(freq_range);               % convert frequency limits into mel
mel_freq_len = mel_freq_range * (-1: 2: 1)';        % mel range
Nyq_freq = floor(length/2);                         % bin index of highest positive frequency (Nyquist if length is even)
melinc = mel_freq_len / (bank_num + 1);

%% Calculate the FFT bins corresponding to [filter#1-low filter#1-mid filter#p-mid filter#p-high]
blim = mel_to_freq( mel_freq_range(1) + [0 1 bank_num bank_num+1] * melinc )* length / fs;
centre_freq = mel_freq_range(1) + (1 : bank_num) * melinc;           % mel centre frequencies
b1 = floor( blim(1) ) + 1;                          % lowest FFT bin_0 required might be negative
b4 = min(Nyq_freq , ceil(blim(4)) - 1);                  % highest FFT bin_0 required

%% now map all the useful FFT bins_0 to filter1 centres
pf = ( freq_to_mel( (b1 : b4) * fs / length ) - mel_freq_range(1) ) / melinc;

%%  remove any incorrect entries in pf due to rounding errors
if pf(1) < 0
    pf(1) = [];
    b1 = b1 + 1;
end

if pf(end) >= bank_num + 1
    pf(end) = [];
    b4 = b4 - 1;
end

fp = floor(pf);                                     % FFT bin_0 i contributes to filters_1 fp(1+i-b1)+[0 1]
pm = pf - fp;                                       % multiplier for upper filter
k2 = find(fp > 0, 1);                               % FFT bin_1 k2+b1 is the first to contribute to both upper and lower filters
k3 = find(fp < bank_num, 1, 'last');                         % FFT bin_1 k3+b1 is the last to contribute to both upper and lower filters
k4 = numel(fp);                                     % FFT bin_1 k4+b1 is the last to contribute to any filters
if isempty(k2)
    k2 = k4 + 1;
end
if isempty(k3)
    k3 = 0;
end

r = [1 + fp(1 : k3) fp(k2 : k4)];                   % filter number_1
c=[1:k3 k2:k4];                                     % FFT bin_1 - b1
v=[pm(1:k3) 1-pm(k2:k4)];
mn = b1 + 1;                                        % lowest fft bin_1
mx = b4 + 1;                                        % highest fft bin_1


if b1 < 0
    c = abs(c + b1 - 1) - b1 + 1;                   % convert negative frequencies into positive
end


if side == 2                                   % double all except the DC and Nyquist (if any) terms
    msk = (c + mn > 2) & (c + mn < length - Nyq_freq + 2);    % there is no Nyquist term if n is odd
    v(msk) = 2 * v(msk);
end

%% sort out the output argument options
x = sparse(r, c+mn-1, v, bank_num, 1 + Nyq_freq);

%% plot results if no output arguments or g option given
ng=201;                                         % 201 points
me = mel_freq_range(1) + (0:bank_num+1)' * melinc;

fe = mel_to_freq(me);                           % defining frequencies
xg = mel_to_freq( repmat( linspace(0,1,ng), bank_num, 1 ) .* repmat( me(3:end)-me(1:end-2), 1, ng ) + repmat( me(1:end-2), 1, ng) );

v = 1 - abs( linspace(-1,1,ng) );

v = v * side;                                   % multiply by 2 if double sided

v = repmat(v, bank_num, 1);

plot(xg', v', 'b');
set(gca, 'xlim', [fe(1) fe(end)]);
xlabel(['Frequency (' xticksi 'Hz)']);
