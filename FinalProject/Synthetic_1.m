clear,clc;
close all;
%% Synthetic Data
% Generating Class1
class1(:,1)=1+0.8*randn(100,1);
class1(:,2)=2+0.8*randn(100,1);

% Generating Class2
class2(:,1)=4+0.8*randn(100,1);
class2(:,2)=5+0.8*randn(100,1);

% G0enerating Class3
class3(:,1)=8+0.8*randn(100,1);
class3(:,2)=9+0.8*randn(100,1);

%Plot
figure(1);
scatter(class1(:,1),class1(:,2),'r');
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
hold on;
scatter(class2(:,1),class2(:,2),'g');
scatter(class3(:,1),class3(:,2),'b');
legend('class1','class2','class3');

%% K means Algorothm
k=3;
X(1:100,:)=class1;
X(101:200,:)=class2;
X(201:300,:)=class3;
Axis=axis;
xmin=Axis(1);
xMax=Axis(2);
ymin=Axis(3);
yMax=Axis(4);

%Initial guessing cetroid
%x=(xMax-xmin).*rand(k,1)+xmin;
%y=(yMax-ymin).*rand(k,1)+ymin;
x(1)=class1(1,1);
y(1)=class1(1,2);
x(2)=class2(1,1);
y(2)=class2(1,2);
x(3)=class3(1,1);
y(3)=class3(1,2);
plot(x(1),y(1),'rx');
plot(x(2),y(2),'bx');
plot(x(3),y(3),'gx');

time=0;
isChanged=true;
while(isChanged)
    time=time+1;
    isChanged=false;
    if(time~=1)
        C1=X(find(X(:,3)==1),:);
        C2=X(find(X(:,3)==2),:);
        C3=X(find(X(:,3)==3),:);
        x(1)=mean(C1(:,1));
        y(1)=mean(C1(:,2));
        x(2)=mean(C2(:,1));
        y(2)=mean(C2(:,2));
        x(3)=mean(C3(:,1));
        y(3)=mean(C3(:,2));
        figure(2);
        hold on;
        scatter(C1(:,1),C1(:,2),'r');
        scatter(C2(:,1),C2(:,2),'b');
        scatter(C3(:,1),C3(:,2),'g');
    end
    for i=1:size(X,1)
        min=100000000;
        for j=1:k
            D=[X(i,1),X(i,2);x(j),y(j)];
            distance=pdist(D,'euclidean');
            if(distance<min)
                min=distance;
                min_index=j;
            end
        end
        if(time~=1)
            if(X(i,3)~=min_index)
                isChanged=true;
                X(i,3) = min_index;
            end
        else
            X(i,3) = min_index;
            isChanged=true;
        end
    end
end

C1=X(find(X(:,3)==1),:);
C2=X(find(X(:,3)==2),:);
C3=X(find(X(:,3)==3),:);
figure(2);
hold on;
scatter(C1(:,1),C1(:,2),'r');
scatter(C2(:,1),C2(:,2),'b');
scatter(C3(:,1),C3(:,2),'g');
