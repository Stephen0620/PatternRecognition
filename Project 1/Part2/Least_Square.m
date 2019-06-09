function [weight_vector] = Least_Square(class1,class2)
    % Creating X Matrix in the Notes
    class=ones((size(class1,1)+size(class2,1)),size(class1,2)+1);
    class(1:size(class,1)/2,1:size(class1,2))=class1;
    class(size(class,1)/2+1:size(class,1),1:size(class1,2))=class2;
    % Creating y
    y=ones((size(class1,1)+size(class2,1)),1);
    y(size(class,1)/2+1:size(class,1))=y(size(class,1)/2+1:size(class,1))*(-1);
    % Find the answer
    weight_vector=transpose(pinv(class)*y);
end

