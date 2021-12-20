clc;
clear;
rng(sum(clock));
% load global features
load(['../../features/globalfeatures/' 'globalfeature.mat']);
list=dir('../../Dataset/depth/a*.mat');
% use half for training and the remaining half for testing
% mat data name is 'globalF'
totalN=size(globalF, 1);
% define training & testing dataset
trainingF=[];
testingF=[];
% define training & testing label
classlabel=[];
labelcorrect=[];
for ii=1:totalN
    % select view A & B for training
    if(~isempty(strfind(list(ii).name, 'v01')) || ~isempty(strfind(list(ii).name, 'v02')))
        training=globalF(ii, :);
        trainingF=[trainingF; training];
        filenamelist=list(ii).name;
        labelc=str2double(filenamelist(2:3));
        classlabel=[classlabel; labelc];
    else
        % select view C (or D) for testing
        if(~isempty(strfind(list(ii).name, 'v03')))
            testing=globalF(ii, :);
            testingF=[testingF; testing];
            filenamelist=list(ii).name;
            labelc=str2double(filenamelist(2:3));
            labelcorrect=[labelcorrect; labelc];
        end
    end
end
%% use decision forests for feature selection
% threshold factor
factor=8;
Mdl=fitensemble(trainingF, classlabel, 'Bag', 100, 'Tree', 'type','classification');
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
% set fontsize smaller for confusion matrix;

labelaction={
    'one hand waving', 'one hand punching', 'two hand waving', 'two hand punching', 'sitting down', ...
    'standing up', 'vibrating', 'falling down', 'holding chest', 'holding head', 'holding back', ...
    'walking', 'irregular walking', 'lying down', 'turning around', 'drinking', 'phone answering', ...
    'bending', 'jumping jack', 'running', 'picking up', 'putting down', 'kicking', 'jumping', 'dancing', ...
    'moping floor', 'sneezing', 'sitting down(chair)', 'squatting', 'coughing'
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