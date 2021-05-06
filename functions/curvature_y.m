function [ c ] = curvature_y( y )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
c=abs(gradient(gradient(y)));
temp=(1+gradient(y).^2).^1.5;
c=c./temp;

end

