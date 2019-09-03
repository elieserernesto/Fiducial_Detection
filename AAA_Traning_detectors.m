% Script for training the any detector ...!!!!
% You only need to change the path of the postives and negatives samples, and
% use the corresponding GROUNDTRUTH variable from the ImageLabeler app in
% the Computer Vision Toolbox
clc

positiveInstances = gTruth(:,1:1).DataSource.Source;% gTruth is the GROUNDTRUTH variable
positiveInstances = cell2table(positiveInstances);

positiveInstances = [positiveInstances,gTruth.LabelData(:,1)];

positive_directory = fullfile('E:\10_Electrodes_recognition\training cascade object detector\orejas_D\');% Path for positives samples used to generate the GROUNDTRUTH variable with ImageLabeler

addpath(positive_directory);

neg_dir = fullfile('E:\10_Electrodes_recognition\training cascade object detector\no_orejas\');% Path for negatives samples

tic 
% trainCascadeObjectDetector('trained_model_for_R_ear_detector.xml',positiveInstances,...
%     neg_dir,'FalseAlarmRate',0.9,'NumCascadeStages',1000);

trainCascadeObjectDetector('trained_model_for_L_ear_detector.xml',positiveInstances,...
    neg_dir,'FalseAlarmRate',0.9,'NumCascadeStages',1000);
toc
