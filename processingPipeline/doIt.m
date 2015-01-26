clear all;
close all;
clc;

% for using libsvm
addpath C:\libsvm-3.20
addpath C:\libsvm-3.20\matlab


%% FILENAMES
llfTest = '../intermedResults/test.llf.mat';
llfTrain = '../intermedResults/train.llf.mat';

hlfTest = '../intermedResults/test.hlf.mat';
hlfTrain = '../intermedResults/train.hlf.mat';
classifiedTest = '../intermedResults/test.classified.mat';

%% LL FeatureExtraction
% Extract Low Level features
LLFE('../data/db_small/train/', llfTrain);
LLFE('../data/db_small/test/', llfTest);

%% HL FeatureExtraction
%Extract High Level features
HLFE(llfTrain, hlfTrain, llfTest, hlfTest);


%% Classification
[accuracy, dec_values] = classify(hlfTrain,hlfTest,classifiedTest)

%% Evaluation
acc = evaluateAccuracy(classifiedTest);

% Evaluation
disp(['Recognition rate with this setting is ' num2str(acc)]);

































