function Answer = GetBoundary(X,Mean,k)
%GETBOUNDARY Summary of this function goes here
%   Detailed explanation goes here
    l=size(Mean,2);
    X(:,size(X,2)+1) = 1;
    n=1;
    for i=1:size(Mean,1)
        for j=i+1:size(Mean,1)
            W(n,1:l) = Mean(j,:)-Mean(i,:);
            W(n,l+1) = -dot((Mean(i,:)+Mean(j,:))/2,W(n,1:2));
            n=n+1;
        end
    end
    
    Decision = X*W';
    
    for i=1:size(W,2)
        Difference(i) = abs(length(find(Decision(:,i)>0))...
            -length(find(Decision(:,i)<0)));
    end
    
    n=1;
    for i=1:size(W,2)
        if(Difference(i)<=max(Difference))
            Answer(n,:)=W(i,:);
            n=n+1;
        end
    end
end

