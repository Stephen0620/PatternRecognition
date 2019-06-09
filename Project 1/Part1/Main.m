clear,clc;
close all;
load('Proj1.mat');
feature1=ExploreData(:,1);
feature2=ExploreData(:,2);
feature3=ExploreData(:,3);
feature4=ExploreData(:,4);
class=ones(150,1);
class(51:100,1)=2;
class(101:150,1)=3;

%% Plot 2-D
X=[feature1 feature2 feature3 feature4];
varNames={'feature1','feature2','feature3','feature4'};

figure(1);
% Blue:class1, Green: class2, Red: class3
gplotmatrix(X,[],class,['b' 'g' 'r'],[],[],'off');
text([.08 .32 .54 .80], repmat(-.07,1,4), varNames, 'FontSize',12);
text(repmat(-.06,1,4), [.78 .56 .30 .06], varNames, 'FontSize',12, 'Rotation',90);

%% Plot 3-D
% feature1 feature2 feature3
figure(2)
scatter3(feature1(1:50),feature2(1:50),feature3(1:50),'bo');
hold on;
scatter3(feature1(51:100),feature2(51:100),feature3(51:100),'go');
scatter3(feature1(101:150),feature2(101:150),feature3(101:150),'ro');
xlabel('feature1');
ylabel('feature2');
zlabel('feature3');
legend('class1','class2','class3');

% feature1 feature3 feature4
figure(3)
scatter3(feature1(1:50),feature3(1:50),feature4(1:50),'bo');
hold on;
scatter3(feature1(51:100),feature3(51:100),feature4(51:100),'go');
scatter3(feature1(101:150),feature3(101:150),feature4(101:150),'ro');
xlabel('feature1');
ylabel('feature3');
zlabel('feature4');
legend('class1','class2','class3');

% feature2 feature3 feature4
figure(4)
scatter3(feature2(1:50),feature3(1:50),feature4(1:50),'bo');
hold on;
scatter3(feature2(51:100),feature3(51:100),feature4(51:100),'go');
scatter3(feature2(101:150),feature3(101:150),feature4(101:150),'ro');
xlabel('feature2');
ylabel('feature3');
zlabel('feature4');
legend('class1','class2','class3');

% feature1 feature2 feature4
figure(5)
scatter3(feature1(1:50),feature2(1:50),feature4(1:50),'bo');
hold on;
scatter3(feature1(51:100),feature2(51:100),feature4(51:100),'go');
scatter3(feature1(101:150),feature2(101:150),feature4(101:150),'ro');
xlabel('feature1');
ylabel('feature2');
zlabel('feature4');
legend('class1','class2','class3');

%% Classification using On-Line Perceptron(one-against-all)
% Classifify class1
class=ones(150,5);
class(:,1:4)=ExploreData(:,:);
class(51:150,:)=class(51:150,:)*(-1);
rho=1;
initial=zeros(1,size(class,2));

times=0; %Recording the times of iteration
while(true)
    times=times+1;
    n=0; %Recording of correct classification
    for j=1:size(class,1)
        x1=zeros(1,size(class,2)); %used for replication of vector
        x1(1,:) = class(j,:);
        if(x1*transpose(initial)<=0)
            initial=initial+rho*x1; %Update if the classification is wrong
        else
            n=n+1;
        end
    end
    if(n==size(class,1))
            break;
    end
end


%% Classification using Least Square(Multiple classes)
class=ones(150,5);
class(:,1:4)=ExploreData(:,:);
y=zeros(150,3);
for i=1:50
    y(i,:)=[1 -1 -1];
end
for i=51:100
    y(i,:)=[-1 1 -1];
end
for i=101:150
    y(i,:)=[-1 -1 1];
end
weight=pinv(class)*y;
weight1=weight(:,1);
weight2=weight(:,2);
weight3=weight(:,3);

% Classification
class1=class*weight1;
class2=class*weight2;
class3=class*weight3;

%% Testing Step
% Testing for on-line Perceptron
model_On=initial;
mis_On=class*transpose(model_On);
mis_On=length(find(mis_On(1:50,:)<0))+length(find(mis_On(51:150,:)>0));

% Testing for least square
weight1_mis1=length(find(class1(1:50,:)<0));
weight1_mis2to1=length(find(class1(51:100,:)>0));
weight1_mis3to1=length(find(class1(51:100,:)>0));

weight2_mis1to2=length(find(class2(1:50,:)>0));
weight2_mis2=length(find(class2(51:100,:)<0));
weight2_mis3to2=length(find(class2(101:150,:)>0));

weight3_mis1to3=length(find(class3(1:50)>0));
weight3_mis2to3=length(find(class3(51:100,:)>0));
weight3_mis3=length(find(class3(101:150,:)<0));