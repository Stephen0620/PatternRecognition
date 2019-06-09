clc
clear
close all
addpath(genpath(pwd));

%% Generating the data
% Input Data
X=[];
N1=[];
C=[];

if(isempty(X)||isempty(N1)||isempty(C))
    class1(:,1)=5+0.8*randn(100,1);
    class1(:,2)=6+0.8*randn(100,1);

    % Generating Class2
    class2(:,1)=7+0.8*randn(100,1);
    class2(:,2)=8+0.8*randn(100,1);

    % Label
    y=ones(size(class1,1),1);
    y(size(class1,1)+1:size(class1,1)+size(class2,1),1)=-1;
    
    % Vector for parameter C
    C = [0.01 1 10 100];
else
    class1(:,1) = X(1:N1,1);
    class1(:,2) = X(1:N1,2);
    class2(:,1) = X(N1+1:size(X,1),1);
    class2(:,2) = X(N1+1:size(X,1),2);
    y=ones(size(class1,1),1);
    y(size(class1,1)+1:size(class1,1)+size(class2,1),1)=-1;
end
% Generating Class1

% Plot the data
figure();
hold on;
scatter(class1(:,1),class1(:,2),'r');
xlabel('feature1'); ylabel('feature2');
scatter(class2(:,1),class2(:,2),'g');
legend('class1','class2');


%% Part 1
X(1:size(class1,1),:) = class1(:,:);
X(size(class1,1)+1:size(class1,1)+size(class2,1),:) = class2(:,:);
x2=X;
N=size(X,1);
l=size(X,2);

% Generate H,f2,Aeq,beq,lb,ub for the quadprog
for i=1:size(X,1)
    rep(i,:) = y(i)*X(i,:);
end
H=rep*rep';
f=-ones(N,1);
Aeq=y';
beq=0;
lb=zeros(N,1);

%The upper bound for lambda
ub = zeros(N,length(C));
for i=1:length(C)
    ub(:,i) = C(i)*ones(N,1);
end

