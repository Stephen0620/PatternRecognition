%void DifferentK(void)
function DifferentK(X,idx,C,k)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    switch k
        case 2
            figure(4);
            plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12)
            hold on
            plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.','MarkerSize',12)
            plot3(C(:,1),C(:,2),C(:,3),'kx','MarkerSize',15,'LineWidth',3)
            legend('Cluster 1','Cluster 2','Centroids','Location','NW')
            title 'Cluster Assignments and Centroids'
            xlabel('Length'); ylabel('Micronare'); zlabel('Yield');
            hold off
        case 3
            figure(4);
            plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12)
            hold on
            plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.','MarkerSize',12)
            plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'g.','MarkerSize',12)
            plot3(C(:,1),C(:,2),C(:,3),'kx','MarkerSize',15,'LineWidth',3)
            legend('Cluster 1','Cluster 2','Centroids');
            title ('Cluster Assignments and Centroids');
            xlabel('Length'); ylabel('Micronare'); zlabel('Yield');
            hold off;
        case 4
            figure(4);
            plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12)
            hold on
            plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.','MarkerSize',12)
            plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'g.','MarkerSize',12)
            plot3(C(:,1),C(:,2),C(:,3),'kx','MarkerSize',15,'LineWidth',3)
            legend('Cluster 1','Cluster 2','Centroids');
            xlabel('Length'); ylabel('Micronare'); zlabel('Yield');
            title ('Cluster Assignments and Centroids');
            hold off;
    end
end

