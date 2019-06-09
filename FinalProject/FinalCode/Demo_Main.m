clear,clc;
close all;
Data(1:42,1) = 1;
Data(43:84,1) = 2;
Data(85:126,1) = 3;
Meas = load('Meas.mat');
Data(:,2:6) = Meas.Meas;
irrigation = load('irrigation.mat');
%% Read feature for Yield, Mic and Strength
X = [Data(:,4) Data(:,3) Data(:,2)];
Class1 = X(find(Data(:,1)==1),:);
Class2 = X(find(Data(:,1)==2),:);
Class3 = X(find(Data(:,1)==3),:);

%Plot the original Data
figure(1);
hold on;
scatter3(Class1(:,1),Class1(:,2),Class1(:,3),'r');
scatter3(Class2(:,1),Class2(:,2),Class2(:,3),'g');
scatter3(Class3(:,1),Class3(:,2),Class3(:,3),'b');
title('Original Data');
legend('class1','class2','class3');
xlabel('Length'); ylabel('Micronaire'); zlabel('Yield');

%% Plot the gplot
figure(1);
param_names = {'Yield', 'Micronaire', 'Length','Strength', 'Elongation'};
gplotmatrix(Data(:,2:6),[],Data(:,1),['b' 'g' 'r'],[],[],'off');
text([.05 .25 .45 .70 0.90], [-0.1, -0.1, -0.1, -0.1, -0.1], param_names,...
    'FontSize',9);
text([-0.12, -0.12, -0.12, -0.12, -0.12], [0.90  0.70 0.45 0.25 0.05],...
    param_names, 'FontSize',9, 'Rotation',90);

%% Andrews Plot
figure(2);
andrewsplot(Meas.Meas,'group',irrigation.irrigation);
%% Confidence Interval
irriGroups = {'High', 'Medium', 'Low'}; 
yield = reshape(Meas.Meas(:, 1), 42, 3);  % Make yield 42 x 3
numberSamples = size(yield, 1); % number of rows
yieldMeans = mean(yield);
yieldSEMs = std(yield)./ sqrt(numberSamples);
yield95CIEnds = yieldSEMs.* 1.96;
fprintf('Estimate of mean yield for high irrigation is: %g\n',  ...
   yieldMeans(1));
fprintf('95%% confidence interval for this mean is: [%g, %g]\n', ...
  yieldMeans(1) - yield95CIEnds(1), yieldMeans(1) + yield95CIEnds(1));

figure(3);
errorbar(yieldMeans, yield95CIEnds, 'ks'); % Error bars use black squares
set(gca, 'XTick',1:3, 'XTickLabel', irriGroups); % Set ticks and tick labels
xlabel('Irrigations');
ylabel('Yield in pounds per acre');
title1 = 'Comparison of three irrigations';
title(title1);
legend('Mean (95% CI error bars)', 'Location', 'Northeast');

micronaire = reshape(Meas.Meas(:, 2), 42, 3);  % Make yield 42 x 3
numberSamples = size(micronaire, 1); % number of rows
micMeans = mean(micronaire);
micSEMs = std(micronaire)./ sqrt(numberSamples);
mic95CIEnds = micSEMs.* 1.96;
fprintf('Estimate of mean micronaire for high irrigation is: %g\n',  ...
   micMeans(1))
fprintf('95%% confidence interval for this mean is: [%g, %g]\n', ...
  micMeans(1) - mic95CIEnds(1), micMeans(1) + mic95CIEnds(1));

figure(4);   % Label the top
errorbar(micMeans, mic95CIEnds, 'ks'); % Error bars use black squares
set(gca, 'XTick',1:3, 'XTickLabel', irriGroups) % Set ticks and tick labels
xlabel('Irrigations');
ylabel('Micronaire');
title1 = 'Comparison of three irrigations';
title(title1)
legend('Mean (95% CI error bars)', 'Location', 'Northeast') % Put in lower right

%% 2D animation Demo
%Using Yield and Mic
X_2D = [Data(:,3) Data(:,2)];
Class1_2D = X_2D(find(Data(:,1)==1),:);
Class2_2D = X_2D(find(Data(:,1)==2),:);
Class3_2D = X_2D(find(Data(:,1)==3),:);

%Initial Guess
k = 3;
Random=randperm(size(X_2D,1));
Centroid_2D = X_2D(Random(1:k),:);

