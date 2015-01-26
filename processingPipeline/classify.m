function [accuracy, dec_values] = classify( inputfile_hlf_train, inputfile_hlf_test, outputfile_classResults )
%CLASSIFY Summary of this function goes here
%   Detailed explanaoutput_argstion goes here

    data=0;
    
    % Load SVM 
    load(inputfile_hlf_train, 'data_train_hl');
    %trainData = data;
    
    load(inputfile_hlf_test, 'data_test_hl');
  
    disp('Start to train and predict with SVM... this takes some time');
    
    % code for LIBSVM:
    model = svmtrain(data_train_hl.targets, data_train_hl.fv); % The indexing with (:,:,1) is of course bullshit here and just makes sure that libsvm can use the current data (just takes the first dimension value of the sift vectors). So this has to be removed when working with the high level features!
    [data_test_hl.class, accuracy, dec_values] = svmpredict(data_test_hl.targets, data_test_hl.fv, model);
    disp('done!');  
    
    save(outputfile_classResults, 'data_test_hl');   
end


















