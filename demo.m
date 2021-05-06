% Copyright 2021 The C-SCSA Authors
% This file is part of the C-SCSA library.
%
% The C-SCSA library is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.

%definition of some gaussian parameters 
pos=[2,3.6,7,9]; %peak position
hgt= [2,4,4.5,7]; %peak hight 
wdt=[2,3,3,4]; %peak width

%step 1: low noise denoising with SCSA
[f, yf1, yf01]=Gaussian_signal_generation(pos,hgt,wdt,10); %signal generation
[ yscsa1,mse,snr ,psnr] = SCSAden( yf1,yf01,4); %signal denoising

%step 2: median noise denoising with SCSA
[f, yf2, yf02]=Gaussian_signal_generation(pos,hgt,wdt,50); %signal generation
[ yscsa2,mse,snr ,psnr] = SCSAden( yf2,yf02,4); %signal denoising

%step 3: high noise denoising with SCSA
[f, yf3, yf03]=Gaussian_signal_generation(pos,hgt,wdt,100); %signal generation
[ yscsa3,mse,snr ,psnr] = SCSAden( yf3,yf03,4); %signal denoising

%step 4: plot reusult
subplot(3,1,1) %low noise plot
plot(yscsa1,'b','LineWidth',2);hold on
plot(yf1+50 ,'r','LineWidth',2);hold on
plot(yf01-50,'g','LineWidth',2)
legend({'SCSA denoised Signal','Noisy Signal','True Signal'},'Location','northwest');
xlabel('Samples')
ylabel('Amplitude')
title('Low noise performance')
set(gca,'YTickLabel',[])
set(gcf,'color','w')

subplot(3,1,2) %median noise plot
plot(yscsa2,'b','LineWidth',2);hold on
plot(yf2+50 ,'r','LineWidth',2);hold on
plot(yf02-50,'g','LineWidth',2)
legend({'SCSA denoised Signal','Noisy Signal','True Signal'},'Location','northwest');
xlabel('Samples')
ylabel('Amplitude')
title('Median noise performance')
set(gca,'YTickLabel',[])
set(gcf,'color','w')

subplot(3,1,3) %high noise plot
plot(yscsa3,'b','LineWidth',2);hold on
plot(yf3+50 ,'r','LineWidth',2);hold on
plot(yf03-50,'g','LineWidth',2)
legend({'SCSA denoised Signal','Noisy Signal','True Signal'},'Location','northwest');
xlabel('Samples')
ylabel('Amplitude')
title('High noise performance')
set(gca,'YTickLabel',[])
set(gcf,'color','w')