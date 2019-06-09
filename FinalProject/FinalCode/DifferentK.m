%void DifferentK(void)
function DifferentK(X,idx,C,k,distance)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    switch k
        case 2
            figure();
            plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12)
            hold on
            plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.','MarkerSize',12)
            plot3(C(:,1),C(:,2),C(:,3),'kx','MarkerSize',15,'LineWidth',3)
            legend('Cluster 1','Cluster 2','Centroids','Location','NW')
            str = sprintf('Cluster Assignments and Centroids:%s', distance);
            title(str);
            xlabel('Length'); ylabel('Micronaire'); zlabel('Yield');
            hold off
        case 3
            figure();
            plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12)
            hold on
            plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.','MarkerSize',12)
            plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'g.','MarkerSize',12)
            plot3(C(:,1),C(:,2),C(:,3),'kx','MarkerSize',15,'LineWidth',3)
            legend('Cluster 1','Cluster 2','Cluster 3','Centroids');
            str = sprintf('Cluster Assignments and Centroids:%s', distance);
            title(str);
            xlabel('Length'); ylabel('Micronaire'); zlabel('Yield');
            hold off;
        case 4
            figure();
            plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12)
            hold on
            plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'b.','MarkerSize',12)
            plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'g.','MarkerSize',12)
            plot3(C(:,1),C(:,2),C(:,3),'kx','MarkerSize',15,'LineWidth',3)
            legend('Cluster 1','Cluster 2','Cluster 3','Centroids');
            xlabel('Length'); ylabel('Micronaire'); zlabel('Yield');
            str = sprintf('Cluster Assignments and Centroids:%s', distance);
            title(str);
            hold off;
    end
end

