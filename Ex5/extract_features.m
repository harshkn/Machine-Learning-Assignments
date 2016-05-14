function features = extract_features(images,params)
%% Extract features for a set of images (calls im2feat)..
%
% INPUTS
%   images            (1 x num_samples) cell array with images,
%
%   params             structure with following fields:
%     fsize              Harris filter size
%     sigma              Harris/SIFT filter sigma
%     threshold          Harris threshold
%     boundary           boundary for interest points
%
%
% OUTPUTS
%   features          (1 x num_samples) cell array. The j-th entry in 'features'
%                     is a 128xN SIFT feature matrix, where N is the number of detected
%                     interest points for the j-th image in 'images'.
%%
features = cell(1, numel(images));

for i=1: numel(images)
    features{i} = im2feat(images{i},params.fsize,params.sigma,params.threshold,params.boundary);
end




% format check
assert(iscell(features) & all(size(features)==size(images)));

