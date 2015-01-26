function [  ] = HLFE( filename_in_train, filename_out_train, filename_in_test, filename_out_test)
%LLFE This function reads iteratively all files in the set filename_in
%and calls with each loaded image (3 channel, various dimensions) the
%densSiftExtractor-function. The results are then stored in the project's
%structure in the filename_out.
%   the densSiftExtractor-function has to return a FeatureVector of FIXED length!! 
%   This means, size of the loaded image has
%   to be considered inside this function.

% k for kmeans
k=300;


   load(filename_in_train, 'data');
   % from now on loaded to "data"
   data_train = data;
   data_train_hl.fv = zeros(size(data_train.fv,1),k);
   data_train_hl.targets = data_train.targets;
   
   load(filename_in_test, 'data');
   data_test = data;
   data_test_hl.fv = zeros(size(data_test.fv,1),k);
   data_test_hl.targets = data_test.targets;
   
   % do k-means (create dictionary)
   fprintf('\nstarting K-MEANS clustering with k=%i...\n',k);
   data2d_train = concatenateAllFeaturesIn2dMatrix(data_train.fv);
   [~, cluster_centers] = kmeans(data2d_train,k);
   fprintf('\nfinished!...\n');
   
   % create histograms for training images
   fprintf('\nBuilding histograms for training images...\n');
    for r=1:size(data_train.fv,1)
        fprintf('\n%i\n',r);
        for c=1:size(data_train.fv,2)
            distance = zeros(size(cluster_centers,1),1);
            for w=1:size(cluster_centers,1)
                  sift = squeeze(data_train.fv(r,c,:))';
                  %cluster_centers(w,:);
                  distance(w,1) = sqrt(sum((sift - cluster_centers(w,:)) .^ 2));
            end
             [~,index] = min(distance);
             % save feature labels
             data_train_hl.fv(r,index) = data_train_hl.fv(r,index) + 1;
             
        end
    end
    fprintf('\nfinished!...\n');
   
% create histograms for testing images
   fprintf('\nBuilding histograms for testing images...\n');
    for r=1:size(data_test.fv,1)
        fprintf('\n%i\n',r);
        for c=1:size(data_test.fv,2)
            distance = zeros(size(cluster_centers,1),1);
            for w=1:size(cluster_centers,1)
                  sift = squeeze(data_test.fv(r,c,:))';
                  cluster_centers(w,:);
                  distance(w,1) = sqrt(sum((sift - cluster_centers(w,:)) .^ 2));
            end
             [~,index] = min(distance);
             % save feature labels
             data_test_hl.fv(r,index) = data_test_hl.fv(r,index) + 1;
             
        end
    end
    fprintf('\nfinished!...\n');
   
   
   % data should return the histograms
   
   data_train_hl.fv = data_train_hl.fv./size(data_train.fv,2);
   data_test_hl.fv = data_test_hl.fv./size(data_test.fv,2);
   save(filename_out_train, 'data_train_hl')
   save(filename_out_test, 'data_test_hl')
    
    
    
    
   

end

