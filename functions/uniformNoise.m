function [n] = uniformNoise(length,level)
rng('default');
e= rand(1, length);
n=level*e;
end

