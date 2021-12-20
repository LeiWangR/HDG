clc;
clear;
rng(sum(clock));
% load global features
load(['../../features/globalfeatures/' 'globalfeature.mat']);
list=dir('../../Dataset/depth/*.mat');
% use half data for training and the remaining half for testing
% mat data name is 'globalF'
totalN=size(globalF, 1);
% define training & testing dataset
trainingF=[];
testingF=[];
% define training & testing label
classlabel=[];
labelcorrect=[];
for ii=1:totalN
    if(isempty(strfind(list(ii).name, 's01')) && isempty(strfind(list(ii).name, 's03'))...
            && isempty(strfind(list(ii).name, 's05')) && isempty(strfind(list(ii).name, 's07'))...
            && isempty(strfind(list(ii).name, 's09')))
        testing=globalF(ii, :);
        testingF=[testingF; testing];
        filenamelist=list(ii).name;
        labelc=str2double(filenamelist(4:5));
        labelcorrect=[labelcorrect; labelc];
    else
        training=globalF(ii, :);
        trainingF=[trainingF; training];
        filenamelist=list(ii).name;
        labelc=str2double(filenamelist(4:5));
        classlabel=[classlabel; labelc];
    end
end
%% use decision forests for feature selection
% threshold factor
factor=4;
Mdl=fitensemble(trainingF, classlabel, 'Bag', 180, 'Tree', 'type','classification');
imp=predictorImportance(Mdl);
% normalization
imp1=imp/norm(imp);
% mean importance
averageimp=mean(imp1);
theta=factor*averageimp;
[impnew, index]=sort(imp1, 'descend');
% find non-zero importance index
nonzeroind=find(impnew>theta);
% select important features
% generate new training set and testing set
trainingF=trainingF(:, index(nonzeroind));
testingF=testingF(:, index(nonzeroind));
%% second decision trees for classification
Mdl=TreeBagger(80, trainingF, classlabel, 'OOBPrediction', 'On', ...
    'Method', 'classification');

% prediction
% define a matrix to store final results
predictL=[];
for jj=1:size(testingF, 1)
    newfeature=testingF(jj, :);
    [predictlabel, score]= predict(Mdl, newfeature);
    predictL=[predictL; predictlabel];
end
predicted=str2double(predictL);
% confusion matrix
[ConM, order]=confusionmat(labelcorrect, predicted);
save(['../../Results/' 'confusionmatrix.mat'], 'ConM');

labelaction={
    'high arm wave','horizontal arm wave', 'hammer', 'hand catch', ...
    'forward punch', 'high throw', 'draw x', 'draw tick', 'draw circle', ...
    'hand clap', 'two hands wave', 'sideboxing', 'bend', 'forward kick', ...
    'side kick', 'jogging', 'tennis swing', 'tennis serve', 'golf swing', ...
    'pick up & throw'
    };
confusionmatplot(ConM, 6, labelaction);

hold on;
plotgrid( axis );

accuracy=sum(labelcorrect==predicted)/size(labelcorrect, 1);


% figure;
% oobErrorBaggedEnsemble=oobError(Mdl);
% plot(oobErrorBaggedEnsemble);
% xlabel 'Number of grown trees';
% ylabel 'Out-of-bag classification error';