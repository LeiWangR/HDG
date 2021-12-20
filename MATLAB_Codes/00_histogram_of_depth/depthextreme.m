function [ dmax, dmin ] = depthextreme( depthvideo )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
frameN=size(depthvideo, 3);
maxD=[];
minD=[];
for frame=1:frameN
    im=depthvideo(:,:,frame);
    % find maximum and minimum depth in the action volume
    maxd=max(max(im));
    % non-zero minimum
    mind=min(im(im>0));
    
    maxD=[maxD, maxd];
    minD=[minD, mind];
end
% maximum and minimum depth values found!
dmax=max(maxD);
dmin=min(minD);
end

