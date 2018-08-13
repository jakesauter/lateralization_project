% Use a sliding box to determine where blocks are, output will be in the
% form of [condition number, block starting index ;  . . .]

function [ blocks ] = find_blocks(conditions_regressor)

    blocks = [1,1];

    current_block = 1;

    for i = 1:length(conditions_regressor)-4

        if(conditions_regressor(i) == conditions_regressor(i+2) & ...
           conditions_regressor(i+2) == conditions_regressor(i+4) & ...
           conditions_regressor(i+4) ~= 0)

            blocks(current_block,:) = [conditions_regressor(i), i];

            current_block = current_block + 1;

        end
    end
end