clc
clear
close all
addpath(genpath(pwd));
%% Generating Data
% Generating Class1
class1(:,1)=5+0.8*randn(100,1);
class1(:,2)=6+0.8*randn(100,1);
% Generating Class2
class2(:,1)=7+0.8*randn(100,1);
class2(:,2)=8+0.8*randn(100,1);
figure(1);
scatter(class1(:,1),class1(:,2),'r');
xlabel('feature1'); ylabel('feature2');
hold on;
scatter(class2(:,1),class2(:,2),'g');
legend('class1','class2');
% Label
y=ones(100,1);
y(101:200,1)=-1;

%% Primal Form
A(1:100,:) = class1(:,:);
A(101:200,:) = class2(:,:);
x2=A;
N=size(A,1);
l=size(A,2);
% A(:,l+1) = 1;
% A(1:100,:) = A(1:100,:)*-1;
% A(101:200,:) = A(101:200,:)*1;
% b=-ones(size(A,1),1);
% H1=eye(l+1);
% H1(end)=0;
% f1=zeros(1,l+1);
% [W,fval,exitflag,output,lambda]=quadprog(H1,f1,A,b);
% x=2:0.1:10;
% decision=(-W(3)-W(1)*x)/W(2);
% support1=(-W(3)-W(1)*x+1)/W(2);
% support2=(-W(3)-W(1)*x-1)/W(2);
% plot(x,decision);
% plot(x,support1);
% plot(x,support2);
%% Dual Form
for i=1:size(x2,1)
    rep(i,:) = y(i)*x2(i,:);
end
H2=rep*rep';
f2=-ones(N,1);
Aeq=y';
beq=0;
lb=zeros(N,1);
ub=1000*ones(N,1);
[lambda2,fval,exitflag,output]=quadprog(H2,f2,[],[],Aeq,beq,lb,ub);
W2 = zeros(1,size(x2,2));
for i=1:size(x2,1)
   W2=W2+y(i)*lambda2(i)*x2(i,:);
end
nonzero=find(lambda2>0.00001);
W2(1,l+1) = 1/y(nonzero(1)) - dot(W2,x2(nonzero(1),:));
x=2:0.1:12;
decision=(-W2(3)-W2(1)*x)/W2(2);
support1=(-W2(3)-W2(1)*x+1)/W2(2);
support2=(-W2(3)-W2(1)*x-1)/W2(2);
plot(x,decision);
plot(x,support1);
plot(x,support2);