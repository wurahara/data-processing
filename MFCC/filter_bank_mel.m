function [ x, centre_freq, mn, mx ] = filter_bank_mel( bank_num, length, fs, frq_low, frq_high )
%FILTER_BANK_MEL determine matrix for a mel-spaced filterbank [X,CENTRE_FREQ,MN,MX]=(BANK_NUM,LENGTH,FS,FRQ_LOW,FRQ_HIGH)

%% process the parameters
side_fact = 2;
mflh = [frq_low frq_high] * fs;
mflh = freq_to_mel(mflh);                               % convert frequency limits into mel
melrng = mflh * (-1: 2: 1)';                        % mel range
fn2 = floor(length/2);                              % bin index of highest positive frequency (Nyquist if n is even)
melinc = melrng / (bank_num + 1);

%% Calculate the FFT bins corresponding to [filter#1-low filter#1-mid filter#p-mid filter#p-high]

blim = mel_to_freq( mflh(1) + [0 1 bank_num bank_num+1] * melinc )* length / fs;
centre_freq = mflh(1) + (1 : bank_num) * melinc;           % mel centre frequencies
b1 = floor( blim(1) ) + 1;                          % lowest FFT bin_0 required might be negative
b4 = min(fn2 , ceil(blim(4)) - 1);                  % highest FFT bin_0 required

%% now map all the useful FFT bins_0 to filter1 centres
pf = ( freq_to_mel( (b1 : b4) * fs / length ) - mflh(1) ) / melinc;

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


if side_fact == 2                                   % double all except the DC and Nyquist (if any) terms
    msk = (c + mn > 2) & (c + mn < length - fn2 + 2);    % there is no Nyquist term if n is odd
    v(msk) = 2 * v(msk);
end

%% sort out the output argument options

if nargout > 2
    x = sparse(r, c, v);
    if nargout == 3                                 % if exactly three output arguments, then
        centre_freq = mn;                           % delete mc output for legacy code compatibility
        mn = mx;
    end
else
    x = sparse(r, c+mn-1, v, bank_num, 1 + fn2);
end

%% plot results if no output arguments or g option given

if ~nargout          % plot idealized filters
    ng=201;                         % 201 points
    me=mflh(1)+(0:bank_num+1)'*melinc;
    
    fe=mel_to_freq(me);         % defining frequencies
    xg=mel_to_freq(repmat(linspace(0,1,ng),bank_num,1).*repmat(me(3:end)-me(1:end-2),1,ng)+repmat(me(1:end-2),1,ng));
    
    v=1-abs(linspace(-1,1,ng));
   
    v=v * side_fact;                      % multiply by 2 if double sided
    v=repmat(v,bank_num,1);

    plot(xg',v','b');
    set(gca,'xlim',[fe(1) fe(end)]);
    xlabel(['Frequency (' xticksi 'Hz)']);
end

end