function [ drange, dmax, dmin ] = depthderivativerange( depthderivative )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
d_max=[];
d_min=[];
frameN=size(depthderivative, 3);
for frame=1:frameN
    dmax=max(max(depthderivative(:,:, frame)));
    dmin=min(min(depthderivative(:,:, frame)));
    d_max=[d_max, dmax];
    d_min=[d_min, dmin];
end
dmax=max(d_max);
dmin=min(d_min);
drange=dmax-dmin;
end

