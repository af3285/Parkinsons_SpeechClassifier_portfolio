function[selectedfeatures,accuarcy,featureidx]= genfeatureselect(X,T,pop)
%This code began development on 3/2/24 and was last edited 3/8/24 by Aaron
%Fryzel
%This function applies a genetic feature selection method to our project data
%Setting up important variables, since we will be iterating through
%population in our for loop we don't need to set it here
generations = 3;%can be changed but not recomended due to computation strain
fitnesslimit=0.3;

%Implemenatition of ga() toolbox
options = optimoptions('ga', 'Display', 'iter','PopulationSize',pop,'MaxGenerations',generations,'FitnessLimit',fitnesslimit);
%When testing this change parameters
locmaxima = ga(@FeatureFitness,size(X,2), [], [], [], [], zeros(1, size(X,2)), ones(1, size(X,2)), [], 1:size(X,2),options);

%Since locmaxima is a binary vector no iteration of filter is needed 
featureidx= locmaxima >= 0.5;
%Selecting features
Xselected=X(:,featureidx);
%Finding selected feature names
rdata=loaddataset();
pdata=rdata(:,2:end-1);
selectedfeatures=pdata.Properties.VariableNames(featureidx);

%testing accuarcy of selected data
accuarcy=neuralnetwork(Xselected,T,17);%In the future this type of implementation should be iterated through and averaged out to account for random chance