function write_state( state, opts, epoch)
%WRITESTATE Summary of this function goes here
%   Detailed explanation goes here

if nargin ~= 3
    error('State, options and epoch input is required');
end

% convert to csv format
% each row is a cell
len = prod(opts.g_dims);
data = zeros(len, 11);

% convert coordinates
centers = g_indices(opts);
% reshape is row-based so y and x are swapped here!!!
data(:,1) = centers(:,2);
data(:,2) = centers(:,1);

% convert state
data(:,3)  = reshape(state.v, len, 1);
data(:,4)  = reshape(state.id, len, 1);
data(:,5)  = reshape(state.s, len, 1);
data(:,6)  = reshape(state.g, len, 1);
data(:,7)  = reshape(state.nb_v, len, 1);
data(:,8)  = reshape(state.nb_t, len, 1);
data(:,9)  = reshape(state.nb_s, len ,1);
data(:,10) = reshape(state.p_move_out, len ,1);
data(:,11) = epoch;

% Write the data to file, appending what is already there
dlmwrite(opts.file_name, data, 'delimiter', ',','-append');
end
