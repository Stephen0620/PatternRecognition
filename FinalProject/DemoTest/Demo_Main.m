clear,clc;
close all;
Data(1:42,1) = 1;
Data(43:84,1) = 2;
Data(85:126,1) = 3;
Meas = load('Meas.mat');
Data(:,2:6) = Meas.Meas;
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
xlabel('Length'); ylabel('Micronare'); zlabel('Yield');


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
figure(2);
hold on;
scatter(Class1_2D(:,1),Class1_2D(:,2),'r');
scatter(Class2_2D(:,1),Class2_2D(:,2),'g');
scatter(Class3_2D(:,1),Class3_2D(:,2),'b');
plot(Centroid_2D(1,1),Centroid_2D(1,2),'kx','markers',24);
plot(Centroid_2D(2,1),Centroid_2D(2,2),'kx','markers',24);
plot(Centroid_2D(3,1),Centroid_2D(3,2),'kx','markers',24);
title('Original Data in 2 dimention with initial guess');
legend('class1','class2','class3','Centroid1','Centroid2','Centroid3');
xlabel('Micronare'); ylabel('Yield');

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
figure(3);
hold on;
scatter(Class1_2D(:,1),Class1_2D(:,2),'r');
scatter(Class2_2D(:,1),Class2_2D(:,2),'g');
scatter(Class3_2D(:,1),Class3_2D(:,2),'b');
plot(Centroid_2D(1,1),Centroid_2D(1,2),'kx','markers',24);
plot(Centroid_2D(2,1),Centroid_2D(2,2),'kx','markers',24);
plot(Centroid_2D(3,1),Centroid_2D(3,2),'kx','markers',24);
title('Demo');
legend('class1','class2','class3');
xlabel('Micronare'); ylabel('Yield');

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
    close figure 3;
    figure(3);
    hold on;
    scatter(Class1_2D(:,1),Class1_2D(:,2),'r');
    scatter(Class2_2D(:,1),Class2_2D(:,2),'g');
    scatter(Class3_2D(:,1),Class3_2D(:,2),'b');
    plot(Centroid_2D(1,1),Centroid_2D(1,2),'kx','markers',24);
    plot(Centroid_2D(2,1),Centroid_2D(2,2),'kx','markers',24);
    plot(Centroid_2D(3,1),Centroid_2D(3,2),'kx','markers',24);
    title('Demo 2 dimention');
    legend('class1','class2','class3','Centroid1','Centroid2','Centroid3');
    xlabel('Micronare'); ylabel('Yield');
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
%[idx,C,sumd,D] = kmeans(X,2,'replicates',5,'Options',opts);
[idx,C,sumd,D] = kmeans(X,3,'replicates',5,'Options',opts);
%[idx,C,sumd,D] = kmeans(X,4,'replicates',5,'Options',opts);
DifferentK(X,idx,C,k); %Function used to plot the result

%% Choosing k
idx2 = kmeans(X,2,'replicates',5);
idx3 = kmeans(X,3,'replicates',5);
idx4 = kmeans(X,4,'replicates',5);

figure()
[silh2,h2] = silhouette(X,idx2);
figure()
[silh3,h3] = silhouette(X,idx3);
figure()
[silh4,h4] = silhouette(X,idx4);
Mean = [mean(silh2) mean(silh3) mean(silh3)];
index = find(Mean==max(Mean));
if(index==1)
    fprintf('k=2 is the best\n');
elseif(index==2)
    fprintf('k=3 is the best\n');
else
    fprintf('k=4 is the best\n');
end

%% Different Distance and calculate the missclassfication
idx = kmeans(X,3,'replicates',5);
idx_cosine = kmeans(X,3,'replicates',5,'distance','cosine');
idx_correlation = kmeans(X,3,'replicates',5,'distance','correlation');
Mis = CalMis(idx,k);
Mis_cosine = CalMis(idx_cosine,k);
Mis_correlation = CalMis(idx_correlation,k);
fprintf('Mis for sqeuclidean:%d\n', Mis);
fprintf('Mis for cosine:%d\n', Mis_cosine);
fprintf('Mis for correlation:%d\n', Mis);