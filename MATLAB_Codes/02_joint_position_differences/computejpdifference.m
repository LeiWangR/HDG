function [ deltaX, deltaY, deltad ] = computejpdifference( frames, skeletonsequence, torsoID,  jointsN)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
% define vector to save jpd features
deltaX=[];
deltaY=[];
deltad=[];
for jj=1:frames
    skeletonframe=skeletonsequence(:, :, jj);
    torsoposition=skeletonframe(torsoID, :);
    % do the joint position difference
    % define jpdifference to save differences
    jpdifference=[];
    for kk=1:jointsN
        if(kk~=torsoID)
            jpd=skeletonframe(kk, :)-torsoposition;
            jpdifference=[jpdifference;jpd];
        end
    end
    X=jpdifference(:, 1)';
    Y=jpdifference(:, 2)';
    d=jpdifference(:, 3)';
    deltaX=[deltaX, X];
    deltaY=[deltaY, Y];
    deltad=[deltad, d];
end

end

