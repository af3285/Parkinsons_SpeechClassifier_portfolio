function[fitacc] = FeatureFitness(selfeatures)
%This is a function written by Aaron Fryzel on 3/5/24 to evalulate the
%fitness of a set of selected features as a part of GS feature selection optimization
load("variablesforfitness.mat")
%loading mat file so that training + holdout data is consistent across all code 
selected_indices = find(selfeatures);
selected_trainData = X(:, selected_indices);
%Since ga() finds the local minima of a function by multiplying our
%accuarcy by zero we are instead able to find maxima 
%Using NUMHIDDEN = 17 as that was found to be optimal during testing
fitacc=-1*neuralnetwork(selected_trainData,T,17);%In the future this type of implementation should be iterated through and averaged out to account for random chance