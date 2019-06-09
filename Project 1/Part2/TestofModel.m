function [misclassification] = TestofModel(test1,test2,model)
    misclassification=0;
    Test=ones(size(test1,1),size(test1,2)+1);
    Test(:,1:size(test1,2))=test1(:,:);
    mis1=length(find((Test*transpose(model))<0));
    misclassification=misclassification+mis1;
    Test=ones(size(test2,1),size(test2,2)+1);
    Test(:,1:size(test2,2))=test2(:,:);
    mis2=length(find((Test*transpose(model))>0));
    misclassification=misclassification+mis2;
end

