% this file will determine the proportional distance in each direction
% (column, row, slice) that a given voxel is with respect to active
% (non-zero) voxels

%this file should be run within the subject's directory (ex: s103)

function [] = proportional_volume_location(crs)

    subj = init_subj('test_experiment', 'test_subject');

    whole_vol_mask = ones(64, 74, 60);

    subj = initset_object(subj,'mask','whole_vol',whole_vol_mask);

    subj = load_afni_pattern(subj,'epi','whole_vol', '../../Functional_Data/s103/pb05.s103.r02.empty+orig.BRIK');

    data = get_mat(subj, 'pattern', 'epi');

    full_data = zeros(size(whole_vol_mask));

    % Accessing the functional data for all voxels in original geometric 
    % relation at time point 1
    
    full_data(find(whole_vol_mask)) = data(:,1);
    
    %find proportionality in location with respect to column
        
    pro_col = crs(1) / length(find(full_data(:, crs(2), crs(3))));
    
    %find proportionality in location with respect to row

    pro_row = crs(2) / length(find(full_data(crs(1), :, crs(3))));
    
    %find proportionality in location with respect to slice
    
    pro_slice = crs(3) / length(find(full_data(crs(1), crs(2), :)));
    
    ['col: ', string(pro_col), ' row: ', string(pro_row), ' slice: ', string(pro_slice)]