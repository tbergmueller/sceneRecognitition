clear all;
close all;
clc;

% for using libsvm (make sure to update the path here! otherwise the MATLAB inbuilt functions are used which cannot perform a multiclass SVM classification!)
addpath C:\libsvm-3.20
addpath C:\libsvm-3.20\matlab

% parameters
k = 300; % for K-MEANS
NrOfFeaturesForClustering = 10000; % this features are then randomly taken from all available features


%% FILENAMES
llfTest = '../intermedResults/test.llf.mat';
llfTrain = '../intermedResults/train.llf.mat';

hlfTest = '../intermedResults/test.hlf.mat';
hlfTrain = '../intermedResults/train.hlf.mat';
classifiedTest = '../intermedResults/test.classified.mat';

%% LL FeatureExtraction
% Extract Low Level features
LLFE('../data/db_10/train/', llfTrain);
LLFE('../data/db_10/test/', llfTest);

%% HL FeatureExtraction
%Extract High Level features
HLFE(llfTrain, hlfTrain, llfTest, hlfTest, k, NrOfFeaturesForClustering);


%% Classification
[accuracy, dec_values] = classification(hlfTrain,hlfTest,classifiedTest);

%% Evaluation
acc = evaluateAccuracy(classifiedTest);

% Evaluation
disp(['Recognition rate with this setting is ' num2str(acc)]);

































