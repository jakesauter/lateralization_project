% Parameters for different functionality

% The percentile of distance of vertices that will be included

distance_threshold = .05;

% The minimum number of vertices that must be in a selected region that are
% in the same voxel in order for the voxel's timecourse data to be included
% in the analysis

num_vertices_needed = 5;

% When true, feature selection is performed on the training voxels and all
% voxels such that p < .05 are chosen to be used in the analysis

feature_selection = false;

% When true, all blocks are set to be contigous as opposed to spaced out
% due to questioning being done during the study 
% (i.e. 1 0 1 0 1 0 --> 1 1 1 1 1 1)

contiguous_regressor = false;

% When true, removes all vertices not in the same labelled parecellation of
% the region of interest.

remove_not_from_region = false;

% found that the vertices that
% correspond the center of the FFA for s103 are left: 72350 right: 75507

vertex_number = [72350, 75507];

% Register the hemispheres of the subject that we are analyzing

register_hemispheres
 
vertex_to_roi = {lh_vertex_to_roi, rh_vertex_to_roi};
distance_based_coords = {lh_distance_based_coords ; rh_distance_based_coords};
 
% Initialize the mvpa toolbox subject structure, we will be using this
% structure for creating the cross validation indices and z-scoring the
% patterns

subj = init_subj('test_expriment','test_subject');

% Import the regressor 

conditions_regressor = load("../../Regressors/s103/Cantlon_Regressor_4way_concat.mat");
conditions_regressor = conditions_regressor.Cantlon_Regressor_4way_concat;

% Remove one non-face class to enable having the same amount of face and
% non face blocks per run

conditions_regressor(conditions_regressor == 3) = 0;

% Add the regressor object to the subject structure

subj = initset_object(subj, 'regressors', 'conditions_regressor', conditions_regressor);

% Create the selector 

runs_selector = ones(1, 240);
runs_selector(81:160) = 2;
runs_selector(161:240) = 3;
runs_selector(241:320) = 4;

% Add the selector object to the subject structure

subj = initset_object(subj,'selector','runs_selector', runs_selector); 

% Shift the regressor along a few time points

subj = shift_regressors(subj, 'conditions_regressor', 'runs_selector', 3);

% Access the newly shifted regressor

conditions_regressor = get_mat(subj, 'regressors', 'conditions_regressor_sh3');

% Locate the stimulus blocks in the regressor

blocks = find_blocks(conditions_regressor);

num_blocks = [ 0 0 0 0 ];

% Clean up the regressor, make all blocks contiguous 
% (i.e. 1 0 1 0 1 0 --> 1 1 1 1 1 1)

if contiguous_regressor
    
    conditions_regressor = make_contiguous_regressor(conditions_regressor, blocks);

end


if feature_selection
    
    % Create a binarized version of the conditions regressor for feature
    % selection

    conditions_regressor_bin = binarize_regressor(conditions_regressor);
    
    % Replace the nonbinarized regressor that we have accessed for our
    % classification use outside of the toolbox with the binarized version for
    % the later use of feature selection

    subj = set_mat(subj, 'regressors', 'conditions_regressor_sh3', ...
                                           conditions_regressor_bin);

end    

% Create cross validation indices through the toolbox

subj = create_xvalid_indices(subj,'runs_selector');

% We have to slighlty modify the regressor to be faces vs every other
% condition, where 0 = rest 1 = word, 2 = face, 3 = tool or shape, 4 = number
% to 0 = rest, 1 = nonface, 2 = face

conditions_regressor(conditions_regressor == 3) = 1;
conditions_regressor(conditions_regressor == 4) = 1;

prefixes = {'lh', 'rh', 'combined'};

% Load all data and isolate ROIs for each hemisphere

final_timecourses = {};

