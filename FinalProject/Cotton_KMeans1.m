clear,clc;

load('fea1.mat');
%% Synthetic Data

% Generating Class1
class1=fea1(1:42,:);

% Generating Class2
class2=fea1(43:84,:);

% G0enerating Class3
class3=fea1(85:126,:);

%Plot % MIC STRENGTH ELONGATION, MIC LENGTH ELONGATION, MIC LENGTH Strength
figure(2);
scatter3(class1(:,1),class1(:,2),class1(:,3),'r');
xlabel('Yield'); ylabel('Micronare'); zlabel('Elongation');
hold on;
scatter3(class2(:,1),class2(:,2),class2(:,3),'g');
scatter3(class3(:,1),class3(:,2),class3(:,3),'b');
legend('class1','class2','class3');
title(['Cotton field data']);

%% K means Algorothm
k=3;
class1=fea1(1:42,:);
class2=fea1(43:84,:);
class3=fea1(85:126,:);
X(:,:) = fea1(:,:);
Axis=axis;
xmin=Axis(1);
xMax=Axis(2);
ymin=Axis(3);
yMax=Axis(4);
zmin=Axis(5);
zMax=Axis(6);

%Initial guessing cetroid
Random=randperm(size(X,1));
Test=[34,57,95];
Centroid = X(Test(:),:);
x=Centroid(:,1);
y=Centroid(:,2);
z=Centroid(:,3);
plot3(x(1),y(1),z(1),'rx');
plot3(x(2),y(2),z(2),'bx');
plot3(x(3),y(3),z(3),'gx');

time=0;
isChanged=true;
while(isChanged)
    time=time+1;
    isChanged=false;
    if(time~=1)
        C1=X(find(X(:,4)==1),:);
        C2=X(find(X(:,4)==2),:);
        C3=X(find(X(:,4)==3),:);
        x(1)=mean(C1(:,1));
        y(1)=mean(C1(:,2));
        z(1)=mean(C1(:,3));
        x(2)=mean(C2(:,1));
        y(2)=mean(C2(:,2));
        z(2)=mean(C2(:,3));
        x(3)=mean(C3(:,1));
        y(3)=mean(C3(:,2));
        z(3)=mean(C3(:,3));
        figure(2);
        scatter3(C1(:,1),C1(:,2),C1(:,3),'r');
        xlabel('Yield'); ylabel('Micronare'); zlabel('Elongation');
        hold on;
        scatter3(C2(:,1),C2(:,2),C2(:,3),'b');
        scatter3(C3(:,1),C3(:,2),C3(:,3),'g');
        legend('class1','class2','class3');
        title(['K-Means on Synthetic data']);
    end
    for i=1:size(fea1,1)
        min=100000000;
        for j=1:k
            D=[X(i,1),X(i,2),X(i,3);x(j),y(j),z(j)];
            distance=pdist(D);
            if(distance<min)
                min=distance;
                min_index=j;
            end
        end
        if(time~=1)
            if(X(i,4)~=min_index)
                isChanged=true;
                X(i,4) = min_index;
            end
        else
            X(i,4) = min_index;
            isChanged=true;
        end
    end
end

C1=X(find(X(:,4)==1),:);
C2=X(find(X(:,4)==2),:);
C3=X(find(X(:,4)==3),:);


%% Calculate the mis-classified
Label_C1 = C1(1,4);
mis_C1 = length(find(X(1:42,4)~=Label_C1));
Label_C2 = C2(1,4);
mis_C2 = length(find(X(43:84,4)~=Label_C2));
Label_C3 = C3(1,4);
mis_C3 = length(find(X(85:126,4)~=Label_C3));
mis = mis_C1 + mis_C2 + mis_C3

figure(3);
xlabel('Yield'); ylabel('Micronare'); zlabel('Elongation');
scatter3(C1(:,1),C1(:,2),C1(:,3),'r');
hold on;
scatter3(C2(:,1),C2(:,2),C2(:,3),'b');
scatter3(C3(:,1),C3(:,2),C3(:,3),'g');
legend('class1','class2','class3');
str = sprintf('K-Means with Euclidean, mis:%d', mis);
title(str);