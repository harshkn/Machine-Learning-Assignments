function F = sift(im,x,y)
%%
% Simple SIFT descriptor using 16x16 blocks, 4x4 cells and 8 bins
% Gradients are "signed".
%
% INPUTS:
%   im          image (rgb or grayscale)
%   x           vector of x-coordinates of keypoints
%   y           vector of y-coordinates of keypoints
%
% OUTPUTS:
%   F           128xM SIFT feature matrix,
%               where M is the number of keypoints.
%
% Author: Jochen Gast
%         Visual Inference Group, TU Darmstadt
%         January, 2015
%%

% make sure pixels are intensities
if size(im,3) == 3, im = rgb2gray(im); end;

% discard boundaries
[x,y] = discardboundaries(x,y,size(im),8);

% required filters
fsigma = 1.4; fsize  = 25;
ksmooth = fspecial('gaussian',fsize,fsigma);
kderive = [-.5 0 .5];

% derivatives
ims = imfilter(im,ksmooth);
dx  = imfilter(ims,kderive);
dy  = imfilter(ims,kderive');

% sliding window indices
tiles = im2colidx_16x16(x,y,size(im));

% derivative and gradient magnitude tiles
xtiles = dx(tiles);
ytiles = dy(tiles);
gtiles = hypot(xtiles,ytiles);


% Weight the magnitudes by a Gaussian window
fsize = 16; fsigma = 8;
wfilt = fspecial('gaussian',fsize,fsigma);
magn = bsxfun(@times,gtiles,wfilt(:));

% normalized angles in [0,1]
theta = (pi + atan2(ytiles,xtiles))/(2*pi); % signed

% 16 histogram bins in [0,15]
h = 1/(16-1);
theta = round(theta/h);

% 8 histogram bins in [1,8] s.t. 0/15 correspond to bin 1, respectively
theta = int32( mod(round(theta/2),8) + 1 );

% distinct cells within a block (as linear indices)
cells = im2col(reshape(int32(1:16^2),[16 16]),[4 4],'distinct');

% reshape such that each cell corresponds to a column
magn_cells = reshape(magn(cells(:),:),16,16*length(x));
theta_cells = reshape(theta(cells(:),:),16,16*length(x));

% apply index offset
offset = int32(8*(0:16*length(x)-1));
theta_cells = bsxfun(@plus,theta_cells,offset);

% accumulate bins to sift features (column-wise)
F = reshape( accumarray(theta_cells(:),magn_cells(:),[128*length(x) 1]), ...
         [128 length(x)] );

% normalize to unit vectors in order to enhance invariance to affine changes
% in illumination
F = bsxfun(@rdivide,F,sqrt(sum(F.^2)));


function [x,y] = discardboundaries(x,y,imsize,bndry)
    keep = (y > bndry) & (y <= imsize(1) - bndry) & ...
           (x > bndry) & (x <= imsize(2) - bndry);
    x = x(keep); y = y(keep);


function tiles = im2colidx_16x16(x,y,imsize)
    % dimensions
    M = imsize(1); N = imsize(2);

    % indices as obtained by im2col
    tiles = im2col(reshape(int32(1:M*N),[M N]),[16 16]);

    % centers corresponding to im2col
    c = sub2ind([16 16],8,8);
    centers = tiles(c,:);

    % only keep the windows specified by (x,y)
    [~,ia] = intersect(centers(:),sub2ind(imsize,y(:),x(:)));
    tiles = tiles(:,ia);
