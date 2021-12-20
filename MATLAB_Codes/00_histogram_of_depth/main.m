% list all the depth sequence in one dataset
list=dir('../../Dataset/depth/*.mat');
% ----------compute each action volume save as actionvolume dataset
% loop into each action
for ii=1:length(list)
    % load a depth sequence
    % the depth video is named as 'inDepthVideo'
    load(['../../Dataset/depth/' list(ii).name]);
    depthsequence=inDepthVideo;
    % get the action volume use 'createactionvolume' function
    actionvolume=createactionvolume(depthsequence);
    % save actionvolume to Dataset
    save(['../../Dataset/actionvolume/' list(ii).name 'av.mat'],...
        'actionvolume');
    clear('actionvolume');
end

% ----------find the maximum and minimum depth values in each action volume
% ----------divide each action volume into subvolumes
p=10;
q=10;
t=5;
% total number of subvolumes
nv=p*q*t;
% number of equal steps for histogram
nd=5;

% define vectors to store depth minimum and maximum values in each frame
listav=dir('../../Dataset/actionvolume/*.mat');

for aN=1:length(listav)
    load(['../../Dataset/actionvolume/' listav(aN).name]);
    depthsequence=actionvolume;
    
    % calculate the size of actionvolume
    P=size(depthsequence, 1);
    Q=size(depthsequence, 2);
    T=size(depthsequence, 3);
    subvolumesize=(P*Q*T)/(p*q*t);
    
    [ dmax, dmin ] = depthextreme( depthsequence );
    
    % calculate the step size
    delta_d=(dmax-dmin)/nd;
    
    hismax=ceil(round((dmax/delta_d)*100)/100);
    hismin=ceil(round((dmin/delta_d)*100)/100);
    
    subvolume=dividevolume(depthsequence, p, q, t);
    % save subvolume
    save(['../../Dataset/subvolume/' listav(aN).name 'sv.mat'],'subvolume');
    
    [ depthhistogram ] = computedepthhistogram( subvolume, p, q, t, delta_d, subvolumesize, nd, hismax, hismin );
    % save depth histogram for each action volume based on unique ID
    save(['../../features/depthfeature/' listav(aN).name 'df.mat'],'depthhistogram');
    clear('subvolume', 'depthhistogram');
end