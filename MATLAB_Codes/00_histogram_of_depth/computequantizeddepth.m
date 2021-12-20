function [ depthvalue ] = computequantizeddepth( subvolume, delta_d )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% calculate the size of the subvolume
frames=size(subvolume, 3);

for frame=1:frames
    depthvalue(:, :, frame)=ceil(subvolume(:, :, frame)/delta_d);
end

end

