clear all;
close all;
clc;


%% FILENAMES
llfTest = '../intermedResults/test.llf.mat';
llfTrain = '../intermedResults/train.llf.mat';

hlfTest = '../intermedResults/test.hlf.mat';
hlfTrain = '../intermedResults/train.hlf.mat';
classifiedTest = '../intermedResults/test.classified.mat';


%% LL FeatureExtraction
% Extract LowelevelFeatures
LLFE('../data/db/train/', llfTrain);
LLFE('../data/db/test/', llfTest);


%% HL FeatureExtraction
% Extract High Level features
HLFE( llfTrain, hlfTrain);
HLFE( llfTest, hlfTest);


%% Classification
classify(hlfTrain,hlfTest,classifiedTest);

%% Evaluation
acc = evaluateAccuracy(classifiedTest);

% Evaluation
disp(['Recognition rate with this setting is ' num2str(acc)]);
