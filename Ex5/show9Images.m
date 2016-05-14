function [] = show9Images(heading, folderpath, path, docidx)
imfiles = dir(folderpath);

subplot(331), imshow([path imfiles(getActualIndex(folderpath, docidx(1))).name]);
title(heading);
subplot(332), imshow([path imfiles(getActualIndex(folderpath, docidx(2))).name]);
subplot(333), imshow([path imfiles(getActualIndex(folderpath, docidx(3))).name]);
subplot(334), imshow([path imfiles(getActualIndex(folderpath, docidx(4))).name]);
subplot(335), imshow([path imfiles(getActualIndex(folderpath, docidx(5))).name]);
subplot(336), imshow([path imfiles(getActualIndex(folderpath, docidx(6))).name]);
subplot(337), imshow([path imfiles(getActualIndex(folderpath, docidx(7))).name]);
subplot(338), imshow([path imfiles(getActualIndex(folderpath, docidx(8))).name]);
subplot(339), imshow([path imfiles(getActualIndex(folderpath, docidx(9))).name]);
end