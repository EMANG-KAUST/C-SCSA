function [ yscsa,mse,snr ,psnr] = SCSAden( yf,yf0,v )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
gm=0.5; fs=1;
%%
% yf=temp;
% f=1:length(temp);
 f=1:length(yf);
Denoising_coeff=0.000000000005;
width_peaks=5;          %  The ratio w.r.t metabolite amplitude to set the threshold from which the peak can be selected
Th_peaks_ratio=2;       %  The with of the peak from its center(max values)
y_p1=gradient(yf);
    y_p2=gradient(y_p1);
    curv=abs(y_p2)./(1+y_p1.^2).^(1.5);
  lambda=max(yf)/sum(curv)*10^v;
  figure
[t,harray,se,yscsa, Nh]=SCSA_MRS_Denoising(Denoising_coeff, f, yf, gm , fs , Th_peaks_ratio, width_peaks,lambda,yf0);
figure
disp('Nh')
Nh
de=yscsa;
plot(de)
hold on
plot(yf0)
if size(yf0,1)>1
    yf0=yf0';
    yf=yf';
    de=de';
end

mse=(yf0-de)*(yf0-de)'/length(yf);
snr=10*log(yf0*yf0'/((yf0-de)*(yf0-de)'))/log(10);
psnr=max(de)/std(de(1:11));

 close all
 plot(t)
 hold on
 plot(harray)
 plot(se)
 
legend('t','harray','se')
x=1:length(yf);
x=x/100;
close all;
end

