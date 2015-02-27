function [ data ] = LLFE( foldername_in, filename_out )
%LLFE This function reads iteratively all files in the set foldername_in
%and calls with each loaded image (3 channel, various dimensions) the
%densSiftExtractor-function. The results are then stored in the project's
%structure in the filename_out.

    fprintf('\ncalculating DSIFT features...\n');

    d = dir(foldername_in);
    isub = [d(:).isdir]; %# returns logical vector
    nameFolds = {d(isub).name}';

    % remove . and ..    
    nameFolds(ismember(nameFolds,{'.','..'})) = [];

    curRowIndex = 1;
    
    % for each folder
    for f = 1:length(nameFolds)
        fname = strcat(foldername_in, '/', nameFolds{f});
        files = dir(fname);
        
        curClass = str2double(nameFolds{f});
        
        for i=1:length(files)
            if strcmp(files(i).name, '..') ||  strcmp(files(i).name, '.') || strcmp(files(i).name, 'Thumbs.db')
                continue
            end
            
           disp(files(i).name); 
           
           data.targets(curRowIndex,1) = curClass;           
           img = imread(strcat(fname, '/', files(i).name));
          
           data.fv(curRowIndex,:,:) = densSiftExtractor(img); % here the DSIFT features for every images are calculated. This function makes also sure that we get the same number of feature from every image!
           
           curRowIndex = curRowIndex + 1;
                     
        end       
        
    end
    
    
    save(filename_out, 'data');
    
    
    
    fprintf('\nfinished!\n');
   

end

