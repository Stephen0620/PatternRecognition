%% Generating Data
close all;
clear,clc;
% Generating Class1
mu=[3,5];
sigma=[1,0.5;0.5,3];
class1=mvnrnd(mu,sigma,50);

figure(1);
scatter(class1(:,1),class1(:,2),'r+');
hold on;
title('Data');
axis([0 15 0 15])
% Generating Class2
mu=[9,10];
sigma=[1,1.5;1.5,3];
class2=mvnrnd(mu,sigma,50);
scatter(class2(:,1),class2(:,2),'g+');
legend('class1','class2');

%% Getting a model
learning_rate=2;
initial_guess=[0 0 0];
[model_On,times_ON]=On_Line_Perceptron(class1,class2,learning_rate,initial_guess);
[model_Batch,times_Batch]=Batch_Perceptron(class1,class2,learning_rate,initial_guess);
[model_LS]=Least_Square(class1,class2);

%% Testing Step
mu=[3,5];
sigma=[1,0.5;0.5,3];
test1=mvnrnd(mu,sigma,50);

mu=[9,10];
sigma=[1,1.5;1.5,3];
test2=mvnrnd(mu,sigma,50);

figure(2);
scatter(test1(:,1),test1(:,2),'r+');
hold on;
title('testing data');
axis([0 15 0 15]);
scatter(test2(:,1),test2(:,2),'g+');
mis_On=TestofModel(test1,test2,model_On);
mis_Batch=TestofModel(test1,test2,model_Batch);
mis_LS=TestofModel(test1,test2,model_LS);

%% Draw the decision Boundary
x=0:0.1:15;

%Draw the model of On-Line Perceptron
y=(-model_On(3)-x*model_On(1))/model_On(2);
plot(x,y);

%Draw the model of On-Line Perceptron
y=(-model_Batch(3)-x*model_Batch(1))/model_Batch(2);
plot(x,y);

%Draw the model of On-Line Perceptron
y=(-model_LS(3)-x*model_LS(1))/model_LS(2);
plot(x,y);

%Add the description
legend('class1','class2','On-line','Batch','LS');
    
