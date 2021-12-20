function [ lrange, rangemax, rangemin ] = computejmvrange( joint, skeletonPart )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% find each joint extreme
vec=skeletonPart(joint, :, :);
vector=permute(vec, [2 3 1]);
rangemax=max(vector);
rangemin=min(vector);
lrange=rangemax-rangemin;

end

