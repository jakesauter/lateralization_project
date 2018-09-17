![CNBC Poster](https://github.com/jakesauter/lateralization_project/blob/master/CNBC_Poster.jpg)

# Background

This project was done at the Center for the Neural Basis of Cognition (CNBC), a joint lab between Carnegie Mellon University and the University of Pittsburgh. This work was done during an undergraduate summer research internship offered through the previously mentioned universities, supported from a grant from NIH.

# Purpose

The purpose of this project is to locate functionally correlating regions of interest (ROIs) (e.g. correlating a brain region in the left hemisphere that responds to faces to a similar region in the right hemisphere that responds similarly). Once these regions are located, respresentation analysis can be performed through Multi-Voxel Pattern Analysis to test for the similarity of representations.

Mult-Voxel representations (fMRI) of ROIs are used as features describing the stimuli that subjects are viewing. These features are used to train a machine learning classifier on the reserved test set of fMRI voxel recodings, generating a testing accuracy score. If the correlating ROI in either hemisphere shows higher classification results, this would show that the particular hemisphere is more active in the task, but this is not what we are mainly interested in. We are interested in if when we combine the corresponding ROI data, we see higher classification results than for either single hemispheric ROI. This would indicate that the representations are both *different* and *informative*.

# The Pipeline

Put **register_and_map_all_data.bash** OR **register_and_map_all_data.bash** (depending on the current shell) in subject directory.

We also need to make sure that the subject directory is properly set, which can be done by first changing directories to be in the Freesurfer directory (if you use ls, which is the "list files" command you should see s103, s105, … ). Now to set the freesurfer subject directory to the current directory the following command can be executed

bash shell: 

    SUBJECTS_DIR=`pwd`

tiny shell (tcsh): 

    setenv SUBJECTS_DIR `pwd`

please make sure to note you are using the ` character and not the ' character, these are VERY different in shell commands.

The first thing that needs to be done is to register the functional file to the anatomical surface, then to actually go about mapping the functional data to the surface so that we have a file, named similarly to 'combined.nii' that can be read into matlab as a vertex by functional time course matrix. 

This is all done in the bash script register_and_map_all_data.sh. This script needs to be under the subject's directory, for example Freesurfer/s103. This script also uses relative file paths so the file structure currently used on the server needs to be maintained. This script will also convert the surfaces that the matlab scripts need into a matlab readable form (ascii).

To make a script executable, the command

    chmod +x register_and_map_all_data.sh

needs to be run, and then the following command will run the script

    ./register_and_map_all_data.sh
2a. If running multiple subjects, after using register_and_map_all_data, open a new terminal for the next subject. Otherwise you will get an error and no register.dat will be created. 
And typically runs 2nd time in new terminal after encountering segmentation error the 1st time.

At this point, everything is set for the searchlight analysis to be run. The one thing that can be modified for potentially better surface mapping is the  coordinates_to_use list at the top of register_hemispheres.m. This will change the regions that are used to correspond the surfaces. Each of these coordinates corresponds to the distance to the center vertex of a region. The region code of each coordinate is in ascending order so the coordinates are corresponded to the region_codes matrix.

To run the searchlight analysis, all that needs to be done is in the Matlab terminal

    searchlight_analysis

Most of the programs I have written are scripts and not functions so if anything goes wrong, the variables are available to look at in the workspace.

The main result of this script is the searchlight_results variable, which is a matrix of the form

lh_vertex_number   rh_vertex_number  lh_roi_acc  rh_roi_acc  combined_roi_acc

After the searchlight is complete we have the results but they are difficult to understand, so heatmaps are a good way to visualize. To produce accuracy heatmaps, in the Matlab terminal

    generate_accuracy_heatmaps

and to produce the boost (non-redundancy) heat maps

    generate_boost_heat_map

Now that the searchlight analysis is done and the visualizations are generated, to view the visualizations open tksurfer the subject, hemisphere and surface of interest. This can be done in any directory as tksurfer uses the SUBJECTS_DIR environmental variable to find subjects.

    tksurfer s103 lh inflated

once tksurfer opens, load the annotation file 

    file --> label --> import annotation --> (in the new window) browse 

to load the accuracy heatmaps select lh/rh.acc_heat_map.annot, to load the boost heatmaps, which is visualized on the left hemisphere select lh.boost_heat_map.annot

    --> ok --> ok 

now the results heat map should be visualized on the surface!


# API 

**binarize_regressor.m** -- function that takes a non_binary, single row conditional regression as an argument, and returns a new binarized regressor, of the size number of conditions by number of time points. A conditional regressor of this form is needed to do feature selection and possibly other operations in the princeton mvpa toolbox.

**calculate_off_ras_to_crs_transformations.m** -- script that calculate the percentage of transformations from vertices to voxels that are correct / incorrect. The correctness of
the mapping is determined by the vertex and the voxel having the same functional time course data. This script was only used in the developing period though can be a resource if similar functionality is needed in the.

**evaluate_results.m** -- a script to quickly read in the results of the searchlight analysis script so that they can be manipulated in Matlab. This is another script from the developmental period though might be a useful reference.

**find_blocks.m** -- a highly useful script to the analysis process. This script find all blocks given the conditional regressor as an argument, and returns a number of blocks by 2 matrix, with the first column being the condition id that the block contains (1-4 in current study) and column 2 containing the start index of the block.

**form_new_coordinates_from_reference_points.m** -- script used in conjunction and called at the bottom of register_hemispheres.m. register_hemispheres.m calculates the center of every anatomical labeled region on both the left and right hemisphere, then stores the vertex number and a parallel array of the coordinates for each reference vertex. form_new_coordinates_from_reference_points.m then creates the new coordinates for every vertex, with each dimension being the distance to one reference point. 

**generate_accuracy_graphs.m** -- script run after searchlight_analysis.m to generate the graphs that I needed for my poster. Talairach coordinates for the FFA and somatosensory cortex need to be gotten from tksurfer, with the assistance of the select_talairach_point function in tksurfer command line. The left FFA talairach coordinates were chosen to be within the given bounds from the paper closest to the region seen to be the FFA on the accuracy heat maps. In the future these regions should be functionally localized using different runs before the searchlight analysis. The right ffa vertex is then determined by get_vertex_number_from_coord of the coordinate of the vertex of the left ffa.

**generate_accuracy_heatmaps.m** -- script run after searchlight_analysis.m that generates the ?h.acc_heat_map.annot files to be loaded into tksurfer to visualize the accuracy of each ROI in the searchlight analysis. Due to the fact that the same vertex is used in many ROIs in the searchlight analysis, the accuracy of each vertex is the average of the accuracy of each ROI that the vertex was contained in. 

**generate_boost_heat_map.m** -- script run after searchlight_analysis.m to generate the non-redundancy heat maps. This script functions similarly to genererate_accuracy_heatmaps.m and writes to the annotation file lh.boost_heat_map.annot. This heat map only needs to be projected onto one surface because its results are from the combination of ROIs from both hemispheres.

**generate_roi_figure.m** -- script that given a center vertex and a distance threshold, will draw an ROI on the surface in red with also the surrounding labelled regions shown.

**generate_top_non_redundant_region_bar_graph.m** -- very simple script used to generate a bar graph for top non redundant regions found from identify_top_non_redundant_regions.m

**get_run_configurations.m** --  script used to randomly generate different balanced block configurations for each run. Parameters included the conditions regressor, the blocks matrix, being the result from find_blocks.m

**get_vertex_number_from_coord.m** -- function used to get a vertex number from a coordinate. This function takes a coordinate system ( a list of coordinates for each vertex ) and the desired coordinate. This function then finds the coordinate closest to the one desired and returns the index of that coordinate in the coordinate system. This function can be used to find the vertex matching a coordinate on the same surface, e.g. 

    get_vertex_number_from_coord(lh_distance_based_coords, some_coords_on_lh)

or this function can be used to find corresponding anatomical regions between hemispheres, in example, find the corresponding vertex on the right hemisphere from a vertex number on the left hemisphere

    get_vertex_number-from_coord(rh_distance_based_coords, lh_distance_based_coords(lh_vertex_number, :))

**identify_top_non_redundant_regions.m** -- script used to generate a matrix (called copy) of the top non-redundant regions. The first column of this matrix contains the region code and the second column of this matrix contains the maximum non-redundancy score found in the region.

**make_contiguous_regressor.m** -- function used to make all blocks in the conditional regressor contiguous. e.g (1 0 1 0 1 0 → 1 1 1 1 1 1). This function has arguments of the conditional regressor and the blocks matrix.

**make_fake_mask.m** -- function used to make a fake mask to allow feature selection to be used from the princeton mvpa toolbox. This function takes arguments of size of dim. 1, 2 and 3, along with the number of true binary values that the mask should contain.

**make_label_an_color_lookup_table.m** -- script used to test the formation of a new color lookup table from a .annot file. This script might be useful for reference.

**mvpa_analysis.m** -- script that performs mvpa analysis using ROIs centered at the vertex_number(1) and vertex_number(2) vertices for the left and right hemisphere ROIs respectively. Script options are well documented in code. For more robust results different block configurations are keps and the accuracy between these runs is averaged for the final accuracy for the analysis. 

**plot_vertex_and_voxel_activation.m** -- script that uses the associated matrices to map a vertex to a voxel and plots the vertex and voxel functional data for comparison.

**proportional_volume_location.m** -- function used to check if data is properly being mapped, arguments are the CRS (column, row, slice) coordinates of voxel, the function then prints where that voxel is relative to all active voxels, essentially using an activity mask.

**register_and_map_all_data.bash** or **register_and_map_all_data.tcsh** <subject> -- script used to register the functional and anatomical data. Once this registration matrix is made, all of the functional data is then mapped to the surface. Each run in each hemisphere is mapped to its own 'combined.nii' file. These files are matrices in the form vertex by functional time course data. As an added bonus this script also converts the needed surfaces (?h.sphere.reg) to Matlab readable format (?h.sphere.reg.asc)

**register_hemispheres.m** -- When in the subjects directory, (e.g. Freesurfer/s103) this script will use the sphere.reg files along with ascii formatted annotation files in the SUMA to define a new coordinate system for the surface of each hemisphere, in which the coordinates of the same anatomical location on each hemisphere have the same coordinates.

**remove_lettering_from_lines.py** -- python script used to remove any unwanted characters from each line in a file that will then be read into Matlab. This is used after extracting data from tksurfer (presumably talairach coordinates). The output file to this script is a file with the same name as the output file (presumed to be a .txt), except now with a .m extension so that the load(filename) function can be used in matlab to load this coordinate data. 

**retrieve_ras.tcl** -- a tcl script that is sent as an argument to tksurfer that selects every vertex, meaning that the ras coordinates are printed to the terminal. The terminal output then can be piped to grep in which only the lines with "orig" in them can be saved to a file. Then the remove_lettering_from_lines.py script can be run, with the file containing the saved coordinates as an argument. Later it was found that these RAS coordinates are in the orig surface file, though this process is used to retrieve the Talairach coordinates from vertices which are not  

**retrieve_talairach.tcl** -- a tcl script that is sent as an argument to tksurfer that selects every vertex then also prints the orig vertex coordinates. This line makes tksurfer print a line of the form TALAIRACH X Y X. Once every vertex is selected and the Talairach coordinates are printed to the terminal, the terminal output can be piped to grep then output redirected ( > ) to a file to save only the lines that start with TALAIRACH. Then remove_lettering_from_lines.py can be used to remove TALAIRACH from each line so that this file can be read into Matlab.

**searchlight_analysis.m** -- script to run a searchlight analysis on the subject in the current directory. This script needs to be run after register_and_map_all_data.bash/tcsh is executed. This script has many well commented options such as remove_not_from_region, contiguous_regressor, persistence and more.

**select_roi.m** -- a function to select an ROI (a list of vertices) given a center vertex and a distance threshold. this function also returns a parallel list of distance from the center for each vertex returned.

# Future Steps

To be ABSOLUTELY sure that the functional data at each vertex is mapped correctly, search the loaded functional volume for the time course data of the vertex, and manually check that this voxel is in the region or same anatomical location that the vertex is in.

Vertices can be correlated with their Talairach or RAS coordinates to get voxels under the surface

# Notes

The coordinates shown in Freesurfer are the coordinates of the orig surface (?h.orig.asc)

The coordinates from the freesurfer surface files don't need to convert to spherical spherical coordinates as we take cartesian distance, which cannot be done in spherical coordinates
