function [ success, baseVal ] = is_neumann_cluster_occupied(data, x, y, disc)
    baseVal = s_of(filter_cell(data,x,y));
    success = true;
    if baseVal > 0
        if    (((s_of(filter_cell(data,x,y+1)) < ((1-disc) * baseVal)) || ...
                (s_of(filter_cell(data,x,y+1)) > ((1+disc) * baseVal))) && ...
              (id_of(filter_cell(data,x,y+1)) > 0 ))                ...
           || (((s_of(filter_cell(data,x,y-1)) < ((1 - disc) * baseVal)) || ...
              (s_of(filter_cell(data,x,y-1)) > ((1 + disc) * baseVal))) && ...
              (id_of(filter_cell(data,x,y-1)) > 0 ))                ...
           || (((s_of(filter_cell(data,x+1,y)) < ((1 - disc) * baseVal)) || ...
              (s_of(filter_cell(data,x+1,y)) > ((1 + disc) * baseVal))) && ...
              (id_of(filter_cell(data,x+1,y)) > 0 ))                ...
           || (((s_of(filter_cell(data,x-1,y)) < ((1 - disc) * baseVal)) || ...
              (s_of(filter_cell(data,x-1,y)) > ((1 + disc) * baseVal))) && ...
              (id_of(filter_cell(data,x-1,y)) > 0 ))
            success = false;
        end
    else
        success = false;
    end
end