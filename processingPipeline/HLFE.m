function [  ] = HLFE( filename_in_train, filename_out_train, filename_in_test, filename_out_test, k, NrOfFeaturesForClustering)
%LLFE This function reads iteratively all files in the set filename_in
%and calls with each loaded image (3 channel, various dimensions) the
%densSiftExtractor-function. The results are then stored in the project's
%structure in the filename_out.

   % load low level (SIFT) features of training images
   load(filename_in_train, 'data');
   data_train = data;
   data_train_hl.fv = zeros(size(data_train.fv,1),k);
   data_train_hl.targets = data_train.targets;
   
   % load low level (SIFT) features of test images
   load(filename_in_test, 'data');
   data_test = data;
   data_test_hl.fv = zeros(size(data_test.fv,1),k);
   data_test_hl.targets = data_test.targets;
   
   % do k-means (create dictionary)
   fprintf('\nstarting K-MEANS clustering with k=%i... (hard assignment!)\n',k);
   data2d_train = concatenateAllFeaturesIn2dMatrix(data_train.fv); % map 3d matrix to 2d matrix for kmeans function
   data2d_train_rp = data2d_train(randperm(size(data2d_train,1)),:); % takes "NrOfFeaturesForClustering" random features for clustering
   [~, cluster_centers] = kmeans(data2d_train_rp(1:NrOfFeaturesForClustering,:),k); % actual k-means clustering
   fprintf('\nfinished!...\n');
   
   % create histograms for training images
   fprintf('\nBuilding histograms for training images...\n');
   for r=1:size(data_train.fv,1) % for every image....
        fprintf('\n%i from %i\n',r,size(data_train.fv,1));
        sift = squeeze(data_train.fv(r,:,:)); % ...take sift features
        distance = eucliddist(sift, cluster_centers); % ...calculate distances to the visual words
        [~,index] = min(distance,[],2); %... determine minima (closest word for every sift feature)
        data_train_hl.fv(r,:) = buildHistogram(index,k)'; % create actual histogram (compute word frequencies)     
   end
   fprintf('\nfinished!...\n');
   
% create histograms for testing images
   fprintf('\nBuilding histograms for testing images...\n');
   for r=1:size(data_test.fv,1) % for every image....
        fprintf('\n%i from %i\n',r,size(data_test.fv,1));
        sift = squeeze(data_test.fv(r,:,:)); % ...take sift features
        distance = eucliddist(sift, cluster_centers); % ...calculate distances to the visual words
        [~,index] = min(distance,[],2); %... determine minima (closest word for every sift feature)
        data_test_hl.fv(r,:) = buildHistogram(index,k)'; % create actual histogram (compute word frequencies) 
   end
   fprintf('\nfinished!...\n');
   
   save(filename_out_train, 'data_train_hl')
   save(filename_out_test, 'data_test_hl')
    
    
end

