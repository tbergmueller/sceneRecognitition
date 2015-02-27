function [siftFeatures] = densSiftExtractor( image )
%LLFE_IMPL 
% This function calculates DSIFT features for the given image.
% siftFeatures is a 2D matrix where the rows are the different features and
% the columns the 128 dimensional sift vector

    % dummx implementation
    % siftFeatures = zeros(1,300);
    
    % image normalization (resizing to 300x400 or 400x300 depending on
    % image orientation)
    % this ensures that we get always the same number of SIFT features for every image
    
    if size(image,1) > size(image,2)
        im_res = imresize(image,[400 300]);
    else
        im_res = imresize(image,[300 400]);
    end
    
    % calculate DSIFT features:
    %[sift, gridX, gridY] = sp_dense_sift(im_res,32,32); % 108 features per image
    [sift, gridX, gridY] = sp_dense_sift(im_res,24,24); % 192 -||-
    %[sift, gridX, gridY] = sp_dense_sift(im_res,20,20); % 300 -||-
    siftFeatures = double(reshape(sift, [size(sift,1)*size(sift,2) size(sift,3)])); % bring sift features in 2D matrix
    
end

