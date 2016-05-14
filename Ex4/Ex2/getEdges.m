function [ Edges ] = getEdges( img )
%GETEDGES Summary of this function goes here
%   Detailed explanation goes here
[height,width] = size(img);
imgsz = height*width;

    
V = repmat([ones(height-1,1); 0],width, 1);
V = V(1:end-1); %remove last zero

U = ones(height*(width-1), 1);
% get sparse matrix
smat = sparse(1:(imgsz-1),    2:imgsz, V, imgsz, imgsz)+ sparse(1:(imgsz-height),(height+1):imgsz, U, imgsz, imgsz);
smat = smat + smat'; %symetric sparse matrix
[i,j] = find(smat);
Edges = [j,i];


end

