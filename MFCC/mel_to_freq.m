function [ frq, mr ] = mel_to_freq( mel )
%MEL_TO_FREQ  Convert Mel frequency scale to Hertz FRQ=(MEL)
%    frq = mel2frq(mel) converts a vector of Mel frequencies
%    to the corresponding real frequencies.
%    mr gives the corresponding gradients in Hz/mel.
%    The Mel scale corresponds to the perceived pitch of a tone
%
%    m = ln(1 + f/8.75) * 12.5 / ln(1+12.5/8.75)
%
%      This means that m(12.5) = 12.5

persistent k
if isempty(k)
    k=12.5/log(1+12.5/8.75);
end
frq=8.75*sign(mel).*(exp(abs(mel)/k)-1);
mr=(700+abs(frq))/k;
if ~nargout
    plot(mel,frq,'-');
    xlabel(['Frequency (' xticksi 'Mel)']);
    ylabel(['Frequency (' yticksi 'Hz)']);
end
end