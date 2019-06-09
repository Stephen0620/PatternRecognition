clear,clc;
close all;
% Generating Class1
class1(:,1)=1+0.8*randn(20,1);
class1(:,2)=2+0.8*randn(20,1);

% Generating Class2
class2(:,1)=4+0.8*randn(20,1);
class2(:,2)=5+0.8*randn(20,1);

%Plot
figure(1);
scatter(class1(:,1),class1(:,2),'r');
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
hold on;
scatter(class2(:,1),class2(:,2),'g');

X(1:20,:)=class1;
X(21:40,:)=class2;

Mean = [mean(class1);mean(class2)];
scatter(Mean(1,1),Mean(1,2),'rx');
scatter(Mean(2,1),Mean(2,2),'gx');
plot([Mean(1,1) Mean(2,1)],[Mean(1,2) Mean(2,2)]);

W=Mean(1,:)-Mean(2,:);
W0 = (mean(class1)+mean(class2))/2;
W0 = -dot(W,W0);

x = (0:0.1:5);
y = (-W(1)*x-W0)/W(2);
plot(x,y);