%plot 2D image
figure(5);
hold on;
scatter(Class1_2D(:,1),Class1_2D(:,2),'r');
scatter(Class2_2D(:,1),Class2_2D(:,2),'g');
scatter(Class3_2D(:,1),Class3_2D(:,2),'b');
plot(Centroid_2D(1,1),Centroid_2D(1,2),'kx','markers',24,'LineWidth',2);
plot(Centroid_2D(2,1),Centroid_2D(2,2),'kx','markers',24,'LineWidth',2);
plot(Centroid_2D(3,1),Centroid_2D(3,2),'kx','markers',24,'LineWidth',2);
title('Original Data in 2 dimension with initial guess');
legend('class1','class2','class3','Centroids');
xlabel('Micronaire'); ylabel('Yield');

%The first iteration
min = 100000000;
for i=1:size(X_2D,1)
    min=100000000;
    for j=1:k
        D=[X_2D(i,1),X_2D(i,2);Centroid_2D(j,1),Centroid_2D(j,2)];
        distance=pdist(D);
        if(distance<min)
            min=distance;
            min_index=j;
        end
    end
    X_2D(i,3) = min_index;
end
Class1_2D=X_2D(find(X_2D(:,3)==1),:);
Class2_2D=X_2D(find(X_2D(:,3)==2),:);
Class3_2D=X_2D(find(X_2D(:,3)==3),:);
figure(6);
hold on;
scatter(Class1_2D(:,1),Class1_2D(:,2),'r');
scatter(Class2_2D(:,1),Class2_2D(:,2),'g');
scatter(Class3_2D(:,1),Class3_2D(:,2),'b');
plot(Centroid_2D(1,1),Centroid_2D(1,2),'kx','markers',24,'LineWidth',2);
plot(Centroid_2D(2,1),Centroid_2D(2,2),'kx','markers',24,'LineWidth',2);
plot(Centroid_2D(3,1),Centroid_2D(3,2),'kx','markers',24,'LineWidth',2);
title(['Demo 2-Dimension - Class 1 = ',num2str(size(Class1_2D,1)),...
    ', Class 2 = ',num2str(size(Class2_2D,1)),', Class 3 = '...
    ,num2str(size(Class3_2D,1))]);
legend('class1','class2','class3');
xlabel('Micronaire'); ylabel('Yield');

%Perform k means
time=0;
isChanged=true;
while(isChanged)
    time = time+1;
    isChanged=false;
    Class1_2D=X_2D(find(X_2D(:,3)==1),1:2);
    Class2_2D=X_2D(find(X_2D(:,3)==2),1:2);
    Class3_2D=X_2D(find(X_2D(:,3)==3),1:2);
    Centroid_2D(1,:)=mean(Class1_2D);
    Centroid_2D(2,:)=mean(Class2_2D);
    Centroid_2D(3,:)=mean(Class3_2D);
    close figure 6;
    figure(6);
    hold on;
    scatter(Class1_2D(:,1),Class1_2D(:,2),'r');
    scatter(Class2_2D(:,1),Class2_2D(:,2),'g');
    scatter(Class3_2D(:,1),Class3_2D(:,2),'b');
    plot(Centroid_2D(1,1),Centroid_2D(1,2),'kx','markers',24,'LineWidth',2);
    plot(Centroid_2D(2,1),Centroid_2D(2,2),'kx','markers',24,'LineWidth',2);
    plot(Centroid_2D(3,1),Centroid_2D(3,2),'kx','markers',24,'LineWidth',2);
    title(['Demo 2 Dimension - Class 1 = ',num2str(size(Class1_2D,1)),', Class 2 = ',num2str(size(Class2_2D,1)),', Class 3 = ',num2str(size(Class3_2D,1))]);
    legend('class1','class2','class3','Centroids');
    xlabel('Micronaire'); ylabel('Yield');
    for i=1:size(X_2D,1)
        min=100000000;
        for j=1:k
            D=[X_2D(i,1),X_2D(i,2);Centroid_2D(j,1),Centroid_2D(j,2)];
            distance=pdist(D);
            if(distance<min)
                min=distance;
                min_index=j;
            end
        end
        if(X_2D(i,3)~=min_index)
            isChanged=true;
            X_2D(i,3) = min_index;
        end
    end
end  %Put a break point here and show the demo

%% Different k values
opts = statset('Display','final');
%With Euclidean distance
fprintf('\nEuclidean distance\n');
% [idx,C,sumd,D] = kmeans(X,2,'replicates',5,'Options',opts);
 [idx,C,sumd,D] = kmeans(X,3,'replicates',5,'Options',opts);
 % [idx,C,sumd,D] = kmeans(X,4,'replicates',5,'Options',opts);
DifferentK(X,idx,C,k,'Euclidean'); %Function used to plot the result

%With Cosine distance
fprintf('\nCosine distance\n');
% [idx,C,sumd,D] = kmeans(X,2,'replicates',5,'Options',opts,'distance','cosine');
%  C=[mean(X(idx==1,:));mean(X(idx==2,:))];
 [idx,C,sumd,D] = kmeans(X,3,'replicates',5,'Options',opts,'distance','cosine');
  C=[mean(X(idx==1,:));mean(X(idx==2,:));mean(X(idx==3,:))];
