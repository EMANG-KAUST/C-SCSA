function [Denoised_signal,mse,snr,psnr ] = SCSA_assembly_opt(yf,yf0,intervals )
Denoised_signal=[];
for i = 1:size(intervals,1)
    ind=intervals(i,:);
    close all;
    [ de,h_optimal,snr ] = SCSA_H_Select( yf(ind(1):ind(2))',yf0(ind(1):ind(2))' )
    Denoised_signal=[Denoised_signal,de];
end
de=Denoised_signal';
if size(yf0,1)>1
    yf0=yf0';
    yf=yf';
    de=de';
end
mse=(yf0-de)*(yf0-de)'/length(yf);
snr=10*log(yf0*yf0'/((yf0-de)*(yf0-de)'))/log(10);
psnr=max(de)/std(de(1:11));
%[1,150;151,350;351,length(yf0)]
end