function Pz_d = showImagesForHighestPZDTask4_2(folderpath, imagepath, Pd_z, Pz, Z,V, type)

Pd=0;
pth = pwd;

% Compute Pd
for i = 1:Z 
   Pd = Pd + sum(Pd_z(:,i) .* Pz(i) );
end
% Compute P(z|d)
for i = 1:Z
    Pz_d(i,:) = (Pd_z(:,i) .* Pz(i)) ./ Pd;
end

% Showing 9 Images with high P(z|d) for given z
for i = 1:Z
    [~, docidx] = sort(Pz_d(i,:), 'descend');
    figure(i + (2* Z))
    heading=  ['Showing images with highest P(z|d) for z= ' int2str(i)];
    show9Images(heading, folderpath,imagepath, docidx(1:9));
    fn = ['task4_2_im_' type '_topic_' int2str(i) '.jpg'];
    hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');
    
    figure(i + (3* Z))
    show9HistPlots(V, docidx,folderpath);
    fn = ['task4_2_pl_' type '_topic_' int2str(i) '.jpg'];
    hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');
    
end



