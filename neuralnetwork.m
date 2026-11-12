function [accuracy, time] = neuralnetwork(X, T, numhidden, index)
%{
Function trains a neural network on test data
Takes as input feature matrix, target vector, number of hidden nodes
(optional) and index of features to use (optional)
Returns as output the test accuracy, run time, and final network
Author: Zachary Heffernan (zh438) 20240302
%}

%Start timer
tic
%% Initialize
%If numhidden input not provided, default to 1 hidden node
if ~exist('numhidden', 'var'); numhidden = 1; end
%If index input is provided, subset feature matrix
if exist('index', 'var'); X = X(:, index); end
%Create cross validation vector
kfold = 5;
Icross = crossvalind('kfold',size(X,1),kfold);
%Create empty vector to store if a given test sample is correctly predicted
correct = false(size(X,1), 1);

%% Accuracy
%For each cross validation index
for k = 1:kfold
	%Split X & T into testing and training based on cross validation indices
	Xtest = X(Icross == k, :);
	Ttest = T(Icross == k);
	Xtrain = X(Icross ~= k, :);
	Ttrain = T(Icross ~= k);

	%Create network
	net=patternnet(numhidden);
	%Set parameters
	net.divideParam.trainRatio=1;
	net.divideParam.valRatio=0;
	net.divideParam.testRatio=0;
	%Suppress training display window
	net.trainParam.showWindow = 0;

	%Train network on training set
	net = train(net, Xtrain', Ttrain');

	%Find if the network correctly predicted test samples
	Ytest = sim(net, Xtest')';
	correct(Icross == k) = Ttest == (Ytest>0.5);
end

%Find overall model test accuracy
accuracy = mean(correct);

%% Run Time
time = toc;

%% Final Network
%Create network
% net=patternnet(numhidden);
%Set parameters
% net.divideParam.trainRatio=1;
% net.divideParam.valRatio=0;
% net.divideParam.testRatio=0;
%Suppress training display window
% net.trainParam.showWindow = 0;

%Train network on all data
% net = train(net, X', T');

%% Run Time
% time = toc;