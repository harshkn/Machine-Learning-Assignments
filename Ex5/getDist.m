function [ dist ] = getDist( qcolor, r, g, b )
%GETDIST Summary of this function goes here
%   Detailed explanation goes here

distR = (qcolor(:,1) - r) .^ 2;
distG = (qcolor(:,2) - g) .^ 2;
distB = (qcolor(:,3) - b) .^ 2;
dist = distR + distG + distB;


end

