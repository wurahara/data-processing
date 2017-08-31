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
%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You can obtain a copy of the GNU General Public License from
%   http://www.gnu.org/copyleft/gpl.html or by writing to
%   Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA.
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent k
if isempty(k)
    k=12.5/log(1+12.5/8.75);
end
af=abs(frq);
mel = sign(frq).*log(1+af/8.75)*k;
mr=(8.75+af)/k;
if ~nargout
    plot(frq,mel,'-x');
    xlabel(['Frequency (' xticksi 'Hz)']);
    ylabel(['Frequency (' yticksi 'Mel)']);
end

