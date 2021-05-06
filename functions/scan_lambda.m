%function [ lambda ] = scan_lambda( a,b,yf,yf0,f )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
gm=0.5; fs=1;
%%
% yf=temp;
% f=1:length(temp);
Denoising_coeff=100;
width_peaks=5;          %  The ratio w.r.t metabolite amplitude to set the threshold from which the peak can be selected
Th_peaks_ratio=2;       %  The with of the peak from its center(max values)
lambda1=[];
lambda2=[];
for k=1:10
pos=[2,3.6,4,7]; hgt= [3,2,2.5,3]; wdt=[2,1.5,1.75,0.8];
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,level(k));
yf=yf+5;
yf0=yf0+5;
u=[];
mse=[];
snr=[];
for i=1:0.2:15
    close all;
[harray,se,yscsa, h_op, Nh]=SCSA_MRS_Denoising(Denoising_coeff, f, yf, gm , fs , Th_peaks_ratio, width_peaks,i,yf0);
de=yscsa;
temp=(yf0-de)*(yf0-de)'/length(yf)
temp2=10*log(yf0*yf0'/((yf0-de)*(yf0-de)'))/log(10)
u(end+1)=i;
mse(end+1)=temp;
snr(end+1)=temp2;
end
[M,I]=min(mse);
lambda1(end+1)=u(I);
[M,I]=min(mse);
lambda2(end+1)=u(I);
end
%end

