% This file is a function to select an ROI given a vertex number and 
% distance in talairach space.There will be a higher level function that calls
% this function with either pre-set meta parameters or a method of 
% determining ROI size.

function [ vertex_list , distance_to_center ] = select_roi( coordinate_system, vertex_number, distance_threshold )
    % SELECT_ROI Selects an ROI given a list of coordinates for each
    % vertex, the 0 indexed vertex number of the vertex that will serve 
    % as the center of the ROI, and the distance from this vertex that will
    % be included in the ROI. A list of 1 indexed vertices that are 
    % contained in the ROI are returned
    
    % First we need to access the specific coordindats of the vertex 
    % that will be the center of the ROI
    
    center_vertex_coords = coordinate_system(vertex_number+1,:);
       
    % Now we need to calculate the distance from this vertex to every
    % other vertex 
    
    distance_to_center = zeros(size(coordinate_system, 1), 1);

    for i = 1:length(center_vertex_coords) %for each dimension

        distance_to_center = distance_to_center + abs(coordinate_system(:,i) - center_vertex_coords(i)); 

    end
        
    % Now we can produce a list of vertex indices that are equal to or
    % under the distance threshold 
    
    distance_threshold = max(distance_to_center) * distance_threshold;

    vertex_list = find((distance_to_center <= distance_threshold));
         
 end