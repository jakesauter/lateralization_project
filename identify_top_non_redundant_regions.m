% associate vertex numbers with boost

for i = 1:size(average_boost,1);
   
    average_boost(i,2) = i-1;
    
end

% sort the vertices by boost

average_boost = sortrows(average_boost, 1, 'descend');

% Now iterate through average boost and aquire region codes of most boosted
% regions

boosted_region_codes = [];

current_index = [];

for i = 1:size(average_boost,1)
    
    i
   
    region_code = lh_vertex_to_roi(lh_vertex_to_roi(:,1) == average_boost(i,2), 2);
    
    if ~ismember(region_code, boosted_region_codes)
    
        boosted_region_codes(end+1, 1:2) = [region_code average_boost(i,1)];
        
        current_index(end+1, :) = [region_code 3];
            
    else
        
        boosted_region_codes(boosted_region_codes(:,1) == region_code, current_index(current_index(:,1) == region_code, 2)) ...
                               = average_boost(i,1);
                           
        current_index(current_index(:,1) == region_code, 2) = current_index(current_index(:,1) == region_code, 2) + 1;
    end   
end

% for i = 1:size(boosted_region_codes)
%    
%     boosted_region_codes(i,2) = max(boosted_region_codes(i,2:max(find(boosted_region_codes(i,:) ~= 0))));
%     
% end
% 
% boosted_region_codes = boosted_region_codes(:,1:2);
% 
% sortrows(boosted_region_codes, 2, 'descend');

copy = boosted_region_codes;

for i = 1:size(copy, 1)
   
    copy(i,2) = max(copy(i,2:end));
    
end

% for i = 1:size(copy, 1)
%    
%     copy(i,2) = mean(copy(i,2:max(find(copy(i,:) ~= 0))));
%     
% end

copy = copy(:,1:2);

copy = sortrows(copy,2,'descend');