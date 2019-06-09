function [ weight_vector,times ] = Batch_Perceptron(class1,class2,learning_rate,initial_guess)
    % Put 2 classes in one matrix and multiply class2 by -1
    class=ones((size(class1,1)+size(class2,1)),size(class1,2)+1);
    class(1:size(class,1)/2,1:size(class1,2))=class1;
    class(size(class,1)/2+1:size(class,1),1:size(class1,2))=class2;
    class(size(class,1)/2+1:size(class,1),:)=class(size(class,1)/2+1:size(class,1),:)*(-1);
    
    rho=learning_rate;
    initial=initial_guess;
    
    n=0; %Used for counting the number of correct classification
    times=0; % Record the time of iteration
    while(true)
        times=times+1;
        misvect=zeros(1,size(class1,2)+1); % Sum of all misclassified vectors
        for j=1:(size(class1,1)+size(class2,1))
            x1=zeros(1,size(class1,2)+1); %used for replication of vector
            x1(:) = class(j,:);
            if(x1*transpose(initial)<=0)
                misvect=misvect+x1;
            else
                n=n+1;
            end
        end
        if(n==(size(class1,1)+size(class2,1)))
            break;
        else
            initial=initial+rho*misvect;
            n=0;
        end
    end
    weight_vector=initial;
end

