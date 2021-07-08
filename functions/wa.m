function [de, mse,snr,psnr ] = wa( yf,yf0 )
xdMODWT = wden(yf,'modwtsqtwolog','s','mln',3,'sym4');
 plot(yf0)
 hold on;
 plot(xdMODWT)
 %hold on
 %plot(y)
 legend('Original Signal ','Denoised Signal (wavelet)')
close all
% close all
%de=de';
de=xdMODWT;
yf0=yf0;
yf=yf;

mse=(yf0-de)*(yf0-de)'/length(yf);
psnr=max(de)/std(de(1:11));
snr=10*log(yf0*yf0'/((yf0-de)*(yf0-de)'))/log(10);

