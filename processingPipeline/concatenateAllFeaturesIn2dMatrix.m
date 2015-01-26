function [ data2d ] = concatenateAllFeaturesIn2dMatrix( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

rows = size(data,1);
cols = size(data,2);

data2d = zeros(rows*cols,128);

for row=1:rows
    for col=1:cols
        index = (row-1)*cols + col;
        data2d(index,:) = data(row,col,:);
    end
end


end

