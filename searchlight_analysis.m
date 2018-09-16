% This script will perform MVPA analysis on a given ROI for the left and
% right hemisphere, and has many options, including 

% Output files that this program will write to, make sure to have different
% file names if multiple instances will be running concurrently and to not
% overwrite results files of other analyses

results_file_name = 'searchlight_results.txt';

timecourses_file_name = 'timecourses.txt'; 

run_config_file_name = 'run_configurations.txt';

persistence = false;

% When verbose = true prints size of training and teseting set on every
% classification iteration

verbose = false;

% The percentile of distance of vertices that will be included

distance_threshold = .05;

% The minimum number of vertices that must be in a selected region that are
% in the same voxel in order for the voxel's timecourse data to be included
% in the analysis

num_vertices_needed = 5;

% When true, all blocks are set to be contigous as opposed to spaced out
% due to questioning being done during the study 
% (i.e. 1 0 1 0 1 0 --> 1 1 1 1 1 1)

contiguous_regressor = true;

% When true, removes all vertices not in the same labelled parecellation of
% the region of interest.

remove_not_from_region = false;

% Register the hemispheres of the subject that we are analyzing

register_hemispheres;

% vertex_to_roi = {lh_vertex_to_roi, rh_vertex_to_roi};

distance_based_coords = {lh_distance_based_coords ; rh_distance_based_coords};

% Initialize the mvpa toolbox subject structure, we will be using this
% structure for creating the cross validation indices and z-scoring the
% patterns

subj = init_subj('test_expriment','test_subject');

% Import the regressor 

subject_name = pwd;
subject_name = subject_name(end-3:end);

conditions_regressor = load(['../../Regressors/' subject_name '/Cantlon_Regressor_4way_concat.mat']);
conditions_regressor = conditions_regressor.Cantlon_Regressor_4way_concat;

% Remove one non-face class to enable having the same amount of face and
% non face blocks per run

conditions_regressor(conditions_regressor == 3) = 0;

% Add the regressor object to the subject structure

subj = initset_object(subj, 'regressors', 'conditions_regressor', conditions_regressor);

% Create the selector 

runs_selector = ones(1, 320);
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

% Create cross validation indices through the toolbox

subj = create_xvalid_indices(subj,'runs_selector');

% We have to slighlty modify the regressor to be faces vs every other
% condition, where 0 = rest 1 = word, 2 = face, 3 = tool or shape, 4 = number
% to 0 = rest, 1 = nonface, 2 = face

conditions_regressor(conditions_regressor == 3) = 1;
conditions_regressor(conditions_regressor == 4) = 1;

prefixes = {'lh', 'rh', 'combined'};

% Load all data and isolate ROIs for each hemisphere

data = {};


for hemi = 1:2 % for each hemisphere

    % Import the patterns

    % Run 1
    surface_activation_reader = MRIread(['combined_1_', prefixes{hemi}, '.nii']);
    surface_activation = squeeze(surface_activation_reader.vol(1,:,:));

    % Run 2
    surface_activation_reader = MRIread(['combined_2_', prefixes{hemi}, '.nii']);
    surface_activation = [surface_activation , squeeze(surface_activation_reader.vol(1,:,:))];

    % Run 3
    surface_activation_reader = MRIread(['combined_3_', prefixes{hemi}, '.nii']);
    surface_activation = [surface_activation , squeeze(surface_activation_reader.vol(1,:,:))];
    
     % Run 4
    surface_activation_reader = MRIread(['combined_4_', prefixes{hemi}, '.nii']);
    surface_activation = [surface_activation , squeeze(surface_activation_reader.vol(1,:,:))];


    % Add the activity patterns to the subject structure
    subj = init_object(subj,'pattern',['epi_', prefixes{hemi}]);
    subj = set_mat(subj, 'pattern', ['epi_', prefixes{hemi}], surface_activation);    

    % Z-score the activity patterns for better classification
    subj = zscore_runs(subj,['epi_', prefixes{hemi}],'runs_selector');

    % Access the now z-scored activity patterns

    data{hemi} = get_mat(subj,'pattern', ['epi_', prefixes{hemi}, '_z']); 

    % Initialize the training data vectors

    training_data = ones(1,240);
    training_labels = ones(1,240);

    % Initialize the testing data vectors

    testing_data = ones(1, 80);
    testing_labels = ones(1,80);
