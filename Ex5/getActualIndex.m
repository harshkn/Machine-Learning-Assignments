function idxr = getActualIndex(folderpath, idx)
%     n =35;
    imfiles = dir(folderpath);
    for i = 1: numel(idx)
        imname = ['im' int2str(idx(i)) '.jpg'];
        idxr(i) = find(arrayfun(@(n) strcmp(imfiles(n).name, imname), 1:numel(imfiles)));
    end
end