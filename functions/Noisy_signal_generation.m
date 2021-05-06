function [f, yf, yf0]=Noisy_signal_generation(true_signal,level)
% x = linspace(0,1,1000);

% yf0 = ecg(500).';
% y15=sgolayfilt(yf0,0,15); 


%PeakSig=y15;
% true_signal=true_signal*20;
x=1:1:length(true_signal);
rng(1);
e= rand(1, length(true_signal));
e = (e- mean(e));
level1=level/100*max(true_signal);
level1;
generate_spectrum = true_signal + level1*e';
%plot(generate_spectrum)
% plot(x,generate_spectrum)
generate_spectrumb = true_signal;
f= 0:0.01:(length(true_signal)-1)*0.01;
yf = real(generate_spectrum);
yf0=real(generate_spectrumb);
yf=yf+30;
yf0=yf0+30;
for k=1:length(yf)
    if yf(k)<0
    Ind=1;
break
else 
    Ind = 0;
end 
end
er=max(level*e)/max(yf0)*100;
yt = real(generate_spectrum)- Ind*min(real(generate_spectrum));

%plot(generate_spectrum)
%findpeaks(yy1,x,'Annotate','extents','WidthReference','halfheight');

%widths
%locs
%findpeaks(yy1,x,'Annotate','extents')
%findpeaks(PeakSig,x,'MinPeakProminence',20,'Annotate','extents')
