function histogram = compute_histogram(features,codebook,K)
%% Computes the histogram over the codebook for all input images
%
% INPUTS:
%   features     (1 x num_samples) cell array of features.
%   codebook     128xK matrix where each column corresponds to a keypoint in the codebook.
%   K            number of keypoints in the codebook.
%
% OUTPUTS:
%   histogram    K x num_samples matrix, that assembles the histograms for all images (over the codebook).
%%

histogram = zeros(K, numel(features));
for images = 1: numel(features)
    feat = features{images};
    dist = zeros(128, size(codebook, 2));
    for featidx = 1: size(feat, 2)
        for codebookidx = 1:size(codebook,2)
            dist(:, codebookidx) = (codebook(:,codebookidx) - feat(:,featidx)).^2 ;
        end
        sumdist = sum(dist, 1);
        [~ , idx] = sort(sumdist);
        histogram(idx(2), images) = histogram(idx(2), images) + 1;
    end
end


% format check
assert(all(size(histogram) == [K size(features,2)]));
