function V = allImageFeatures(qlevels)
currentFolder = pwd;
imfiles = dir([currentFolder '/mirflickr1000/*.jpg']);

V = {};
for fno = 1:numel(imfiles)
    fprintf('\n Processing Image %d ... ', fno);
    I = imread([currentFolder '/mirflickr1000/' imfiles(fno).name]);
    temp = imageFeatures(I, qlevels);
    V = cat(2, V, temp);
    fprintf('done');
end