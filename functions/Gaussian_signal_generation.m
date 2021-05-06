function [f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,level)
x = linspace(0,1,1000);
Pos = pos/10;
Hgt = hgt;
Wdt = wdt/100;

for n = 1:length(Pos)
    Gauss(n,:) = Hgt(n)*exp(-((x - Pos(n))/Wdt(n)).^2);
end
% yf0 = ecg(500).';
% y15=sgolayfilt(yf0,0,15); 
if n==1
PeakSig=Gauss;
else
    
PeakSig = sum(Gauss);
end
%PeakSig=y15;

PeakSig=PeakSig*20;
x=1:1:length(PeakSig);
rng('default');
e= rand(1, length(PeakSig));
e = (e- mean(e));
level1=level/100*max(PeakSig);
length(PeakSig);
length(e);
%e=rescale( load_signal('gaussiannoise',length(PeakSig)) );
%e=e';
size(e)
size(PeakSig)
generate_spectrum = PeakSig + level1*e;
% plot(generate_spectrum);
% 
% 
% plot(x,generate_spectrum)
generate_spectrumb = PeakSig;
f= 0:0.01:(length(PeakSig)-1)*0.01;
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

er=max(level*e)/max(yf0)*100
yt = real(generate_spectrum)- Ind*min(real(generate_spectrum));

%plot(generate_spectrum)
%findpeaks(yy1,x,'Annotate','extents','WidthReference','halfheight');

%widths
%locs
%findpeaks(yy1,x,'Annotate','extents')
%findpeaks(PeakSig,x,'MinPeakProminence',20,'Annotate','extents')
