function [ distance ] = jointtorsodistance( torsoposition, jointcentroid )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
displacement=jointcentroid-torsoposition;
distance=norm(displacement);
end

