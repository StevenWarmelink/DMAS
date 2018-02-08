function [ data ] = filter_epoch( data, range )
%FILTER_EPOCH Returns a sub-set of the data based on the epoch
    data = data(ismember(epoch_of(data), range),:);
end