for i = 1:2 % for each hemisphere
    
    % Import the patterns

    % Run 1
    surface_activation_reader = MRIread(['combined_1_', prefixes{i}, '.nii']);
    surface_activation = squeeze(surface_activation_reader.vol(1,:,:));

    % Run 2
    surface_activation_reader = MRIread(['combined_2_', prefixes{i}, '.nii']);
    surface_activation = [surface_activation , squeeze(surface_activation_reader.vol(1,:,:))];

    % Run 3
    surface_activation_reader = MRIread(['combined_3_', prefixes{i}, '.nii']);
    surface_activation = [surface_activation , squeeze(surface_activation_reader.vol(1,:,:))];

    % Run 4
    surface_activation_reader = MRIread(['combined_4_', prefixes{i}, '.nii']);
    surface_activation = [surface_activation , squeeze(surface_activation_reader.vol(1,:,:))];
     
    % Add the activity patterns to the subject structure
    subj = init_object(subj,'pattern',['epi_', prefixes{i}]);
    subj = set_mat(subj, 'pattern', ['epi_', prefixes{i}], surface_activation);    
    
    % Z-score the activity patterns for better classification
    subj = zscore_runs(subj,['epi_', prefixes{i}],'runs_selector');
    
    % Access the now z-scored activity patterns
 
    data = get_mat(subj,'pattern', ['epi_', prefixes{i}, '_z']); 
    
    % Initialize the training data vectors

    training_data = ones(1,240);
    training_labels = ones(1,240);

    % Initialize the testing data vectors

    testing_data = ones(1, 80);
    testing_labels = ones(1,80);

    % Select all vertices that are in the ROI, found that the vertices that
    % correspond the center of the FFA for s103 are left: 72350 right: 75507

    [roi, distances_to_center] = select_roi(distance_based_coords{i}, vertex_number(i), distance_threshold);
    
    % Make sure that all of these vertices are in the parcellated region of
    % interest
    
    if remove_not_from_region
    
        roi_code = vertex_to_roi{i}(vertex_number(i)+1);
    
        for j = 1:length(roi)
    
            if vertex_to_roi{i}(roi(j)) ~= roi_code
    
                roi(j) = 0;
    
            end
        end
       
        roi = roi(roi>0);
    end
    
    [value, index] = max(distances_to_center(roi));

    disp([newline 'furthest vertex from ' prefixes{i} ' roi center: ', num2str(roi(index)) newline ])
    
    % Now we will make sure that there are no activations that only have a few
    % vertices, preventing the a few vertices on the edge of our roi leading to
    % the inclusion of a whole nother voxel. 

    timecourses = data(roi, :);
    unique_timecourses = unique(timecourses, 'rows');
    unique_timecourses = [zeros(size(unique_timecourses,1),1), unique_timecourses];

    for j = 1:size(unique_timecourses,1) % for each unique timecourse

        for k = 1:size(timecourses,1) % for each timecourse

            % if the timecourse is found, incriment the counter
            if ~isempty(find(unique_timecourses(j,2:end) == timecourses(k,:)))

                unique_timecourses(j,1) = unique_timecourses(j,1) + 1;

            end
        end
    end

    % First we will store a list of the timecourses that will be removed, then
    % we will go through the actual timecourse data and remove them

    final_timecourses{i} = [];

    for j = 1:size(unique_timecourses,1)

        if unique_timecourses(j,1) >= num_vertices_needed

            final_timecourses{i}= [final_timecourses{i}; unique_timecourses(j,2:end)];

        end
    end
    
    if feature_selection
        
        % Now that we have the final timecourse data for our ROI, we can
        % add the ROI timecourse data for feature selection

        % Make a fake mask of the same size as the data so the toolbox doesn't
        % yell at me
   
        wholevol = make_fake_mask(64, 74, 60, size(final_timecourses{i}, 1));
        
        subj = initset_object(subj,'mask',['final_', prefixes{i}] ,wholevol);
                
        subj = initset_object(subj,'pattern',['epi_', prefixes{i}, '_z_ROI'], ...
                     final_timecourses{i}, 'masked_by', ['final_', prefixes{i}]);
    
        % Perform feature selection
    
        subj = feature_select(subj,['epi_', prefixes{i}, '_z_ROI'], ...
                             'conditions_regressor_sh3','runs_selector_xval');
                         
    end
                     
end


% Now we are going to process the data so that we remove time points
% that are during rest period, and we are going to make sure that there
% is the same amount of face and non face examples in the training data
% and in the testing data.
% 0 = rest, 1 = word, 2 = face, 3 = tool or shape, 4 = number 

% Equalizing training data set (timepoints == 1) and testing data 
% set (timepoints == 2)

% Initialize the classifictaion results vectors

disp('begining classification');

classification_results = ones(1,80);
NB_mvpa_results = zeros(9,5);
classifier_metrics = {};
results_counter = 1;

