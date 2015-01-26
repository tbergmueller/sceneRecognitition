function [ accuracy ] = evaluateAccuracy( fname_classResults )
%EVAL Summary of this function goes here
%   Detailed explanation goes here


   load(fname_classResults);
    
    N = length(data_test_hl.targets);
    
    matches = 0;
    for i=1:N
        if data_test_hl.targets(i) == data_test_hl.class(i)
            matches = matches +1;
        end
    end
    
    
    accuracy = matches / N;
    
    
    

end

