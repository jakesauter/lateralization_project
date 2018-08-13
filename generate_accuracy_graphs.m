% This script will be used to generate the three bar graphs needed for my
% poster, it will graph the average accuracy in three regions, being the
% FFA, the Fusiform and the Somatosenory cortex

% For the FFA and the Somatosensory cortex, we will be grabbing an ROI from
% using the center vertex of the FFA and Somatosensory regions. These
% vertices were determined by using select_talairach_point in tksurfer with
% the predefined talairach points for these regions cited in the literature

% FFA right: 39 ± 3, –40 ±7, –16 ± 5; (42.65 -46.68 -15.96 )left: –37 ± 4, –42 ± 7, –16 ± 5
% (-42.96 -46.40 -21.88 within bounds and shown functionally to be ffa)

% left -51.16 

% Somatosenory right: 51, -27, 45; left: -42, -21, 54

lh_ffa_center_vertex = 80968; 

rh_ffa_center_vertex = get_vertex_number_from_coord(rh_distance_based_coords, lh_distance_based_coords(lh_ffa_center_vertex, :)); %73733;

%lh_ffa_center_vertex = get_vertex_number_from_coord(rh_distance_based_coords, ....
%                lh_distance_based_coords(rh_ffa_center_vertex + 1, :));

lh_somato_center_vertex = 58487; 

rh_somato_center_vertex = 54287;

% Select the ROIs for the FFA and Somatosensory

register_hemispheres;

[lh_ffa_roi, distances_to_center] = select_roi(lh_distance_based_coords, ...
                                          lh_ffa_center_vertex, .05);
                                      
[rh_ffa_roi, distances_to_center] = select_roi(rh_distance_based_coords, ...
                                          rh_ffa_center_vertex, .05);
                                      
[lh_somato_roi, distances_to_center] = select_roi(lh_distance_based_coords, ...
                                          lh_somato_center_vertex, .05);

[rh_somato_roi, distances_to_center] = select_roi(rh_distance_based_coords, ...
                                          rh_somato_center_vertex, .05);                                      

% The Fusiform will be defined by all of the vertices that have the same
% color code as the vertices that have been preselected to be known to be
% in the fusiform

lh_fusiform_vertex = 79571;

rh_fusiform_vertex = 66691;

% Load in the annotation that denotes the fusiform

[lh_vertices,lh_labels,colortable]=read_annotation('label/lh.aparc.a2009s.annot');

[rh_vertices,rh_labels,colortable]=read_annotation('label/rh.aparc.a2009s.annot');

% Select all vertices that have the same color as the fusiform

lh_fusiform_roi = find(lh_labels(lh_labels == lh_labels(lh_fusiform_vertex+1)));

rh_fusiform_roi = find(rh_labels(rh_labels == rh_labels(rh_fusiform_vertex+1)));

% Now that we have our ROIs for each interested region, we can process the
% results, we would have to do just about the same thing done in the generate
% accuracy heat maps script, so we will make sure to run that script first
% so we can use the resulting lh_average_acc and rh_average_acc matrices,
% which contains the average accuracy for each vertex

lh_ffa_acc = mean(lh_average_acc(lh_ffa_roi));

rh_ffa_acc = mean(rh_average_acc(rh_ffa_roi));

combined_ffa_acc = mean(lh_combined_average_acc(lh_ffa_roi));

lh_fusiform_acc = mean(lh_average_acc(lh_fusiform_roi));

rh_fusiform_acc = mean(rh_average_acc(rh_fusiform_roi));

combined_fusiform_acc = mean(lh_combined_average_acc(lh_fusiform_roi));

lh_somato_acc = mean(lh_average_acc(lh_somato_roi));

rh_somato_acc = mean(rh_average_acc(rh_somato_roi));

combined_somato_acc = mean(lh_combined_average_acc(lh_somato_roi));

% Now plot the results on bar graphs

bar([[lh_ffa_acc rh_ffa_acc combined_ffa_acc]-.3; [lh_fusiform_acc rh_fusiform_acc combined_fusiform_acc]-.3; ...
      [lh_somato_acc rh_somato_acc combined_somato_acc]-.3], .4)
  
legend('left', 'right', 'combined');

figure

ffa_boost = combined_ffa_acc - max(lh_ffa_acc, rh_ffa_acc);

fusiform_boost = combined_fusiform_acc - max(lh_fusiform_acc, rh_fusiform_acc);

somato_boost = combined_somato_acc - max(lh_somato_acc, rh_somato_acc);

bar([ffa_boost, fusiform_boost, somato_boost], .4)