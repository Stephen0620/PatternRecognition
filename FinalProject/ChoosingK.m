clear,clc;
load('fea1.mat');
close all;
idx2 = kmeans(fea1,2,'replicates',5);
idx3 = kmeans(fea1,3,'replicates',5);
idx4 = kmeans(fea1,4,'replicates',5);


figure()
[silh2,h2] = silhouette(fea1,idx2);
figure()
[silh3,h3] = silhouette(fea1,idx3);
figure()
[silh4,h4] = silhouette(fea1,idx4);
figure()
[silh5,h5] = silhouette(fea1,idx5);

mean(silh2)
mean(silh3)
mean(silh4)
mean(silh5)

C1 = fea1(find(idx3==1),:,:);
C2 = fea1(find(idx3==2),:,:);
C3 = fea1(find(idx3==3),:,:);

figure()
hold on
scatter3(C1(:,1),C1(:,2),C1(:,3),'r');
scatter3(C2(:,1),C2(:,2),C2(:,3),'g');
scatter3(C3(:,1),C3(:,2),C3(:,3),'b');