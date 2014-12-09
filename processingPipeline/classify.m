function [] = classify( inputfile_hlf_train, inputfile_hlf_test, outputfile_classResults )
%CLASSIFY Summary of this function goes here
%   Detailed explanaoutput_argstion goes here

    data=0;
    
    % Load SVM 
    load(inputfile_hlf_train, 'data');
    trainData = data;
    
    load(inputfile_hlf_test, 'data');
  
    
    % We use Multisvm
    disp('Start to train and predict with SVM... this takes some time');
    data.class = multisvm(trainData.fv, trainData.targets, data.fv);
    disp('done!');  
    
    save(outputfile_classResults, 'data');   
end

