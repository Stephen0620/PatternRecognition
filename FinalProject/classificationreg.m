
%clear all; close all;
figure
gscatter(Meas(:,1), Meas(:,2), irrigation,'rgb','osd');
% xlabel('Micronaire');
% ylabel('Length');
% figure(2)
% gscatter(Meas(:,3), Meas(:,4), irrigation,'rgb','osd');
% xlabel('Length');
% ylabel('Strength');
% figure(3)
% gscatter(Meas(:,4), Meas(:,5), irrigation,'rgb','osd');
% xlabel('Strength');
% ylabel('Elongation');
% figure(4)
% gscatter(Meas(:,2), Meas(:,4), irrigation,'rgb','osd');
% xlabel('Micronaire');
% ylabel('Strength');
% figure(5)
% gscatter(Meas(:,2), Meas(:,4), irrigation,'rgb','osd');
% xlabel('Micronaire');
% ylabel('Strength');
% figure(6)
% gscatter(Meas(:,2), Meas(:,5), irrigation,'rgb','osd');
% xlabel('Micronaire');
% ylabel('Elongation');
% figure(7)
% gscatter(Meas(:,2), Meas(:,3), irrigation,'rgb','osd');
% xlabel('Micronaire');
% ylabel('Length');
% 
% N = size(Meas,1);
figure
param_names = {'Yield', 'Micronaire', 'Length','Strength', 'Elongation'};
gplotmatrix(Meas);
text([.05 .25 .45 .70 0.90], [-0.1, -0.1, -0.1, -0.1, -0.1], param_names, 'FontSize',9);
text([-0.12, -0.12, -0.12, -0.12, -0.12], [0.90  0.70 0.45 0.25 0.05], param_names, 'FontSize',9, 'Rotation',90)
figure
andrewsplot(Meas,'group',irrigation)
figure
andrewsplot(Meas,'group',irrigation,'quantile',.25)
% figure(11),normplot(Meas);
% legend('Yield','Micronaire','Length','Strength','Elongation')
means1= grpstats(Meas,irrigation);
% % [grpMin,grpMed,grpMax,grp] = grpstats(Meas,irrigation,...
% %                                {'min','median','max','gname'});
% %                            grpstats(Meas(:,1),irrigation,0.05);
% % [xbar,s2,grp] = grpstats(Meas(:,1),irrigation,{'mean','var','gname'});
% 3D Visualization
figure
plot3(Meas(:, 3),Meas(:, 2),Meas(:, 1), 'o');
% xlabel('Strength'); ylabel('Strength'); zlabel(' Micronaire');
view(-137,10);
grid on
% %K-means
% 
% Compute the ends of the 95% confidence intervals for yield
yield = reshape(Meas(:, 1), 42, 3);  % Make yield 42 x 3
numberSamples = size(yield, 1); % number of rows
yieldMeans = mean(yield);
yieldSEMs = std(yield)./ sqrt(numberSamples);
yield95CIEnds = yieldSEMs.* 1.96;
%   Output the 95% confidence interval of the mean estimate for High
%   Irrigation

fprintf('Estimate of mean yield for high irrigation is: %g\n',  ...
   yieldMeans(1))
fprintf('95%% confidence interval for this mean is: [%g, %g]\n', ...
  yieldMeans(1) - yield95CIEnds(1), yieldMeans(1) + yield95CIEnds(1));
% Plot mean yield using 95% confidence interval error bars

irriGroups = {'High', 'Medium', 'Low'}; % Use for legend
title1 = 'Comparison of three irrigations';         % Use for title
figure('Name', [title1 ' (95% CI error bars)']);   % Label the top
errorbar(yieldMeans, yield95CIEnds, 'ks'); % Error bars use black squares
set(gca, 'XTick',1:3, 'XTickLabel', irriGroups) % Set ticks and tick labels
xlabel('Irrigations');
ylabel('Yield in pounds per acre')
title(title1)
legend('Mean (95% CI error bars)', 'Location', 'Northeast') % Put in lower right
% Compute the ends of the 95% confidence intervals for micronaire
micronaire = reshape(Meas(:, 2), 42, 3);  % Make yield 42 x 3
numberSamples = size(micronaire, 1); % number of rows
micMeans = mean(micronaire);
micSEMs = std(micronaire)./ sqrt(numberSamples);
mic95CIEnds = micSEMs.* 1.96;
%   Output the 95% confidence interval of the mean estimate for High
%   Irrigation

