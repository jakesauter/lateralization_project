% This script was used to make the figure for my poster in which one ROI is
% correlated

lh_vertex_number = 52273;

rh_vertex_number = 43937;


distance_threshold = .05;

[lh_vertices,lh_labels,colortable]=read_annotation('label/lh.aparc.a2009s.annot');

[rh_vertices,rh_labels,colortable]=read_annotation('label/rh.aparc.a2009s.annot');


% Would want this if we were doing colors other than red
    % colortable.table(:,5) = colortable.table(:,1) + (colortable.table(:,2) * (2^8)) + (colortable.table(:,3)*(2^16)) + (colortable.table(:,4)*(2^24));

register_hemispheres

% rh_vertex_number = get_vertex_number_from_coord(rh_distance_based_coords, lh_distance_based_coords(lh_vertex_number + 1, :));

% Only display the parcellations around the ROI

[lh_roi, distances_to_center] = select_roi(lh_distance_based_coords, lh_vertex_number, distance_threshold*2);

[rh_roi, distances_to_center] = select_roi(rh_distance_based_coords, rh_vertex_number, distance_threshold*2);

lh_labels(~ismember(lh_labels, lh_labels(lh_roi))) = 0;

rh_labels(~ismember(rh_labels, rh_labels(rh_roi))) = 0;



% This will store the acc sum and the amount of ROIs that the vertex was
% contained in

[lh_roi, distances_to_center] = select_roi(lh_distance_based_coords, lh_vertex_number, distance_threshold);

[rh_roi, distances_to_center] = select_roi(rh_distance_based_coords, rh_vertex_number, distance_threshold);

lh_labels(lh_roi) = 255;

rh_labels(rh_roi) = 255;
                    
write_annotation('label/lh.figure.annot', lh_vertices,lh_labels,colortable);

write_annotation('label/rh.figure.annot', rh_vertices,rh_labels,colortable);

