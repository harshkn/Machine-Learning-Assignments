function [ sumres ] = findpairwise( img , Edges)
%FINDSMOOTHINGPRIOR Summary of this function goes here
%   Detailed explanation goes here
res = img(Edges(:,1)) .* img(Edges(:,2));
sumres = sum(res);
end

