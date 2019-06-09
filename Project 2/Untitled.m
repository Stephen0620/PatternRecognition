clc
clear
close all
addpath(genpath(pwd));
%% Generating Data
% Generating Class1
class1(:,1)=1+0.8*randn(100,1);
class1(:,2)=2+0.8*randn(100,1);
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

%%
A(1:100,:) = class1(:,:);
A(101:200,:) = class2(:,:);
x2=A;
N=size(A,1);
l=size(A,2);
q1=1;
q2=2;
% Polynomial
for i=1:size(x2,1)
    for j=1:size(x2,1)
        k(i,j)=(x2(i,:)*x2(j,:)'+q1).^q2;
    end
end
H=(y*y').*k;
f2=-ones(N,1);
Aeq=y';
beq=0;
lb=zeros(N,1);
ub=100*ones(N,1);
[lambda,fval,exitflag,output,W1]=quadprog(H,f2,[],[],Aeq,beq,lb,ub);
W = 0;
nonzero=find(lambda>0.00001);
for i=1:length(nonzero)
   W=W+y(nonzero(i))*lambda(nonzero(i))*(dot(x2(nonzero(i),:),x2(nonzero(1),:))+q1).^q2;
end
W0 = 1/y(nonzero(1)) - W;

Xaxis = (1:0.1:12)';
Yaxis = (1:0.1:12)';
[X,Y] = meshgrid(Xaxis,Yaxis);
XX=reshape(X,[],1);
YY=reshape(Y,[],1);
func = @(x) (((x*x2')+q1*ones(length(XX),N)).^q2)*(lambda.*y)+W0;

M=[XX,YY];
ZZ = func(M);
Z = reshape(ZZ,size(X));
contour(X,Y,Z,[0,-1,1]);

