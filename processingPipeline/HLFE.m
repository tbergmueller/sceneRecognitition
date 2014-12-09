function [ data ] = HLFE( foldername_in, filename_out )
%LLFE This function reads iteratively all files in the set foldername_in
%and calls with each loaded image (3 channel, various dimensions) the
%densSiftExtractor-function. The results are then stored in the project's
%structure in the filename_out.
%   the densSiftExtractor-function has to return a FeatureVector of FIXED length!! 
%   This means, size of the loaded image has
%   to be considered inside this function.

   load(foldername_in, 'data');
   % from now on loaded to "data"
   
   save(filename_out, 'data')
    
    
    
    
   

end

