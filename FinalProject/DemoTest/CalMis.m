function Mis = CalMis(idx,k)
%CALMIS Summary of this function goes here
%   Detailed explanation goes here
    Mis = 0;
    Max=0;
    k=3;
    for i=1:k
        Number = length(find(idx(1:42)==i));
        if(Number>Max)
            Max=Number;
            Label=i;
        end
    end
    Mis = Mis + length(find(idx(1:42)~=Label));
    for i=1:k
        Number = length(find(idx(43:84)==i));
        if(Number>Max)
            Max=Number;
            Label=i;
        end
    end
    Mis = Mis + length(find(idx(43:84)~=Label));
    for i=1:k
        Number = length(find(idx(85:126)==i));
        if(Number>Max)
            Max=Number;
            Label=i;
        end
    end
    Mis = Mis + length(find(idx(85:126)~=Label));

end

