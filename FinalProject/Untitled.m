clear,clc;
close all;
Data = xlsread('Regression.xlsx');
Class1 = Data(find(Data(:,1)==1),:);
Class2 = Data(find(Data(:,1)==2),:);
Class3 = Data(find(Data(:,1)==3),:);
str = {'Yield','MIC','Length','strength','Elon'};
% MIC LENGTH Strength YIELD
for i=2:6
    for j=i+1:6
        for z=j+1:6
            figure();
            hold on;
            local = sprintf('%s vs %s vs %s', str{i-1},str{j-1},str{z-1});
            title(local);
            scatter3(Class1(:,i),Class1(:,j),Class1(:,z),'b');
            scatter3(Class2(:,i),Class2(:,j),Class1(:,z),'r');
            scatter3(Class3(:,i),Class3(:,j),Class1(:,z),'g');
        end
    end
end