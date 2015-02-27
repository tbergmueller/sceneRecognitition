function [ y ] = buildHistogram(x,k)
% computes the word frequencies 

y=zeros(k,1);

for i=1:k
    y(i) = sum(x(:,1)==i)/size(x,2);
end

end

