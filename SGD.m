%Nora Basha- 12/12/2019- 
%ECE 599-Large Scale convex/non-convex optimization
% SGD Algorithm with Linear Regression problem with 55 iterations to clarify the
% oscillations in the optimal solution neighborhood.
%=====================================================================================
clc
clear
A = readmatrix('train.csv');
classLabel=A(1:210,2)';
TrainingData=A(1:210,1)';
Selector=randi([1 210],1,2*length(classLabel));
ALpha=0.0001;
xprim=10;
x=10;
inew=1;
t=1;
while(t<=55 )
%Selecting random gradient sample at x    
for i=inew:length(Selector)
    u=Selector(i);
 gs(i)= 2*(classLabel(u)-TrainingData(u)*x)*-TrainingData(u);
 inew=i+1;
 break
end
%SGD update equation
xnew(t)=x-ALpha*gs(i);
x=xnew(t);
t=t+1;
end
stem(xnew,'DisplayName','SGD oscillations')
xlabel('Iterations')
ylabel('Optimal variable value')