% [idx,C,sumd,D] = kmeans(X,4,'replicates',5,'Options',opts,'distance','cosine');
% C=[mean(X(idx==1,:));mean(X(idx==2,:));mean(X(idx==3,:));mean(X(idx==4,:))];
DifferentK(X,idx,C,k,'Cosine'); %Function used to plot the result

%With Cosine distance
fprintf('\nCorrelation distance\n');
% [idx,C,sumd,D] = kmeans(X,2,'replicates',5,'Options',opts,'distance','correlation');
%  C=[mean(X(idx==1,:));mean(X(idx==2,:))];
 [idx,C,sumd,D] = kmeans(X,3,'replicates',5,'Options',opts,'distance','correlation');
  C=[mean(X(idx==1,:));mean(X(idx==2,:));mean(X(idx==3,:))];
% [idx,C,sumd,D] = kmeans(X,4,'replicates',5,'Options',opts,'distance','correlation');
% C=[mean(X(idx==1,:));mean(X(idx==2,:));mean(X(idx==3,:));mean(X(idx==4,:))];
DifferentK(X,idx,C,k,'Correlation'); %Function used to plot the result

%% Choosing k
idx2 = kmeans(X,2,'replicates',5);
idx3 = kmeans(X,3,'replicates',5);
idx4 = kmeans(X,4,'replicates',5);

figure()
[silh2,h2] = silhouette(X,idx2);
str = sprintf('k=2 and mean of s:%f',mean(silh2));
title(str);
figure()
[silh3,h3] = silhouette(X,idx3);
str = sprintf('k=3 and mean of s:%f',mean(silh3));
title(str);
figure()
[silh4,h4] = silhouette(X,idx4);
str = sprintf('k=4 and mean of s:%f',mean(silh2));
title(str);
Mean = [mean(silh2) mean(silh3) mean(silh3)];
index = find(Mean==max(Mean));
if(index==1)
    fprintf('\nk=2 is the best\n');
elseif(index==2)
    fprintf('\nk=3 is the best\n');
else
    fprintf('\nk=4 is the best\n');
end

%% Silhouette demo using synthetic data
% Generating Class1
class1(:,1)=-1+0.8*randn(100,1);
class1(:,2)=0+0.8*randn(100,1);

% Generating Class2
class2(:,1)=4+0.8*randn(100,1);
class2(:,2)=5+0.8*randn(100,1);

% G0enerating Class3
class3(:,1)=9+0.8*randn(100,1);
class3(:,2)=10+0.8*randn(100,1);

A=[class1;class2;class3];
%Plot
figure();
hold on;
title('Synthetic Data');
scatter(class1(:,1),class1(:,2),'r');
scatter(class2(:,1),class2(:,2),'g');
scatter(class3(:,1),class3(:,2),'b');
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
legend('class1','class2','class3');

idx2 = kmeans(A,2,'replicates',5);
idx3 = kmeans(A,3,'replicates',5);
idx4 = kmeans(A,4,'replicates',5);

figure()
[silh2,h2] = silhouette(A,idx2);
str = sprintf('k=2 and mean of s:%f',mean(silh2));
title(str);
figure();
hold on;
title('Silhouette Demo using synthetic data');
scatter(A(find(idx2==1),1),A(find(idx2==1),2),'r');
scatter(A(find(idx2==2),1),A(find(idx2==2),2),'g');
scatter(A(find(silh2<0),1),A(find(silh2<0),2),'kx');
hold off;
figure()
[silh3,h3] = silhouette(A,idx3);
str = sprintf('k=3 and mean of s:%f',mean(silh3));
title(str);
figure()
[silh4,h4] = silhouette(A,idx4);
str = sprintf('k=4 and mean of s:%f',mean(silh4));
title(str);
%% Different Distance and calculate the missclassfication
idx1 = kmeans(X,3);
idx3 = kmeans(X,3,'replicates',3);
idx5 = kmeans(X,3,'replicates',5);
idx10 = kmeans(X,3,'replicates',10);
Mis = CalMis(X,idx1,k,1);
Mis3 = CalMis(X,idx3,k,3);
Mis5 = CalMis(X,idx5,k,5);
Mis10 = CalMis(X,idx5,k,10);
fprintf('\nMis for replication = 1:%d\n', Mis);
fprintf('Mis for replication = 3:%d\n', Mis3);
fprintf('Mis for replication = 5:%d\n', Mis5);
fprintf('Mis for replication = 10:%d\n', Mis10);