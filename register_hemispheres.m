% This script will register two surfaces from predefined regions to use, it
% will register with all regions but only the ones requested will be
% returned

% Find the center vertex in the left hemisphere

% Can convert here ! python convert_spherical_coords.py

% TODO:  
% check if files exist and produce them if not, as in the asc surface
% files and then the converted coordinate files         

% set the region code for the interested ROIs to be mapped from surface to
%%% surface. 

coordinates_to_use = [1:75];


% load the vertex to roi mapping

lh_vertex_to_roi = dlmread('SUMA/lh.aparc.a2009s.annot.1D.roi',' ', 1, 0);
rh_vertex_to_roi = dlmread('SUMA/rh.aparc.a2009s.annot.1D.roi', ' ', 1, 0);

lh_vertex_to_roi = lh_vertex_to_roi(:,[1,3]);
rh_vertex_to_roi = rh_vertex_to_roi(:,[1,3]);

% Determine the list of unique region codes

region_codes = unique(lh_vertex_to_roi(:,2)); 

% load all 1 indexed vertex coordinates

lh_all_vertex_coords = dlmread('surf/lh.sphere.reg.asc',' ', 2, 0);
rh_all_vertex_coords = dlmread('surf/rh.sphere.reg.asc',' ', 2, 0);

%fix the formatting due to the file using two spaces as the delimeter

lh_all_vertex_coords = [lh_all_vertex_coords(:,1) lh_all_vertex_coords(:,3) ...
                                      lh_all_vertex_coords(:,5)];

rh_all_vertex_coords = [rh_all_vertex_coords(:,1) rh_all_vertex_coords(:,3) ...
                                      rh_all_vertex_coords(:,5)];                                      
                                      
% Remove the faces information, we are only interested in vertices

lh_all_vertex_coords = lh_all_vertex_coords(lh_all_vertex_coords(:,3) ~= 0, :);
rh_all_vertex_coords = rh_all_vertex_coords(rh_all_vertex_coords(:,3) ~= 0, :);

% Initialize refernce vertex lists

lh_reference_vertices = ones(1,length(region_codes));
rh_reference_vertices = ones(1,length(region_codes));

% Initialize reference vertex coordinate lists

lh_reference_vertex_coords = ones(3,3);
rh_reference_vertex_coords = ones(3,3);

 for i = 1:length(region_codes)
    
    % Select the 0 indexed vertex numbers that are in the current region

    lh_region = lh_vertex_to_roi(lh_vertex_to_roi(:,2) == region_codes(i), 1);
    rh_region = rh_vertex_to_roi(rh_vertex_to_roi(:,2) == region_codes(i), 1);

    % Isolate the coordinates of the vertices in the current region
    
    lh_region_coords = lh_all_vertex_coords(lh_region+1, :);
    rh_region_coords = rh_all_vertex_coords(rh_region+1, :);

    % Average all vertex vectors in current region to find center
    % 1 indexed vertex index of the average point of the surface
    
    lh_reference_vertex_coords(i, :) = mean(lh_region_coords);
    rh_reference_vertex_coords(i, :) = mean(rh_region_coords);

    % Finally, retrieve the vertex number of the vector
    
    lh_reference_vertices(i) = get_vertex_number_from_coord(lh_all_vertex_coords, ...
                                                    lh_reference_vertex_coords(i,:));
    rh_reference_vertices(i) = get_vertex_number_from_coord(rh_all_vertex_coords, ...
                                                    rh_reference_vertex_coords(i,:));
 end

 form_new_coordinates_from_reference_points

% Code graveyard

%convert to spherical coordinates for easier handling
%[azimuth, elevation] = cart2sph(lh_all_vertex_coords(:, 1), ...
%                          lh_all_vertex_coords(:,2), lh_all_vertex_coords(:,3));
                       
%lh_all_vertex_coords = [azimuth, elevation];