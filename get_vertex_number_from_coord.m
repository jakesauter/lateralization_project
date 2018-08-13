function [ vertex_number ] = get_vertex_number_from_coord(vertex_coord_list, vertex_coords)
    % This function will server as a method to return the vertex that is the
    % closest to a given spherical coordinate. Arguments 1 is the list of
    % vertex coordinates (correlated to vertex number through index). Argument
    % 2 is a list containing the spherical coordinates (rho and phi) for the
    % desired 1-INDEXED vertex. A 0-INDEXED VERTEX INDEX WILL BE RETETURNED
    
    % This can be accomplished by creating a parallel cost array (being the
    % distance of the parallel vertex coordinates to the desired coodinate,
    % then selecting the vertex with th minimum cost
       
    %[val vertex_number] = min(abs(vertex_coord_list(:,1) - vertex_coords(1)) + ...
    %                abs(vertex_coord_list(:,2) - vertex_coords(2)) + ...
    %                abs(vertex_coord_list(:,3) - vertex_coords(3)));
    
   
    cost  = zeros(size(vertex_coord_list, 1), 1);
    
    for i = 1: length(vertex_coords)
                
         cost = cost + abs(vertex_coord_list(:,i) - vertex_coords(i));
                
    end
    
    [val vertex_number] = min(cost);
    
    vertex_number = vertex_number - 1;
end
                
     