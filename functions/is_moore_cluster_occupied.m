function [ success, baseVal ] = is_moore_cluster_occupied(data, x, y, disc)
    baseVal = s_of(filter_cell(data,x,y));
    if baseVal > 0
        success = true;
        for local_x = (x-1):(x+1)
            for local_y = (y-1):(y+1)
                cellVal = s_of(filter_cell(data, local_x,local_y));
                if (((cellVal < ((1 - disc) * baseVal)) || ...
                   (cellVal > ((1 + disc) * baseVal))) && ...
                   id_of(filter_cell(data, local_x, local_y)) > 0)
                    success = false;
                    break
                end
            end
        end
    else 
        success = false;
    end
end