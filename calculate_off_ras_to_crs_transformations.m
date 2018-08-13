% This script will be used to calculate the percentage of transformations
% from vertices to voxels that are correct / incorrect. The correctness of
% the mapping is determined by the vertex and the voxel having the same
% fucntional timecourse data

% Map the functional data onto the surface
% ! tkregister2 --s s103 --targ mri/orig.mgz --mov ../../Functional_Data/s103/pb05.s103.r02.empty+orig.BRIK --regheader --reg register.dat          
% ! mri_vol2surf --src ../../Functional_Data/s103/pb05.s103.r02.empty+orig.BRIK --out combined_1.nii --srcreg register.dat --hemi lh

% Import the vertex activation data
surface_activation = MRIread('combined.nii');

% Convert this to a vertex x time points matrix
surface_activation = squeeze(surface_activation.vol(1,:,:));

% Determine the number of vertices
number_of_vertices = size(surface_activation, 1);

% Write the total number of vertices to a file to aid the next script
% fileID = fopen('number_of_vertices.txt','w');
% fprintf(fileID,'%d', number_of_vertices);
% fclose(fileID);

% We are going to need the RAS coordiantes from all of the vertices, we can
% do this by converting the orig surface file into ascii format then
% reading all of the vertex coordinates in with dlmread, making sure to
% remove all of the faces information after doing so

% ! mris_convert surf/lh.orig surf/lh.orig.asc
vertex_ras_coords = dlmread('surf/lh.orig.asc', ' ', 2, 0);
vertex_ras_coords = [vertex_ras_coords(:,1) vertex_ras_coords(:,3) ...
                                                 vertex_ras_coords(:,5) ];
vertex_ras_coords = vertex_ras_coords(1:number_of_vertices, :);

% Import the Registration and Tmov matrix, used to transform a vertex RAS
% to voxel CRS
Reg = load('vertex_to_voxel/Reg.dat');
Tmov = load('vertex_to_voxel/Tmov.dat');

% Initialize a subject structure for the voxel functional data
subj = init_subj('test_experiment', 'test_subject');

% Create a whole brain mask to allow all data to be imported
wholevol = ones(64, 74, 60);
subj = initset_object(subj,'mask','wholevol',wholevol);

% Import the voxel functional data
subj = load_afni_pattern(subj,'epi','wholevol', '../../Functional_Data/s103/pb05.s103.r02.empty+orig.BRIK');

% Initialize a counter to keep track of the amount of incorrect mappings
incorrect_mappings = 0;

% Access all 3d voxel x timepoints data
data = get_mat(subj,'pattern','epi'); 
full_data = zeros([size(data,2) size(wholevol)]);

for i = 1: size(data,2) %number of time points

    % access all functional value at timepoint i
    full_data(i, find(wholevol)) = data(:,i);      

end

for i = 1:number_of_vertices
    
    % caclualte the vertex to voxel transformation
    movCRS = inv(Tmov)*Reg*[vertex_ras_coords(i, 1) vertex_ras_coords(i, 2) vertex_ras_coords(i, 3) 1]' ;
    crs = round(movCRS);

    % To access functional data from a vertex use vertex number seen in 
    % tksurfer+1 as matlab is one indexed
    
    vertex_timecourse = surface_activation(i,:);

    %now to check if the vertex to voxel mapping shows the same functional 
    %value at the %vertex and the voxel

    %It turns out that this does work, note that the index is one offset due 
    %to matlab being 1 indexed and the functional volume being 0 indexed

    voxel_timecourse = full_data(:, crs(1)+1, crs(2)+1, crs(3)+1);
    
    % Check if the vertex timecourse data and voxel time course data are
    % the same
    
    testing_length = 3;
    
    if length(find(round(voxel_timecourse(1:testing_length), 3) == round(vertex_timecourse(1:testing_length), 3))) ~= testing_length
        
        incorrect_mappings = incorrect_mappings+1;
        
    end
    
end
    
incorrect_mappings / number_of_vertices


% Code graveyard


% ! tksurfer s103 lh sphere.reg -tcl retrieve_ras.tcl | grep "orig " > vertex_ras_coords.txt
% ! python remove_lettering_from_lines.py vertex_ras_coords.txt
    