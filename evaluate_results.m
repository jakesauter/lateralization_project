% % This script will be used to evaluate the results of the
% % searchlight_analysis script

results = dlmread('searchlight_results');

% Want to find out of the regions with the higest boost, which regions had
% the highest accuracy 

% Make a column for boost 

results(:,6) = results(:,5) - max(results(:,3), results(:,4));

% Sort the results by boost

results = sortrows(results,6,'descend');

% Grab all of the results that show over a 5% boost

boosted_results = results(results(:,6) > .05, :);

% Put the average of ROI accuracy in the 7th column to sort by this

boosted_results(:,7) = (boosted_results(:,3) + boosted_results(:,4)) / 2;

% Sort these results by highest single ROI accuracy before boost

boosted_results = sortrows(boosted_results, 7, 'descend');