fprintf('Estimate of mean micronaire for high irrigation is: %g\n',  ...
   micMeans(1))
fprintf('95%% confidence interval for this mean is: [%g, %g]\n', ...
  micMeans(1) - mic95CIEnds(1), micMeans(1) + mic95CIEnds(1));
% Plot mean yield using 95% confidence interval error bars

irriGroups = {'High', 'Medium', 'Low'}; % Use for legend
title1 = 'Comparison of three irrigations';         % Use for title
figure('Name', [title1 ' (95% CI error bars)']);   % Label the top
errorbar(micMeans, mic95CIEnds, 'ks'); % Error bars use black squares
set(gca, 'XTick',1:3, 'XTickLabel', irriGroups) % Set ticks and tick labels
xlabel('Irrigations');
ylabel('Micronaire')
title(title1)
legend('Mean (95% CI error bars)', 'Location', 'Northeast') % Put in lower right
%  obj = fitcdiscr(Meas,irrigation,...
%     'DiscrimType','quadratic');
% mahadist = mahal(obj,mean(Meas))
[cidx2,cmeans2] = kmeans(Meas,2);
% Displaying the algorithm iterations
[cidx2,cmeans2] = kmeans(Meas,2,'display','iter');
% Clustering Visualization
figure
ptsymb = {'bs','r^','md','go','c+'};
%Plot cluster points
for i = 1:2
clust = (cidx2 == i);
plot3(Meas(clust,3),Meas(clust,2),Meas(clust,1),ptsymb{i});
hold on
end
%Plot cluster centroid
plot3(cmeans2(:,3),cmeans2(:,2),cmeans2(:,1),'ko');
hold off
xlabel('Length'); ylabel('Micronaire'); zlabel(' Yield');
view(-137,10);
grid on
title('Regression data clustered with K-means where K=2')
%Increasing the number of clusters
[cidx3,cmeans3] = kmeans(Meas,3,'display','iter');
%Clustering visualization
figure
for i = 1:3
clust = find(cidx3 == i);
plot3(Meas(clust,3),Meas(clust,2),Meas(clust,1),ptsymb{i});
hold on
end
view(-137,10);
grid on
% org_idx(strcmp(irrigation, 'High')) = 1;
% org_idx(strcmp(irrigation, 'Medium')) = 2;
% org_idx(strcmp(irrigation, 'Low')) = 3;
% miss = find(cidx3 ~= org_idx');
% plot3(Meas(miss,3),Meas(miss,2),Meas(miss,1),'k*');
% legend({'High','Medium','Low'});
% hold off

[cidx4,cmeans4] = kmeans(Meas,4,'display','iter');
%Clustering visualization
figure
for i = 1:4
clust = find(cidx4 == i);
plot3(Meas(clust,3),Meas(clust,2),Meas(clust,1),ptsymb{i});
hold on
end
view(-137,10);
grid on
% %Avoiding local minima using a replicates strategy
%  [cidx3,cmeans3,sumd3] = kmeans(Meas,3,'replicates',5,'display','final');
% %  InsertPlot
%  %Cosine function as distance measure between samples
%  [cidx_cos,cmeans_cos] = kmeans(Meas,3,'dist','cos');
%  %InsertPlot
%  %Testing the clustering accuracy
% figure
% for i = 1:3
% clust = find(cidx_cos == i);
% plot3(Meas(clust,5),Meas(clust,2),Meas(clust,1),ptsymb{i});
% hold on
% end
% % xlabel('Micronaire'); ylabel('Length'); zlabel(' Strength');
% view(-137,10);
% grid on
% org_idx(strcmp(irrigation, 'High')) = 1;
% org_idx(strcmp(irrigation, 'Medium')) = 2;
% org_idx(strcmp(irrigation, 'Low')) = 3;
% miss = find(cidx_cos ~= org_idx');
% plot3(Meas(miss,5),Meas(miss,2),Meas(miss,1),'k*');
% legend({'High','Medium','Low'});
% hold off
% 
% 
% 
% 
