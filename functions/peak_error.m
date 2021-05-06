function [ position_error,relative_amplitude_error ] = peak_error( yf,yf0 )
%peak_dtermining Summary of this function goes here
%   yf is denoised signal and yf0 is ground truth here
[pks,locs] = findpeaks(yf);
[M,I] = max(pks);
peak_position=locs(I);
peak_amplitude=M;
[pks,locs]=findpeaks(yf0);
peak_p_cmp=locs(1);
peak_a_cmp=pks;
position_error=abs(peak_position-peak_p_cmp);
relative_amplitude_error=abs(peak_amplitude-peak_a_cmp)/peak_a_cmp*100;
end

