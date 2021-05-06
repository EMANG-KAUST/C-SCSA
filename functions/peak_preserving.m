gt=[];
peak1=[];
peak2=[];
peak3=[];
for i=1:20
pos=[1,2,3,3.5,4,6,8]; hgt= [2,3,2,1,3,2,.8]; wdt=[1,1.5,1,2,1.5,3,1];
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,i);
locs=peak_info(yf);
temp=locs(1);
gt(end+1)=temp;
y1=ma(yf,yf0);
locs=peak_info(y1);
peak1(end+1)=locs(1);
y2=sg(yf,yf0);
locs=peak_info(y2);
peak2(end+1)=locs(1);
y3=wa(yf',yf0');
locs=peak_info(y3);
peak3(end+1)=locs(1);
close all;
end
