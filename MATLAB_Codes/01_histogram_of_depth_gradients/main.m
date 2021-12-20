% define the size for each bin
ndx=5;
ndy=5;
ndt=5;
ndm=5;
%
p=10;
q=10;
t=5;

% list all the action volume in the dataset
list=dir('../../Dataset/actionvolume/*.mat');
% loop into each action volume
for ii=1:length(list)
    % load an action volume
    load(['../../Dataset/actionvolume/' list(ii).name]);
    depthsequence=actionvolume;
    % compute depth gradient in x, y & t directions
    [dx, dy, dt]=gradient(double(depthsequence));
    % compute gradient magnitude
    [ magnitude ] = computegradientmagnitude( dx, dy, dt );
    
    % find depth derivative range in x, y & t directions
    [ dxrange, dxmax, dxmin ] = depthderivativerange( dx );
    [ dyrange, dymax, dymin ] = depthderivativerange( dy );
    [ dtrange, dtmax, dtmin ] = depthderivativerange( dt );
    [ dmrange, dmmax, dmmin ] = depthderivativerange( magnitude );
    
    %
    dxsubvolume=dividevolume(dx, p, q, t);
    dysubvolume=dividevolume(dy, p, q, t);
    dtsubvolume=dividevolume(dt, p, q, t);
    dmsubvolume=dividevolume(magnitude, p, q, t);
    
    % compute histogram for each subvolume then concatenating
    [ gradientfeatureX ] = gradienthistogram( dxsubvolume, p, q, t, dxrange, ndx, dxmax, dxmin);
    [ gradientfeatureY ] = gradienthistogram( dysubvolume, p, q, t, dyrange, ndy, dymax, dymin);
    [ gradientfeatureT ] = gradienthistogram( dtsubvolume, p, q, t, dtrange, ndt, dtmax, dtmin);
    [ gradientfeatureM ] = gradienthistogram( dmsubvolume, p, q, t, dmrange, ndm, dmmax, dmmin);
    
    gradientfeature=[gradientfeatureX, gradientfeatureY, gradientfeatureT, gradientfeatureM];
    save(['../../features/depthgradientfeature/' list(ii).name 'ddf.mat'],'gradientfeature');
    clear('gradientfeature');
end