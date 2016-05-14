function [] = show9ImagesTopicHistT5(folderpath, path,  Pz_d, docidx, type, qim)
imfiles = dir(folderpath);
k = numel(docidx);
imq =  getActualIndex(folderpath, qim);
%Show Query Image
figure
heading=  ['Query Image d = ' int2str(qim)];
subplot(121), imshow([path imfiles(imq).name]);
title(heading);
subplot(122), stem(Pz_d(:,imq));
fn = ['task5_3_queryim_' int2str(qim) '_' type '.jpg'];
hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');


%show Results 
for i = 1:k
    figure
    heading=  ['Result Image d = ' int2str(docidx(i)) ' for Query Image' int2str(qim)];
    subplot(121), imshow([path imfiles(getActualIndex(folderpath, docidx(i))).name]);
    title(heading);
    data = Pz_d(:,getActualIndex(folderpath, docidx(i)));
    subplot(122), stem(data/sum(data));
    
    fn = ['task5_3_res_' int2str(qim) '_' type '_' int2str(i) '.jpg'];
    hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');
end