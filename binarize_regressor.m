function [ one_of_n_form_regressor] = binarize_regressor(conditions_regressor)

    unique_conditions = unique(conditions_regressor(conditions_regressor ~= 0));

    one_of_n_form_regressor = zeros(length(unique_conditions), ...
                                       length(conditions_regressor));
    
    
    for i = 1:size(one_of_n_form_regressor,1) % for each row
        
        for j = 1:size(one_of_n_form_regressor,2) % for each col
       
            one_of_n_form_regressor(i,j) = double(unique_conditions(i) == ...
                                          conditions_regressor(j));
            
        end
    end
end