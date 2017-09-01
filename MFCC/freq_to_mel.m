function [ mel, mr ] = freq_to_mel( frq )
%FREQ_TO_MEL Convert Hertz to Mel frequency scale MEL=(FRQ)
%    [mel,mr] = frq2mel(frq) converts a vector of frequencies (in Hz)
%    to the corresponding values on the Mel scale which corresponds
%    to the perceived pitch of a tone.
%    mr gives the corresponding gradients in Hz/mel.
%
%    m = ln(1 + f/8.75) * 12.5 / ln(1+12.5/8.75)
%
%      This means that m(12.5) = 12.5

persistent k
if isempty(k)
    k=12.5/log(1+12.5/8.75);
end
af=abs(frq);
mel = sign(frq).*log(1+af/8.75)*k;
mr=(8.75+af)/k;
if ~nargout
    plot(frq,mel,'-');
    xlabel(['Frequency (' xticksi 'Hz)']);
    ylabel(['Frequency (' yticksi 'Mel)']);
end
end