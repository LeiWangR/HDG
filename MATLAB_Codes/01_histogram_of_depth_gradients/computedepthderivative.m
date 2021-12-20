function [ quantizedM, deltastepsize ] = computedepthderivative( subvolume, drange, stepsize )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% stepsize can be ndx, ndy, ndt, and ngradient
deltastepsize=drange/stepsize;
% calculate the number of frames
frames=size(subvolume, 3);
for frame=1:frames
    quantizedM(:, :, frame)=ceil(subvolume(:, :, frame)/deltastepsize);
end

end

