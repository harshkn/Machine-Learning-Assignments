function plotSortedWordsGivenTopicTask4_1(qlevels, Z, Pw_z, type)
pth = pwd;
for i = 1: Z
    qnew = qlevels;
    % Sort P(w|z) given z
    [p, idxp] = sort(Pw_z(:,i), 'descend');
    qnew = qnew(idxp,:);
    % Reshaping to rectangle matrix of arbitary dimension
    qnew = reshape(qnew, [50,20,3]);
    % Show Sorted words given topic
    figure(i)
    imagesc(qnew)
    heading=  ['Sorted P(w|z) for Topic(z) = ' int2str(i)];
    title(heading); 
    
    fn = ['task4_1_im_' type '_topic_' int2str(i) '.jpg'];
    hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');
    
    %Plot sorted word probabilities given topic
    figure(i+Z)
    plot(p/sum(p));
    xl = ' Sorted word index ';
    yl = 'P(w|z)';
    xlabel(xl);
    ylabel(yl);
    title(heading); 
    fn = ['task4_1_pl_' type '_topic_' int2str(i) '.jpg'];
    hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');
end



end