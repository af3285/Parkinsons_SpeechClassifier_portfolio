%% Perform PCA on pdspeechtable dataset
% This function takes the dataset in tabular form as input and provides names of
% attributes, the principle components, the output matrix with each pricipal 
% component (Y), the variances of each colummn in Y (V). 
% This function also plots the principle components for individual samples and provides
% reconstruction error. 

% Author: Danielle Shoshany
% Creation Date: March 1, 2024
% Last Updated: March 2, 2024

function [attributes,sampleclasses,PC,Y,V] = performPCA(dataset)

% data = datatable;
% dataset = pdspeechtable;

%% Get attribute names
attributes = dataset.Properties.VariableNames;
subset_attributes = attributes(2:end-1)';        % exclude ID and class attributes

%% Extract sampleclasses as 1xn vector where n is the number of samples
sampleclasses = table2array(dataset(:,end));

%% Reformat data matrix and perform pca()
subsetdata = table2array(dataset(:,[2:end-1]));          % extract columns with numeric data (exclude ID and class, the first and last columns respectively)

% PCA function matlab
% Y is output matrix with each pricipal component, V are variances of each colummn in Y
% PCA performs mean-centering of the data by column for you
[PC Y V]=pca(subsetdata);                      

%% Get x and y labels (% variance for each principle component)
% get the percentage each variance contributes to the total variance
var1 = [(V(1)/sum(V))*100];
var2 = [(V(2)/sum(V))*100];
spec1 = 'PCA1 (%s%%)';
spec2 = 'PCA2 (%s%%)';
xlab = sprintf(spec1,string(var1));
ylab = sprintf(spec2,string(var2));

%% Extract first two columns of Y (PC's with the highest variances)
Y_subset = Y(:,[1:2]);

%% Get indices of PD vs. Healthy
% PD indices
pdind = find(sampleclasses==1);

% healthy indices
healthyind = find(sampleclasses~=1);

%% Plot first two PCA for each sample and group by class
figure
plot(Y_subset(pdind,1),Y_subset(pdind,2),'MarkerSize',10,'LineStyle','none','Marker','.');
hold on
plot(Y_subset(healthyind,1),Y_subset(healthyind,2),'MarkerSize',10,'LineStyle','none','Marker','.');
hold on
grid on
xlabel(xlab)
ylabel(ylab)
legend("Parkinson's Disease","Healthy")





