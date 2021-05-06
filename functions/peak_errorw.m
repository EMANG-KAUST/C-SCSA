function [ width_error ] = peak_errorw( yf,yf0 )
%peak_dtermining Summary of this function goes here
%   yf is denoised signal and yf0 is ground truth here
yf=smooth(yf);
[pks,locs,peakWidth1,p] = findpeaks(yf);
[pks,locs,peakWidth2,p] = findpeaks(yf0);
if size(peakWidth1,2)>1
    width_error= 5;
    return
end

width_error=(norm(peakWidth1-peakWidth2))/norm(peakWidth2);
end
%[pks,locs,] = findpeaks(y,x,'MinPeakProminence',0.006);