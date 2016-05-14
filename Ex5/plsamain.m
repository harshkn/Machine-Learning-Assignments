
clear all;
%% Assignment 5 - Image Retrieval 
Z = 6; % Number of Topics
iter = 100 ; % Number of EM iterations
qlevels =  csvread('colors.csv');
currentFolder = pwd;
folderpath = [currentFolder '/mirflickr1000/*.jpg'];
imagepath = [currentFolder '/mirflickr1000/'];
type = 'hist';

%% Task 2 - Image Features
V = allImageFeatures(qlevels);
V = cell2mat(V);
% Loading already obtained matrix
load('V.mat');


%% Task 3 - PLSA 


[Pd_z ,Pw_z, Pz, Lt] = plsaFit3(V,Z,iter);
% save('Task_3_Data.mat', 'Pd_z','Pw_z', 'Lt', 'Pz' );
figure(200)
plot(Lt);
fn = ['task3_3_pl_' type  '.jpg'];
hgexport(gcf, fn, hgexport('factorystyle'), 'Format', 'jpeg');

%% Task 4 - Analyse the Learned Topic Model
plotSortedWordsGivenTopicTask4_1(qlevels, Z, Pw_z, type); %4.1
Pz_d = showImagesForHighestPZDTask4_2(folderpath, imagepath, Pd_z, Pz, Z,V, type); %4.2


%% Task 5 - Image Retrieval
k = 9;
queryimageindex = 44;
imq =  getActualIndex(folderpath, queryimageindex);
ids = query(Pz_d(:,imq), Pz_d, k); %5.1,2
show9ImagesTopicHistT5(folderpath,imagepath,  Pz_d, ids, type, queryimageindex); %5.3

queryimageindex = 59;
imq =  getActualIndex(folderpath, queryimageindex);
ids = query(Pz_d(:,imq), Pz_d, k); %5.1,2
show9ImagesTopicHistT5(folderpath,imagepath,  Pz_d, ids, type, queryimageindex); %5.3

queryimageindex = 109;
imq =  getActualIndex(folderpath, queryimageindex);
ids = query(Pz_d(:,imq), Pz_d, k); %5.1,2
show9ImagesTopicHistT5(folderpath,imagepath,  Pz_d, ids, type, queryimageindex); %5.3

% pause(5);
% close all









