Z = 6; % Number of Topics
iter = 50 ; % Number of EM iterations
qlevels =  csvread('colors.csv');
currentFolder = pwd;
folderpath = [currentFolder '/mirflickr1000/*.jpg'];
imagepath = [currentFolder '/mirflickr1000/'];
type = 'sift';



% Parameters for features extraction
params.fsize = 15;       % Harris filter size
params.sigma = 1.4;      % Harris filter sigma
params.threshold = 1e-7; % Harris threshold
params.boundary = 10;    % boundary for interest points
K = 100;                  % number of keypoints in codebook


currentFolder = pwd;
imfiles = dir([currentFolder '/mirflickr1000/*.jpg']);

% Extracting Sift features
siftVc = {};
for fno = 1:numel(imfiles)
    fprintf('\n Processing Image %d ... ', fno);
    I = imread([currentFolder '/mirflickr1000/' imfiles(fno).name]);
    temp = im2feat(double(rgb2gray(I)),params.fsize,params.sigma,...
        params.threshold,params.boundary);
    siftVc = cat(2, siftVc, temp);
    fprintf('done');
end
%
save('siftFeatures.mat', 'siftVc');
load('siftFeatures.mat');
siftV = cell2mat(siftVc);

% Codebook generation 
[~, ~, ~, codebook] = kmeans(siftV,K);
save('siftCodebook.mat', 'codebook');
load('siftCodebook.mat');
%% Histogram using codebook
histogram = compute_histogram(siftVc,codebook,K);


