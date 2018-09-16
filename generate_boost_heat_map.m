distance_threshold = .045;

initial_label_file_name = 'label/lh.aparc.annot';

results_file_name = 'searchlight_results.txt';

output_file_name = 'label/lh.boost_heat_map.annot';

[lh_vertices,label,colortable]=read_annotation(initial_label_file_name);

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

boost_sum = zeros(size(lh_distance_based_coords,1),2);

% Add a boost column to results

results(:,6) = results(:,5) - max(results(:,3), results(:,4));

% Add average single roi accuracy column to results

results(:,7) = (results(:,3) + results(:,4))/2;

% Grab only the results that the average accuracy was already about .55

% results(results(:,7) < .6, 6) = min(results(:,6));

for i = 1:size(results,1)
    
    i

    [roi, distances_to_center] = select_roi(lh_distance_based_coords, results(i,1), distance_threshold);
   
    boost_sum(roi,1) = boost_sum(roi,1) + results(i,6);
                                    
    boost_sum(roi,2) = boost_sum(roi,2) + 1;
    
end


% Calculate the average boost of each region

average_boost = boost_sum(:,1) ./ boost_sum(:,2);

average_boost(isnan(average_boost)) = min(average_boost);


% Scale to color scale

min_val = min(average_boost);

max_val = max(average_boost);

lh_boost_vertex_labels = round(10 .* ((average_boost - min_val) / (max_val - min_val)));

lh_boost_vertex_labels(lh_boost_vertex_labels == 0) = 1;

lh_boost_vertex_labels = colortable.table(lh_boost_vertex_labels, 5);
    
write_annotation(output_file_name, lh_vertices,lh_boost_vertex_labels,colortable);