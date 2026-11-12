%% Get reconstruction error from 1 through i'th principal components
% Author: Danielle Shoshany
% Creation Date: March 2, 2024
% Last Updated: March 2, 2024

function [error] = getReconstructionError(dataset,Y,PC,i)

dataset = table2array(dataset(:,[2:(end-1)]));            % exclude attribute columns for ID and Class

% get mean centered x-data
colmean = mean((dataset));                     % mean of each column (mean per attribute)
for i = 1:numel(colmean)                 
    dataset(:,i) = dataset(:,i)-colmean(i);  % mean shift the data by subtracting column means from each element in each column
end

Xrec = Y(:,[1:i])*PC(:,[1:i])';              % reconstructed X data

% calculate mean square error
error = immse(dataset(:,[1:i]),Xrec(:,[1:i]));  

% formatspec = 'The mean square error is %d.';
% sprintf(formatspec,error)