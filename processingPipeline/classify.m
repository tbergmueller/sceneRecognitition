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
    %data.class = multisvm(trainData.fv, trainData.targets, data.fv);
    
    % code for LIBSVM:
    model = svmtrain(trainData.targets, trainData.fv(:,:,1)); % The indexing with (:,:,1) is of course bullshit here and just makes sure that libsvm can use the current data (just takes the first dimension value of the sift vectors). So this has to be removed when working with the high level features!
    [data.class, accuracy, dec_values] = svmpredict(data.targets, data.fv(:,:,1), model);
    disp('done!');  
    
    save(outputfile_classResults, 'data');   
end

