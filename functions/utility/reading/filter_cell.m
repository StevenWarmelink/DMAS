function [ data ] = filter_cell( data, x, y )
%FILTER_EPOCH Returns a sub-set of the data based on the cell
    data = data(ismember(x_of(data), x) & ismember(y_of(data), y),:);
end