end

% Load the current program state from file if exists

if persistence

    if exist(timecourses_file_name, 'file') == 2

       selected_timecourses = dlmread(timecourses_file_name);

    else

       selected_timecourses = [];

    end

    if exist(results_file_name, 'file') == 2

       searchlight_results = dlmread(results_file_name);
       searchlight_results_counter = size(searchlight_results, 1)+1;

    else

       searchlight_results = [];
       searchlight_results_counter = 1;

    end
    
    if exist(run_config_file_name, 'file') == 2

       run_configurations = dlmread(run_config_file_name);

    else

      run_configurations = get_run_configurations(10, blocks, runs_selector, conditions_regressor);

    end
    
else
    
    selected_timecourses = [];
      
    searchlight_results = [];
    searchlight_results_counter = 1;
      
    run_configurations = get_run_configurations(10, blocks, runs_selector, conditions_regressor);
    
end
    
total_number_of_timecourses = size(unique(surface_activation ,'rows'), 1);

vertex_number = [1,1];

% Select all of the unique timecourse data from the surface activation
% matrix, NOTE: we can use just the surface activation from the rh
% hemisphere here because we are only using this to choose the center
% of the ROI

while size(selected_timecourses, 1) < total_number_of_timecourses

    % Randomly select a vertex and make sure that its timecourse has
    % not been used as a center vertex before, if it has, choose again
    % until we select a vertex with a completely new timecourse to our
    % analysis

    while true

        vertex_index = ceil(abs(rand()) * size(surface_activation,1));

        vertex_timecourse = surface_activation(vertex_index, :);

        found = false;
        
        for j = 1:size(selected_timecourses) % for each selected timecourse
            
            % disp(['comparing with selected timecourse ' num2str(j)])

            % if the timecourse is found, set the found variable to
            % true
            if isequal(selected_timecourses(j,1:10), vertex_timecourse(1:10))

                found = true;
                
            end
        end
        
        if ~found

            break

        end
    end
    
    selected_timecourses = [selected_timecourses ; vertex_timecourse(1:10)];
    
    vertex_number(2) = vertex_index-1;

    % Now that we have the vertex at the center of the ROI for the
    % right hemisphere, we will find the corresponding vertex on the
    % left hemisphere

    vertex_number(1) = get_vertex_number_from_coord(lh_distance_based_coords(:,coordinates_to_use) ...
        , rh_distance_based_coords(vertex_number(2)+1,coordinates_to_use));
   

    % Select all vertices that are in the ROI, found that the vertices that
    % correspond the center of the FFA for s103 are left: 72350 right: 75507
    
    final_timecourses = {[],[]};

    for hemi = 1:2 % Select the ROI and define the final timecourses for each hemisphere
        
        disp(['Selecting ROI in ' prefixes{hemi}])

        [roi, distances_to_center] = select_roi(distance_based_coords{hemi}, vertex_number(hemi), distance_threshold);

        % Make sure that all of these vertices are in the parcellated region of
        % interest

        if remove_not_from_region

            roi_code = vertex_to_roi{hemi}(vertex_number(hemi)+1);

            for j = 1:length(roi)

                if vertex_to_roi{hemi}(roi(j)) ~= roi_code

                    roi(j) = 0;

                end
            end

            roi = roi(roi>0);
        end

        [value, index] = max(distances_to_center(roi));

        % Now we will make sure that there are no activations that only have a few
        % vertices, preventing the a few vertices on the edge of our roi leading to
        % the inclusion of a whole nother voxel. 

        timecourses = data{hemi}(roi, :);
        unique_roi_timecourses = unique(timecourses, 'rows');
        unique_roi_timecourses = [zeros(size(unique_roi_timecourses,1),1), unique_roi_timecourses];
        
        disp(['Refining ROI data from ' num2str(size(unique_roi_timecourses, 1)) ' voxels'])

        for j = 1:size(unique_roi_timecourses,1) % for each unique timecourse

            for k = 1:size(timecourses,1) % for each timecourse

                % if the timecourse is found, incriment the counter
                if ~isempty(find(unique_roi_timecourses(j,2:end) == timecourses(k,:)))

                    unique_roi_timecourses(j,1) = unique_roi_timecourses(j,1) + 1;

                end
            end
        end
        
        % Remove all timecourses that do not have the neccesary number of
        % vertices
        
        for j = 1:size(unique_roi_timecourses,1)

            if unique_roi_timecourses(j,1) > num_vertices_needed

                final_timecourses{hemi}= [final_timecourses{hemi}; unique_roi_timecourses(j,:)];

            end
        end
        
        disp(['After removing low vertex count voxels, ' num2str(size(final_timecourses{hemi}, 1))...
                                  ' voxels remain'])
        
    end
    
    disp(['Balancing ROI voxel size of ' num2str(size(final_timecourses{1},1)) ' voxels and '...
                                num2str(size(final_timecourses{2},1)) ' voxels'])
    
    % Now that we have the final timecourses for each ROI, we can balance
    % the amount of voxels in each ROI
    
    num_voxels_to_keep = min(size(final_timecourses{1},1), ...
                             size(final_timecourses{2},1));

    for hemi = 1:2
       
        while size(final_timecourses{hemi},1) ~= num_voxels_to_keep
           
           % find an index of a time course with the minimum amount of
           % vertices representing it
           
           [val index] = min(final_timecourses{hemi}(:,1));
           
           final_timecourses{hemi} = [final_timecourses{hemi}(1:(index-1), :) ...
                                     ; final_timecourses{hemi}((index+1):end, :)]; 
            
        end
                
    end
    
    disp(['ROI balanced with '  num2str(size(final_timecourses{1},1)) ' voxels and ' ...
         num2str(size(final_timecourses{1},1)) ' voxels'])
    


    % Initialize the classifictaion results vectors

    classification_results = ones(1,80);
    NB_mvpa_results = zeros(3000,5);
    classifier_metrics = {};
    results_counter = 1;


    for select_runs = 1:10 % Run through 10 preset run configurations

        % Select the runs to include in the current iteration

        timepoints_to_include = run_configurations(select_runs, :);

        for hemi = 1:3 % for each hemisphere and the combination

            for run = 1:4 % for each set of cross validation indices

                % Combine voxel data on third run for a joint analysis

                if ~(hemi == 1 || hemi == 2)
                    
                    final_timecourses{hemi} = [final_timecourses{1} ; ...
                                                final_timecourses{2}];

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

                % +1 offset needed because first index of final timecourses
                % is the amount of vertices representing that time course
                stripped_timecourse_data = final_timecourses{hemi}(:,2:end);
                
                training_data=stripped_timecourse_data(:,timepoints==1);
                testing_data=stripped_timecourse_data(:,timepoints==2);
                training_labels=conditions_regressor(timepoints==1);
                testing_labels=conditions_regressor(timepoints==2);
                
                % Remove any patterns in the data
                training_data = zscore(training_data);
                testing_data = zscore(testing_data);

                if verbose

                disp([ newline 'hemisphere ' prefixes{hemi} ' fold: ' num2str(run) ' training with ' num2str(size(training_data,2)) ' time points sampled from ' ...
                num2str(size(training_data,1)) ' voxels' ' testing with ' num2str(size(testing_data,2))  ... 
                ' time points sampled from ' num2str(size(testing_data,1)) ' voxels' newline ])

                end
                
                % Train and test a Naive Bayes classifier

                nb = fitcnb(training_data',training_labels');
                classification_results=predict(nb,testing_data');
                classification_results=classification_results';
                NB_mvpa_results(results_counter,run)=mean(classification_results==testing_labels);

                % Implement more informative classifier metrics

                fnr = length(find(testing_labels == 2 & classification_results == 1)) ... 
                               / length(find(testing_labels == 2));

                fpr = length(find(testing_labels == 1 & classification_results == 2)) ...
                               / length(find(testing_labels == 1));

                classifier_metrics{results_counter, run} = [fnr, fpr];

            end

            classifier_metrics{results_counter, run+1} = hemi;

            NB_mvpa_results(results_counter, run + 1) = hemi;

            % incriment the results counter
            results_counter = results_counter + 1;
        end
    end 

    % Restructure the results

    lh_average_accuracy = mean(mean(NB_mvpa_results(NB_mvpa_results(:,5) == 1, 1:4)));

    % lh_average_fnr = mean(classifier_metrics{[classifier_metrics{:,5}] == 1});
    % 
    % lh_average_fpr = mean(NB_mvpa_results(NB_mvpa_results(:,3) == 1, 2));

    rh_average_accuracy = mean(mean(NB_mvpa_results(NB_mvpa_results(:,5) == 2, 1:4)));

    % rh_average_fnr = mean(NB_mvpa_results(NB_mvpa_results(:,3) == 2, 1));
    % 
    % rh_average_fpr = mean(NB_mvpa_results(NB_mvpa_results(:,3) == 2, 2));

    combined_average_accuracy = mean(mean(NB_mvpa_results(NB_mvpa_results(:,5) == 3, 1:4)));

    searchlight_results(searchlight_results_counter, :) = [vertex_number(1), vertex_number(2), ...
        lh_average_accuracy, rh_average_accuracy, combined_average_accuracy];
    
    % Only after succesful results from ROI have been recovered do we add
    % the timecourse and vertices to the selected lists
    
    searchlight_results_counter = searchlight_results_counter + 1;
    
    
    if persistence & mod(searchlight_results_counter, 200) == 0

        dlmwrite(results_file_name,searchlight_results, 'precision', 6);

        dlmwrite(timecourses_file_name, selected_timecourses, 'precision', 20); 

        dlmwrite(run_config_file_name, run_configurations);
        
    end

    disp([ '---------------- FINISHED ONE ITERATION --------------' num2str(searchlight_results_counter)])

end

dlmwrite(results_file_name,searchlight_results, 'precision', 6);

dlmwrite(timecourses_file_name, selected_timecourses, 'precision', 20); 

dlmwrite(run_config_file_name, run_configurations);

% Code graveyard

%         % Now we will define the coordinates that we are interested in for
    %         % the locally based coordinates to locate the vertex on the other
    %         % hemisphere
    %         
    %                     nearest_vertices = select_roi(rh_distance_based_coords, vertex_number(2), .2);
    %                     
    %                     nearest_rois = unique(rh_vertex_to_roi(nearest_vertices,2));
    %                     
    %                     current_roi = rh_vertex_to_roi(rh_vertex_to_roi(:,1) == vertex_number(2), 2);
    %                     
    %                     nearest_rois = nearest_rois(nearest_rois ~= current_roi);
    %                     
    %                     nearest_rois_coordinate_indices = zeros(1, length(nearest_rois));
    %                     
    %                     
    %                     for roi_index = 1:length(nearest_rois)
    %                        
    %                         nearest_rois_coordinate_indices(roi_index) = ...
    %                                     find(nearest_rois(roi_index) == region_codes);
    %                         
    %                     end
    %                     
    %                             vertex_number(1) = get_vertex_number_from_coord(lh_distance_based_coords(:, nearest_rois_coordinate_indices) ...
    %                , rh_distance_based_coords(vertex_number(2), nearest_rois_coordinate_indices));

    %         if feature_selection
    % 
    %         % Create a binarized version of the conditions regressor for feature
    %         % selection
    % 
    %         conditions_regressor_bin = binarize_regressor(conditions_regressor);
    % 
    %         % Replace the nonbinarized regressor that we have accessed for our
    %         % classification use outside of the toolbox with the binarized version for
    %         % the later use of feature selection
    % 
    %         subj = set_mat(subj, 'regressors', 'conditions_regressor_sh3', ...
    %                                                conditions_regressor_bin);
    % 
    %         end    

    %         if feature_selection
    % 
    %                 % Now that we have the final timecourse data for our ROI, we can
    %                 % add the ROI timecourse data for feature selection
    % 
    %                 % Make a fake mask of the same size as the data so the toolbox doesn't
    %                 % yell at me
    % 
    %                 wholevol = make_fake_mask(64, 74, 60, size(final_timecourses{hemi}, 1));
    % 
    %                 subj = initset_object(subj,'mask',['final_', prefixes{hemi}] ,wholevol);
    % 
    %                 subj = initset_object(subj,'pattern',['epi_', prefixes{hemi}, '_z_ROI'], ...
    %                              final_timecourses{hemi}, 'masked_by', ['final_', prefixes{hemi}]);
    % 
    %                 % Perform feature selection
    % 
    %                 subj = feature_select(subj,['epi_', prefixes{hemi}, '_z_ROI'], ...
    %                                      'conditions_regressor_sh3','runs_selector_xval');
    % 
    %             end
