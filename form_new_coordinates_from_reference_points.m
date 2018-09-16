% This script will serve to form a new coordinate system on each surface
% defined by the distance from 3 reference points.

% Redefine the coordinate of every vertex as the distance from the referece
% vertices (coordinates of the reference vertices)

% Access the coordinates of the actual reference vertices, as before they
% were the coordinates of the average of the regions, and a vertex may not
% exist at this coordinate

lh_distance_based_coords = ones(size(lh_all_vertex_coords, 1), ...
                                    length(lh_reference_vertices));

rh_distance_based_coords = ones(size(rh_all_vertex_coords, 1), ...
                                    length(rh_reference_vertices));
                                
for i = 1:length(lh_reference_vertices)                            

    lh_distance_based_coords(:,i) = sqrt(((lh_all_vertex_coords(:,1) - lh_reference_vertex_coords(i,1)) .^2) ... 
                                      + ((lh_all_vertex_coords(:,2) - lh_reference_vertex_coords(i,2)) .^2) ... 
                                      + ((lh_all_vertex_coords(:,3) - lh_reference_vertex_coords(i,3)) .^2));
                                  
    rh_distance_based_coords(:,i) = sqrt(((rh_all_vertex_coords(:,1) - rh_reference_vertex_coords(i,1)) .^2) ... 
                                      + ((rh_all_vertex_coords(:,2) - rh_reference_vertex_coords(i,2)) .^2) ... 
                                      + ((rh_all_vertex_coords(:,3) - rh_reference_vertex_coords(i,3)) .^2));

end

% Code graveyard

% IT MIGHT BE BETTER TO NOT DO THIS

    %lh_reference_vertex_coords = lh_all_vertex_coords(lh_reference_vertices, :);
    %rh_reference_vertex_coords = rh_all_vertex_coords(rh_reference_vertices, :);