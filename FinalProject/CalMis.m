function Mis = CalMis(X,idx,k)
%CALMIS Summary of this function goes here
%Detailed explanation goes here
    figure();
    hold on;
    scatter3(X(1:42,1),X(1:42,2),X(1:42,3),'r');
    scatter3(X(43:84,1),X(43:84,2),X(43:84,3),'g');
    scatter3(X(85:126,1),X(85:126,2),X(85:126,3),'b');
    Mis = 0;
    Max=0;
    for i=1:k
        Number = length(find(idx(1:42)==i));
        if(Number>Max)
            Max=Number;
            Label=i;
        end
    end
    Mis = Mis + length(find(idx(1:42)~=Label));
    scatter3(X(find(idx(1:42)~=Label),1),X(find(idx(1:42)~=Label),2),...
        X(find(idx(1:42)~=Label),3),'kx');
    for i=1:k
        Number = length(find(idx(43:84)==i));
        if(Number>Max)
            Max=Number;
            Label=i;
        end
    end
    Mis = Mis + length(find(idx(43:84)~=Label));
    scatter3(X(find(idx(43:84)~=Label),1),X(find(idx(43:84)~=Label),2),...
        X(find(idx(43:84)~=Label),3),'kx');
    for i=1:k
        Number = length(find(idx(85:126)==i));
        if(Number>Max)
            Max=Number;
            Label=i;
        end
    end
    Mis = Mis + length(find(idx(85:126)~=Label));
    scatter3(X(find(idx(85:126)~=Label),1),X(find(idx(85:126)~=Label),2),...
        X(find(idx(85:126)~=Label),3),'kx');
end

