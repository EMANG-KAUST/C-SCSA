function [ de,h_optimal,snr ] = SCSA_H_Select( yf,yf0 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
min=norm(scsa_build(0.01*max(yf),yf)-yf0);
h_optimal=0.01*max(yf);
for h=0.01*max(yf):0.5*max(yf)
    h
if norm(scsa_build(h,yf)-yf0)<min
    min=norm(scsa_build(h,yf)-yf0);
    h_optimal=h;
end

end
de=scsa_build(h_optimal,yf);
if size(yf0,1)>1
    yf0=yf0';
    yf=yf';
    de=de';
end
mse=(yf0-de)*(yf0-de)'/length(yf);
snr=10*log(yf0*yf0'/((yf0-de)*(yf0-de)'))/log(10)
psnr=max(de)/std(de(1:11));

