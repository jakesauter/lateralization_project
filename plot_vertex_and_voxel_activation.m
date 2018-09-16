vertex_index = input('Vertex index: ');

vertex_ras = input('[R A S]: ');

surface_activation = MRIread('combined.nii');

Reg = load('vertex_to_voxel/Reg.dat');

Tmov = load('vertex_to_voxel/Tmov.dat');

%noting to make sure that these are the same used 
%to produce the activation with mri_vol2surf

subj = init_subj('test_experiment', 'test_subject');

wholevol = ones(64, 74, 60);

subj = initset_object(subj,'mask','wholevol',wholevol);

subj = load_afni_pattern(subj,'epi','wholevol', '../../Functional_Data/s103/pb05.s103.r02.empty+orig.BRIK');

%to access functional data from a vertex, with the 2nd parameter 
%being vertex number seen in tksurfer+1 as matlab is one indexed

figure('name','Vertex Activation Patten','NumberTitle','off')
hold on
plot(squeeze(surface_activation.vol(1,vertex_index + 1,:)))
refline(0,0)

%now to compare with the voxel fucntional value

movCRS = inv(Tmov)*Reg*[vertex_ras(1) vertex_ras(2) vertex_ras(3) 1]';

crs = round(movCRS);

data = get_mat(subj,'pattern','epi'); 

full_data = zeros(size(wholevol));

%now to check if the vertex to voxel mapping shows the same functional 
%value at the %vertex and the voxel

%It turns out that this does work, note that the index is one offset due 
%to matlab being 1 indexed and the functional volume being 0 indexed

timepoints = [1:80];

for i = 1: size(data,2) %number of time points
    
    % access all functional value at timepoint i
    
    full_data(find(wholevol)) = data(:,i); 
   
    %now store the functional value of the voxel we 
    %are interested in
    
    timepoints(i) = full_data(crs(1)+1, crs(2)+1, crs(3)+1);
end

figure('name','Voxel Activation Patten','NumberTitle','off')
hold on
plot(timepoints)
refline(0,0)
