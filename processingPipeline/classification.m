function [accuracy, dec_values] = classification( inputfile_hlf_train, inputfile_hlf_test, outputfile_classResults )
%CLASSIFY Summary of this function goes here

    data=0;
    
    load(inputfile_hlf_train, 'data_train_hl');
    
    load(inputfile_hlf_test, 'data_test_hl');
  
    disp('Start to train and predict with SVM');

    % code for LIBSVM:
    model = svmtrain(data_train_hl.targets, data_train_hl.fv); % uses radial basis kernel
    
    %model = svmtrain(data_train_hl.targets, data_train_hl.fv,'-s 1 -t 1 -d 3'); % uses polynomial kernel of degree 3
    [data_test_hl.class, accuracy, dec_values] = svmpredict(data_test_hl.targets, data_test_hl.fv, model);

    disp('done!');  
    
    save(outputfile_classResults, 'data_test_hl');   
end


















