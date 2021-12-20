function [ actionvolume ] = createactionvolume( depthvideo )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
frameN=size(depthvideo, 3);
point1=[];
point2=[];
for frame=1:frameN
    % use 'segmentforeground' function
    [p1, p2]=segmentforeground(depthvideo(:, :, frame));
    point1=[point1; p1];
    point2=[point2; p2];
end
% find two points for one action
pointmin=min(point1);
pointmax=max(point2);

actionvolume=depthvideo(pointmin(1):pointmax(1), pointmin(2):pointmax(2),:);

end

