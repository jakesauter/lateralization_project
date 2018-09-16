function [ run_configurations] = get_run_configurations(num_configurations, blocks, runs_selector, conditions_regressor)

    % Calculate how many blocks of each class are in the data set

    conditions = unique(blocks(:,1))';
    non_face_conditions = conditions(conditions ~= 2);
 
    % Randomly select run configurations until we have the requested amount
    
    run_configurations = [];
    
    while size(run_configurations,1) < num_configurations
        
        run_configurations(end+1,:) = ones(1, length(runs_selector));
        
        % Remove rest data and possibly conditions we are not interested in 
    
        run_configurations(end,conditions_regressor == 0) = 0;

        for run = 1:4 % for each run 

            for cond = conditions % for each condition number

                num_blocks(cond) = size(find(blocks(:,1) == cond & (runs_selector(blocks(:,2)) == run)'), 1);

            end

            % Calculate how many blocks from each non face categroy that should
            % be excluded

            num_blocks_to_erase =  num_blocks(2) - round(num_blocks(2) / (length(num_blocks)-1));

            % Randomly choose which blocks to erase for each category

            for class = non_face_conditions % for each non face class

                % Get the index of all of the blocks in the blocks matrix that
                % are from the nonface class of interest and are in the data
                % set of interest (training / testing)

                block_indices = find(blocks(:,1) == class & (runs_selector(blocks(:,2)) == run)');

                for j = 1:num_blocks_to_erase

                    % Ensure that we pick a new and random index at every
                    % iteration of removal

                    while true

                        block_indices_index = ceil(abs(rand)*length(block_indices));

                        if block_indices(block_indices_index) ~= 0
                            break
                        end
                    end

                    block_index_to_erase = block_indices(block_indices_index);

                    block_indices(block_indices_index) = 0;

                    run_configurations(end, blocks(block_index_to_erase,2):(blocks(block_index_to_erase,2)+5)) = 0;

                end 
            end
        end
        
        run_configurations = unique(run_configurations, 'rows');
    end
end