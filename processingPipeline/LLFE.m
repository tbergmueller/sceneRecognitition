function [ data ] = LLFE( foldername_in, filename_out )
%LLFE This function reads iteratively all files in the set foldername_in
%and calls with each loaded image (3 channel, various dimensions) the
%densSiftExtractor-function. The results are then stored in the project's
%structure in the filename_out.
%   the densSiftExtractor-function has to return a FeatureVector of FIXED length!! 
%   This means, size of the loaded image has
%   to be considered inside this function.

    d = dir(foldername_in);
    isub = [d(:).isdir]; %# returns logical vector
    nameFolds = {d(isub).name}';

    % remove . and ..    
    nameFolds(ismember(nameFolds,{'.','..'})) = [];

    
    
    % We know how many files there are (we just use one list)
    
    
    curRowIndex = 1;
    
    
    if(length(nameFolds) == 0)
        error(['no input files for ' foldername_in]);
    end
    
    % for each folder
    for f = 1:length(nameFolds)
       
       
        
        fname = strcat(foldername_in, '/', nameFolds{f});
        files = dir(fname);
        
        curClass = str2double(nameFolds{f});
        
        for i=1:length(files)
            
            if strcmp(files(i).name, '..') ||  strcmp(files(i).name, '.')
                continue
            end
            
           disp(files(i).name); 
           
           data.targets(curRowIndex,1) = curClass;           
           img = imread(strcat(fname, '/', files(i).name));
           
          % data.dimensions(curRowIndex,:) = size(img);
                      
         %  rowvector = img ( : );
           
            % IMPORTANT NOTE: FeatureVector always has to have the same
            % size. Else the implementation does NOT work.
            % fv is a 3D matrix since we have more (by default 108) sift features per image.
            % Therefore the third dimension corresponds to the 128
            % dimensions of the sift features.
           data.fv(curRowIndex,:,:) = densSiftExtractor(img);
           
           curRowIndex = curRowIndex + 1;
                     
        end       
        
       % disp(dir([foldername_in '/' nameFolds(f)]))
        
    end
    
    
    save(filename_out, 'data');
    
    
    
    
   

end

