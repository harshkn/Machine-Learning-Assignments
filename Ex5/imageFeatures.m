function [ v ] = imageFeatures( im, qlevels)
%IMAGEFEATURES Summary of this function goes here
%   Detailed explanation goes here



v = zeros(1000,1);
npix = numel(im(:,:,1));
sz = [npix, 1];

img = double(im)./255 ;
rarray = reshape(img(:,:,1), sz);
garray = reshape(img(:,:,2), sz);
barray = reshape(img(:,:,3), sz);



for i= 1: numel(img(:,:,1))
    dist  = getDist( qlevels, rarray(i), garray(i), barray(i));
    [~, midx] = min(dist);
    v(midx) = v(midx) + 1;  
end
v = v/numel(img(:,:,1));
    
end

 