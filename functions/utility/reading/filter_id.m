function [ data ] = filter_id( data, range )
%FILTER_EPOCH Returns a sub-set of the data based on the agent id
    data = data(ismember(id_of(data), range),:);
end

