function Label = GetLabel(X,W)
%GETLABEL Summary of this function goes here
%   Detailed explanation goes here
    X(:,size(X,2)+1) = 1;
    Label1=X*W(1,:)';
    Label2=X*W(2,:)';
    for i=1:size(Label1,1);
        if((Label1(i)>0)&&(Label2(i)>0))
            Label(i) = 1;
        elseif((Label1(i)>0)&&(Label2(i)<0))
            Label(i) = 2;
        elseif((Label1(i)<0)&&(Label2(i)>0))
            Label(i) = 2;
        elseif((Label1(i)<0)&&(Label2(i)<0))
            Label(i) = 3;
        end
    end
    
end

