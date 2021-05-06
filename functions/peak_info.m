function [ locs ] = peak_info( y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    x=1:1:length(y);   %horizontal axis of input_signal
y=y;
%y=smooth(x,input_signal,0.1,'loess');   %first smooth input signal to eliminate false alarm.
[pks,locs,widths,proms] = findpeaks(y,x);
y_pp = gradient(gradient(y));   %y_pp is the curvature at each point
compare=max(pks);               %this threshhold value is used to further eliminate false alarms
false_index=find(y(locs)<compare*0.2); %false_index is an array of the index of false alarm in "locs" array.
locs(false_index)=[];
widths(false_index)=[];             %eliminate flase alarms in findpeaks function
pks(false_index)=[];
noise_alarm_index=find(widths<4);         %eliminate noise peaks
locs(noise_alarm_index)=[];
widths(noise_alarm_index)=[];             %eliminate flase alarms in noise
pks(noise_alarm_index)=[];

end

