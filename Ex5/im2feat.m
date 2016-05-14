function F = im2feat(im,fsize,sigma,threshold,boundary)
%% Extract features for a single image
%
% INPUTS
%   im                 given image
%   fsize              Harris filter size
%   sigma              Harris filter sigma
%   threshold          Harris threshold
%   boundary           boundary for interest points
%
% OUTPUTS
%   F                  128xN SIFT features, where N is the number of interest points.
%%


bn = boundary;
[mask, ~] = harris(im, sigma, fsize, threshold);
mask(1:bn, :) = 0;
mask(end-bn+1:end, :) = 0;
mask(:, 1:bn) = 0;
mask(:, end-bn+1:end) = 0;
[y,x] = find(mask);
F = sift(im,x,y);


% format check
assert(size(F,1) == 128);
