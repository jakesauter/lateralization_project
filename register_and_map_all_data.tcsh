#!/bin/tcsh

# This script will register each of the 4 functional
# runs with the left and right hemispheres and map
# the functional data to them.

# Access the command line arguments, the first
# command line argument will be the subject name
setenv subject $1

# A file counter to allow for the loading of all
# functional files in a programmatic way

setenv file_counter 1
setenv run_counter 2

# All of the surfaces use the same registration file
tkregister2 --s ${subject} --targ mri/orig.mgz --mov ../../Functional_Data/$subject/pb05.${subject}.r02.empty+orig.BRIK --regheader --reg register.dat | grep "subject" 

while ( $file_counter <= 4 )

  # left hemisphere
  mri_vol2surf --src ../../Functional_Data/${subject}/pb05.${subject}.r0${run_counter}.empty+orig.BRIK --out combined_${file_counter}_lh.nii --srcreg register.dat --hemi lh | grep "Writing"

  #right hemisphere
  mri_vol2surf --src ../../Functional_Data/${subject}/pb05.${subject}.r0${run_counter}.empty+orig.BRIK --out combined_${file_counter}_rh.nii --srcreg register.dat --hemi rh | grep "Writing"

  setenv file_counter `expr "$file_counter" + "1"`
  setenv run_counter `expr "$run_counter" + "2"`
 
end

# Convert the surfaces that Matlab needs into Matlab readable format (ascii)

mris_convert surf/lh.sphere.reg surf/lh.sphere.reg.asc

mris_convert surf/rh.sphere.reg surf/rh.sphere.reg.asc
