% list all the skeleton data
% here for MSR-Pairs
list=dir('../../Dataset/skeleton/*.mat');
% number of joint
% MSR-pairs has 20 joints, torso joint is '2'
%MSR Action 3D has 20 joints, torso joint is '4'
% current test use MSR-Pairs dataset
% CAD60 Dataset has 15 joints, torso joint is '3'

% UWA3D single or multiview dataset has 15 joints, torso joint is '9'
% UWA skeleton may use 'dlmread' to read skeleton data
joints=20;
% torso joint ID --- MSR-Pairs
torsoID=4;
% define the same number of bin for each histogram
nbin=50;
% loop into each action
for ii=1:length(list)
    load(['../../Dataset/skeleton/' list(ii).name]);
    % compute joint position differences
    % all skeleton mat data has the name skeletonsequence
    frames=size(skeletonsequence, 3);
    [ deltaX, deltaY, deltad ] = computejpdifference( frames, skeletonsequence, torsoID,  joints);
    
    [NX, xedges]=histcounts(deltaX, nbin);
    [NY, yedges]=histcounts(deltaY, nbin);
    [Nd, dedges]=histcounts(deltad, nbin);
    jpdfeature=[NX, NY, Nd];
    save(['../../features/jpdfeatures/' list(ii).name 'jpd.mat'],...
        'jpdfeature');
    clear('jpdfeature');
    % here save jpd features!!!!!!
end