for rand_select_runs = 1:100 % We will randomly select which runs to keep mulitple times
    
    % Reset the included timepoints array

    timepoints_to_include = ones(1,320);

    % Remove all rest data from training and testing data sets

    timepoints_to_include(conditions_regressor == 0) = 0;

    % Calculate how many blocks of each class are in the data set

    conditions = unique(blocks(:,1))';
    non_face_conditions = conditions(conditions ~= 2);

    for run = 1:4 % for each run 
        
        for cond = conditions % for each condition number

            num_blocks(cond) = size(find(blocks(:,1) == cond & (runs_selector(blocks(:,2)) == run)'), 1);

        end

        % Calculate how many blocks from each non face categroy that should
        % be excluded

        num_blocks_to_erase =  num_blocks(2) - round(num_blocks(2) / (length(num_blocks)-1));

        % Randomly choose which blocks to erase for each category

        for class = non_face_conditions % for each non face class

            % Get the index of all of the blocks in the blocks matrix that
            % are from the nonface class of interest and are in the data
            % set of interest (training / testing)

            block_indices = find(blocks(:,1) == class & (runs_selector(blocks(:,2)) == run)');

            for j = 1:num_blocks_to_erase

                % Ensure that we pick a new and random index at every
                % iteration of removal

                while true

                    block_indices_index = ceil(abs(rand)*length(block_indices));

                    if block_indices(block_indices_index) ~= 0
                        break
                    end
                end

                block_index_to_erase = block_indices(block_indices_index);

                block_indices(block_indices_index) = 0;

                timepoints_to_include(blocks(block_index_to_erase,2):(blocks(block_index_to_erase,2)+5)) = 0;

            end 
        end
    end
 
    

    for hemi = 1:3 % for each hemisphere and the combination
        
        for run = 1:4 % for each set of cross validation indices
            
            % Set the final timecourses to be the the significant voxels
            % determinded from the training data of the current cross
            % validation run
            
            if (hemi == 1 || hemi == 2)
                
                if feature_selection
    
                    stat_map = get_mat(subj,'pattern', ...
                               ['epi_', prefixes{hemi}, '_z_ROI_anova_', int2str(run)]); 
                    
                    final_significant_timecourses{hemi} = final_timecourses{hemi}(stat_map < .05, :);
                    
                else
                    
                     final_significant_timecourses{hemi} = final_timecourses{hemi}; 
                     
                end
            
            else
                
                final_significant_timecourses{hemi} = [final_significant_timecourses{1} ; ...
                                                       final_significant_timecourses{2}];
                
            end

            % Access the timepoints that will be used for training and testing
            % through the cross validation selector generated from MVPA toolbox

            selector_name="runs_selector_xval_"+run;
            selector_name=convertStringsToChars(selector_name);
            timepoints=get_mat(subj,'selector',selector_name);
            
            % Remove all data that we have chosen not to include as it is either
            % during a rest period or was removed to equalize the amount of blocks 
            % in each run 
            timepoints(timepoints_to_include == 0) = 0;


            % Set the training data to the timepoints marked as 1 and testing data
            % to the timepoints marked as 2, the naming scheme of the MVPA
            % toolbox cross validation index generator

            training_data=final_significant_timecourses{hemi}(:,timepoints==1);
            testing_data=final_significant_timecourses{hemi}(:,timepoints==2);
            training_labels=conditions_regressor(timepoints==1);
            testing_labels=conditions_regressor(timepoints==2);
            
            % Remove any patterns in the data
            training_data = zscore(training_data);
            testing_data = zscore(testing_data);

            % Train and test a Naive Bayes classifier

            disp([ newline 'hemisphere ' prefixes{hemi} ' fold: ' num2str(run) ' training with ' num2str(size(training_data,2)) ' time points sampled from ' ...
            num2str(size(training_data,1)) ' voxels' ' testing with ' num2str(size(testing_data,2))  ... 
            ' time points sampled from ' num2str(size(testing_data,1)) ' voxels' newline ])

            nb = fitcnb(training_data',training_labels');
            classification_results=predict(nb,testing_data');
            classification_results=classification_results';
            NB_mvpa_results(results_counter,run)=mean(classification_results==testing_labels);
                        
            % Implement more informative classifier metrics
            
            fnr = length(find(testing_labels == 2 & classification_results == 1)) ... 
                           / length(find(testing_labels == 2))
                       
            fpr = length(find(testing_labels == 1 & classification_results == 2)) ...
                           / length(find(testing_labels == 1))
                                 
            classifier_metrics{results_counter, run} = [fnr, fpr];
            
        end
        
        classifier_metrics{results_counter, run+1} = hemi;
        
        NB_mvpa_results(results_counter, run + 1) = hemi;
        
        
        % incriment the results counter
        results_counter = results_counter + 1;
    end
end 

% Restructure the results

lh_average_accuracy = mean(mean(NB_mvpa_results(NB_mvpa_results(:,5) == 1, 1:4)))

% lh_average_fnr = mean(classifier_metrics{[classifier_metrics{:,5}] == 1});
% 
% lh_average_fpr = mean(NB_mvpa_results(NB_mvpa_results(:,3) == 1, 2));

rh_average_accuracy = mean(mean(NB_mvpa_results(NB_mvpa_results(:,5) == 2, 1:4)))

% rh_average_fnr = mean(NB_mvpa_results(NB_mvpa_results(:,3) == 2, 1));
% 
% rh_average_fpr = mean(NB_mvpa_results(NB_mvpa_results(:,3) == 2, 2));

combined_average_accuracy = mean(mean(NB_mvpa_results(NB_mvpa_results(:,5) == 3, 1:4)))