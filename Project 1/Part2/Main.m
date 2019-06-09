%% Generating Data
close all;
clear,clc;
% Generating Class1
class1(:,1)=5+0.8*randn(100,1);
class1(:,2)=6+0.8*randn(100,1);
class1(:,3)=7+0.8*randn(100,1);

% Generating Class2
class2(:,1)=7.5+0.8*randn(100,1);
class2(:,2)=8.5+0.8*randn(100,1);
class2(:,3)=9.5+0.8*randn(100,1);

%Plot
figure(1);
scatter3(class1(:,1),class1(:,2),class1(:,3),'r');
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
axis([2 15 2 15 2 15])
hold on;
scatter3(class2(:,1),class2(:,2),class2(:,3),'g');
legend('class1','class2');
%% Getting a model
learning_rate=1;
initial_guess=[0 0 0 0];
[model_On,times_ON]=On_Line_Perceptron(class1,class2,learning_rate,initial_guess);
[model_Batch,times_Batch]=Batch_Perceptron(class1,class2,learning_rate,initial_guess);
[model_LS]=Least_Square(class1,class2);

%% Testing Step
% Generate testing data for class1
test1(:,1)=5+0.8*randn(100,1);
test1(:,2)=6+0.8*randn(100,1);
test1(:,3)=7+0.8*randn(100,1);
% Generate testing data for class2
test2(:,1)=7.5+0.8*randn(100,1);
test2(:,2)=8.5+0.8*randn(100,1);
test2(:,3)=9.5+0.8*randn(100,1);

mis_On=TestofModel(test1,test2,model_On);
mis_Batch=TestofModel(test1,test2,model_Batch);
mis_LS=TestofModel(test1,test2,model_LS);

%% Draw the decision Boundary
%On-Line Perceptron
figure(2);
scatter3(test1(:,1),test1(:,2),test1(:,3),'r');
title('Decision Boundary of On-line Perceptron')
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
axis([2 15 2 15 2 15])
hold on;
scatter3(test2(:,1),test2(:,2),test2(:,3),'g');
legend('class1','class2');

x=2:0.1:15;
[X,Y] = meshgrid(x);
Z=(-model_On(4)-model_On(1)*X-model_On(2)*Y)/model_On(3);
surf(X,Y,Z);

%Batch Perceptron
figure(3);
scatter3(test1(:,1),test1(:,2),test1(:,3),'r');
title('Decision Boundary of Batch Perceptron')
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
axis([2 15 2 15 2 15])
hold on;
scatter3(test2(:,1),test2(:,2),test2(:,3),'g');
legend('class1','class2');

x=2:0.1:15;
[X,Y] = meshgrid(x);
Z=(-model_Batch(4)-model_Batch(1)*X-model_Batch(2)*Y)/model_Batch(3);
surf(X,Y,Z);

%Least Square
figure(4);
scatter3(test1(:,1),test1(:,2),test1(:,3),'r');
title('Decision Boundary of Least Square')
xlabel('feature1'); ylabel('feature2'); zlabel('feature3');
axis([2 15 2 15 2 15])
hold on;
scatter3(test2(:,1),test2(:,2),test2(:,3),'g');
legend('class1','class2');

x=2:0.1:15;
[X,Y] = meshgrid(x);
Z=(-model_LS(4)-model_LS(1)*X-model_LS(2)*Y)/model_LS(3);
surf(X,Y,Z);

