function [ conditions_regressor ] = make_contiguous_regressor ( conditions_regressor , blocks ) 

    for i = 1:size(blocks, 1)
       
        conditions_regressor(blocks(i,2):blocks(i,2)+5) = blocks(i,1);
        
    end

end