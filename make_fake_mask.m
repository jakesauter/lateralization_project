function [fake_mask] = make_fake_mask(size1, size2, size3, num_elements)

    fake_mask = zeros(size1, size2, size3);
    
    total_length = size1 * size2 * size3;
    
    index_to_set = 0;
    
    for i = 1:num_elements
        
        while true
           
            index_to_set = ceil(abs(rand)*total_length);
            
            if fake_mask(index_to_set) == 0
               break
            end
        end
        
        fake_mask(index_to_set) = 1;
    end
end