% Plot the boundary for different value C
mis_Linear = zeros(1,length(C));
for i=1:length(C)
    % Getting lambda from dual
    [lambda,fval,exitflag,output]=quadprog(H,f,[],[],Aeq,beq,lb,ub(:,i));
    W = zeros(1,size(X,2));
    lambda = round(lambda,3);
    %Obtain W
    for j=1:size(X,1)
        W=W+y(j)*lambda(j)*X(j,:);
    end
    distance = (1/norm(W))*2;
    %Index for support vector
    margin=find(lambda==C(i)); %Index for points in the margin
    Index_SV = find(lambda>0&lambda<C(i)); %Index for support vector
    
    %Obtain W(l+1)
    sum=0;
    for j=1:length(Index_SV)
        sum =sum + y(Index_SV(j)) - dot(W,X(Index_SV(j),:));
    end
    W(1,3)=sum/length(Index_SV);
    
    %Obtain decision and margin
    ax = axis;
    axis manual;
    x=(ax(1):0.1:ax(2));
    decision=(-W(3)-W(1)*x)/W(2);
    support1=(-W(3)-W(1)*x+1)/W(2);
    support2=(-W(3)-W(1)*x-1)/W(2);
    
    
    %Plot the data first
    figure();
    hold on;
    scatter(class1(:,1),class1(:,2),'r');
    xlabel('feature1'); ylabel('feature2');
    scatter(class2(:,1),class2(:,2),'g');
    
    %Plot the support vectors, margin and decision boundary
    scatter(X(Index_SV(:),1),X(Index_SV(:),2),'b','filled');
    scatter(X(margin(:),1),X(margin(:),2),'d','filled');
    plot(x,decision);
    plot(x,support1);
    plot(x,support2);
    
    %Calculate the misclassification and plot it 
    for j=1:size(class1,1)
       if((class1(j,:)*W(1:2)'+W(l+1))<0)
            mis_Linear(i) = mis_Linear(i)+1;
            scatter(class1(j,1),class1(j,2),100,'x');
        end
    end 
    for j=1:size(class2,1)
       if((class2(j,:)*W(1:2)'+W(l+1))>=0)
            mis_Linear(i) = mis_Linear(i)+1;
            scatter(class2(j,1),class2(j,2),100,'x');
        end
    end 
    str = sprintf('C=%d MarginDistance:%f Missclassification:%d',C(i),distance, mis_Linear(i));
    title(str);
    legend({'class1','class2','supprt vector','points in the margin and mis','boundary','margin 1','margin 2','missclassified'},'Location','northeastoutside');
end

%% Part 2
%Polynomial kernel
q1=1;
q2=2;

% Generate H,f2,Aeq,beq,lb,ub for the quadprog
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

%The upper bound for lambda
ub = zeros(N,length(C));
for i=1:length(C)
    ub(:,i) = C(i)*ones(N,1);
end

% Plot the boundary for different value C
mis_Kernel = zeros(1,length(C));
for i=1:length(C)
    [lambda,fval,exitflag,output,W1]=quadprog(H,f2,[],[],Aeq,beq,lb,ub(:,i));
    W = 0;
    lambda = round(lambda,5);
    nonzero=find(lambda>0); 
    margin = find(lambda==C(i)); %points in the region
    Index_SV = find(lambda>0&lambda~=C(i)); %support vector
    
    %Obtain W
    for z=1:length(Index_SV)
        for j=1:length(nonzero)
           W=W+y(nonzero(j))*lambda(nonzero(j))*(dot(x2(nonzero(j),:),x2(Index_SV(z),:))+q1).^q2;
        end
    end
    W=W/length(Index_SV);
    
    %Obtain W(l+1)
    sum=0;
    for j=1:length(Index_SV)
         sum = sum + 1/y(Index_SV(j)) - W;
    end
    W0 = sum/length(Index_SV);
    
    %Plot
    ax = axis;
    axis manual;
    Xaxis = (ax(1):0.1:ax(2))';
    Yaxis = (ax(3):0.1:ax(4))';
    [X1,Y] = meshgrid(Xaxis,Yaxis);
    XX=reshape(X1,[],1);
    YY=reshape(Y,[],1);
    func = @(x) (((x*x2')+q1*ones(length(XX),N)).^q2)*(lambda.*y)+W0;
    figure();
    hold on;
    scatter(class1(:,1),class1(:,2),'r');
    xlabel('feature1'); ylabel('feature2');
    scatter(class2(:,1),class2(:,2),'g');
    scatter(X(Index_SV(:),1),X(Index_SV(:),2),'b','filled');
    scatter(X(margin(:),1),X(margin(:),2),'d','filled');
    M=[XX,YY];
    ZZ = func(M);
    Z = reshape(ZZ,size(X1));
    contour(X1,Y,Z,[0,-1,1]);
    D = (((x2*x2')+q1).^q2)*(lambda.*y)+W0;
    miss1=find(D(1:size(class1,1),:)<0);
    miss2=find(D(size(class1,1)+1:size(class1,1)+size(class2,1),:)>0);
    mis_Kernel(i) = length(miss1)+length(miss2);
    scatter(class1(miss1(:),1),class1(miss1(:),2),'x');
    scatter(class2(miss2(:),1),class2(miss2(:),2),'x');
    str = sprintf('C=%d Misclassification:%d',C(i),mis_Kernel(i));
    title(str);
    legend({'class1','class2','supprt vector','In the margin and mis','boundary','missclassified'},'Location','northeastoutside');
   
    figure();
    svmtrain(X,y,'autoscale',false,'boxconstraint',C(i),'ShowPlot',true,'kernel_function','polynomial','polyorder',q2,'method','QP');
    str = sprintf('C=%d',C(i));
    title(str);
end