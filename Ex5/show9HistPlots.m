function [] = show9HistPlots(V, docidx, folderpath)

subplot(331), stem(V(:,getActualIndex(folderpath, docidx(1))));
heading=  ['Hist of d= ' int2str(docidx(1))];
title(heading);
subplot(332), stem(V(:,getActualIndex(folderpath, docidx(2))));
heading=  ['Hist of d= ' int2str(docidx(2))];
title(heading);
subplot(333), stem(V(:,getActualIndex(folderpath, docidx(3))));
heading=  ['Hist of d= ' int2str(docidx(3))];
title(heading);
subplot(334), stem(V(:,getActualIndex(folderpath, docidx(4))));
heading=  ['Hist of d= ' int2str(docidx(4))];
title(heading);
subplot(335), stem(V(:,getActualIndex(folderpath, docidx(5))));
heading=  ['Hist of d= ' int2str(docidx(5))];
title(heading);
subplot(336), stem(V(:,getActualIndex(folderpath, docidx(6))));
heading=  ['Hist of d= ' int2str(docidx(6))];
title(heading);
subplot(337), stem(V(:,getActualIndex(folderpath, docidx(7))));
heading=  ['Hist of d= ' int2str(docidx(7))];
title(heading);
subplot(338), stem(V(:,getActualIndex(folderpath, docidx(8))));
heading=  ['Hist of d= ' int2str(docidx(8))];
title(heading);
subplot(339), stem(V(:,getActualIndex(folderpath, docidx(9))));
heading=  ['Hist of d= ' int2str(docidx(9))];
title(heading);
end