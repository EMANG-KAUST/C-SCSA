function  [ de,mse,snr ,psnr] = emd_den( yf,yf0 )
eig_f=emd(yf);
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
y=zeros(1,size(eig_f,2));
eig_f = emd(yf);

for i=1:size(eig_f,1)
%     plot(eig_proc(eig_f(i,:),eig_f,0.00006,2,i))
%     hold on
    
    y=y+eig_proc(eig_f(i,:),eig_f,0.0006,4,i);
   
end

de=y;
 mse=(yf0-de)*(yf0-de)'/length(yf);
snr=10*log(yf0*yf0'/((yf0-de)*(yf0-de)'))/log(10);
psnr=max(de)/std(de(1:11));
% hold on
% plot(yf-30)
% hold on
% plot(yf0+30)
% hold on
% plot(sum(eig_f,  2)+10)