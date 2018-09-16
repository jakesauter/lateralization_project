% The distance threshold for grabbing the relevant ROIs. This should be
% slightly smaller than the distance threshold given for the searchlight
% analysis as some voxels are excluded in the analysis

distance_threshold = .045;

% The annotation files for both hemispheres, these will be used as starting
% blocks for writing to our own annotation files.

lh_annotation_file = 'label/lh.aparc.annot';

rh_annotation_file = 'label/rh.aparc.annot';

results_file_name = 'searchlight_results.txt';

[lh_vertices,label,colortable]=read_annotation(lh_annotation_file);

[rh_vertices,label,colortable]=read_annotation(rh_annotation_file);

colortable.table(1:10, 1:4) = [20,  47,  189, 0;
                               19,  114, 188, 0;
                               19,  181, 187, 0;
                               18,  187, 126, 0; 
                               18,  186, 58,  0;
                               111, 185, 17,  0;
                               178, 184, 17,  0;
                               184, 123, 16,  0;
                               183, 56,  16,  0;
                               183, 15,  43,  0];


% Would want this if we were doing colors other than red
colortable.table(:,5) = colortable.table(:,1) + (colortable.table(:,2) * (2^8)) + (colortable.table(:,3)*(2^16)) + (colortable.table(:,4)*(2^24));

results = dlmread(results_file_name);

register_hemispheres

% This will store the acc sum and the amount of ROIs that the vertex was
% contained in

lh_acc_sum = zeros(size(lh_distance_based_coords,1),2);

rh_acc_sum = zeros(size(rh_distance_based_coords,1),2);

% average_combined_acc used to produce bar graph figure for poster

lh_combined_acc_sum = zeros(size(lh_distance_based_coords,1),2);

for i = 1:size(results,1)
    
    i

    [roi, distances_to_center] = select_roi(lh_distance_based_coords, results(i,1), distance_threshold);

    lh_acc_sum(roi,1) = lh_acc_sum(roi,1) + results(i,3);
    
    lh_acc_sum(roi,2) = lh_acc_sum(roi,2) + 1;
    
    lh_combined_acc_sum(roi,1) = lh_combined_acc_sum(roi,1) + results(i,5);
    
    lh_combined_acc_sum(roi,2) = lh_combined_acc_sum(roi,2) + 1;
        
    [roi, distances_to_center] = select_roi(rh_distance_based_coords, results(i,2), distance_threshold);
    
    rh_acc_sum(roi,1) = rh_acc_sum(roi,1) + results(i,4);
    
    rh_acc_sum(roi,2) = rh_acc_sum(roi,2) + 1;

end

lh_average_acc = lh_acc_sum(:,1) ./ lh_acc_sum(:,2);

lh_combined_average_acc = lh_combined_acc_sum(:,1) ./ lh_combined_acc_sum(:,2);

rh_average_acc = rh_acc_sum(:,1) ./ rh_acc_sum(:,2);

lh_average_acc(isnan(lh_average_acc)) = 1;

rh_average_acc(isnan(rh_average_acc)) = 1;
                      
% Scale to color scale

min_val_lh = min(lh_average_acc);

min_val_rh = min(rh_average_acc);

min_val = min(min_val_lh, min_val_rh);

max_val_lh = max(lh_average_acc);

max_val_rh = max(rh_average_acc);

max_val = max(max_val_lh, max_val_rh);

lh_vertex_labels = round(10 .* ((lh_average_acc - min_val) / (max_val - min_val)));

rh_vertex_labels = round(10 .* ((rh_average_acc - min_val) / (max_val - min_val)));

lh_vertex_labels(lh_vertex_labels == 0) = 1;

rh_vertex_labels(rh_vertex_labels == 0) = 1;

lh_vertex_labels = colortable.table(lh_vertex_labels, 5);

rh_vertex_labels = colortable.table(rh_vertex_labels, 5);

% Write the heat maps to annotation files that can be visualized through
% tksurfer

write_annotation('label/lh.acc_heat_map.annot', lh_vertices,lh_vertex_labels,colortable);

write_annotation('label/rh.acc_heat_map.annot', rh_vertices,rh_vertex_labels,colortable);