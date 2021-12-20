list=dir('../../Dataset/skeleton/a*.mat');
joints=20;
torsoID=4;

% define joint volume size
nnx=1;
nny=1;
nnd=5;
njointb=5;

for ii=1:length(list)
    load(['../../Dataset/skeleton/' list(ii).name]);
    
    % find x, y and d extreme values in each action
    % all skeleton data here is named as 'skeletonsequence'
    skeletonX=skeletonsequence(:, 1, :);
    skeletonY=skeletonsequence(:, 2, :);
    skeletond=skeletonsequence(:, 3, :);
    
    torsojoint=skeletonsequence(torsoID, :, :);
    torsoJ=permute(torsojoint, [3 2 1]);
    % compute the mean of torso position in one action
    torsomean=mean(torsoJ);
    % store jmv feactures
    jmvvector=[];
    for joint=1:joints
        [ lxrange, xrangemax, xrangemin ]=computejmvrange( joint, skeletonX );
        [ lyrange, yrangemax, yrangemin ]=computejmvrange( joint, skeletonY );
        [ ldrange, drangemax, drangemin ]=computejmvrange( joint, skeletond );
        
        jointvolume=lxrange*lyrange*ldrange;
        
        % calculate the distance between each joint centroid and the torso joint
        jointcentroid=[lxrange/2, lyrange/2, ldrange/2];
        [ distance ] = jointtorsodistance( torsomean, jointcentroid );
        
        % compute depth variation histogram
        onejointd=skeletond(joint, :, :);
        jointsubvolume=dividevolume( onejointd, nnx, nny, nnd );
        jointmotionV=computejointsubvolumehist( jointsubvolume, nnx, nny, nnd, njointb,  drangemax, drangemin);
        
        vector=[jointvolume, lxrange, lyrange, ldrange, distance, jointmotionV];
        jmvvector=[jmvvector, vector];
    end
    save(['../../features/jmvfeatures/' list(ii).name 'jmv.mat'],...
        'jmvvector');
    clear('jmvvector');
end