% number of the depth features are the same as skeleton features
% but must be checked before concatenating
listdf=dir('../../features/depthfeature/*df.mat');
listdgf=dir('../../features/depthgradientfeature/*ddf.mat');
listjmvf=dir('../../features/jmvfeatures/*jmv.mat');
listjpdf=dir('../../features/jpdfeatures/*jpd.mat');

totalaction=length(listdf);

% store global features into a huge matrix
globalF=[];
for ii=1:totalaction
    % all depth features have a same name 'depthhistogram'
    load(['../../features/depthfeature/' listdf(ii).name]);
    dfeature=depthhistogram;
    % all depth gradient features have a same name 'gradientfeature'
    load(['../../features/depthgradientfeature/' listdgf(ii).name]);
    dgfeature=gradientfeature;
    % all jmv features have a same name 'jmvvector'
    load(['../../features/jmvfeatures/' listjmvf(ii).name]);
    jmfeature=jmvvector;
    % all jpd features have a same name 'jpdfeature'
    load(['../../features/jpdfeatures/' listjpdf(ii).name]);
    jpfeature=jpdfeature;
    % concatenating 
    globalfeature=[dfeature, dgfeature, jpfeature, jmfeature];
    % save globalfeature for each action
%     save(['../../features/globalfeatures/' listdf(ii).name 'global.mat'],...
%         'globalfeature');
%     clear('globalfeature');
    globalF=[globalF; globalfeature];
    
end
save(['../../features/globalfeatures/' 'globalfeature.mat'], 'globalF');
clear('globalF')

