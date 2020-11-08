%Nora Basha- 12/12/2019- 
%ECE 599-Large Scale convex/non-convex optimization
% SVRG Algorithm with Linear Regression problem
%To run the code, make sure to download the file train.csv
%======================================
clc
clear
%Reading Training Data
A = readmatrix('train.csv');
classLabel=A(1:210,2)';
TrainingData=A(1:210,1)';
%Initializing a selector to choose gradient elements randomly on each SGD
%iteration
Selector=randi([1 210],1,2*length(classLabel));
ALpha=0.0001;
outerloop=1;
%SVRG variable
xprim=10;
%SGD variable
x=10;
%SVRG loop (s)
while (outerloop<=6)
%meu(batch gradient at xprim)
for j= 1:length(classLabel)
 gsi(j)= 2*(classLabel(j)-TrainingData(j)*xprim)*(-TrainingData(j));
end
meu= (1/length(classLabel))*sum(gsi);
inew=1;
innerloop=1;
%SGD loop (m)
while(innerloop<=2*length(classLabel) )
    
for i=inew:length(Selector)
    u=Selector(i);
 % single gradient element at SGD variable x   
 gs(i)= 2*(classLabel(u)-TrainingData(u)*x)*-TrainingData(u);
 % single gradient element at EVRG variable x' 
 gsnap(i)=2*(classLabel(u)-TrainingData(u)*xprim)*-TrainingData(u);
 inew=i+1;
 break
end
%inner loop update equation, where x new is calculated based on the SVRG
%algorithm
xnew(innerloop)=x-ALpha*(gs(i)+meu-gsnap(i));
x=xnew(innerloop);
innerloop=innerloop+1;
end
% Option 1 here on the algorithm is adopted,x'= mean of all x in the
% innerloop
xprim=mean(xnew);% or xnew(innerloop)
y(outerloop)=(norm(classLabel-TrainingData*xprim))^2;
outerloop=outerloop+1;
%end
end
x_Closed_Form=(TrainingData*TrainingData')\TrainingData*classLabel'
x_Optimal_SVRG= xprim
