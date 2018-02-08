function [ state ] = convert_to_state( data )
%CONVERT_TO_STATE Convert csv format to a state struct

% Can only convert one time step
assert(length(unique(epoch_of(data))) == 1);

% Extract dims from data
opts = struct();
opts.g_dims = [max(x_of(data)) max(y_of(data))];

% Make empty state
state = make_empty_state(opts);

% Fill the state
for idx = 1:length(data)
    dat = data(idx,:);
    state.id(x_of(dat), y_of(dat)) = id_of(dat);
    state.v(x_of(dat), y_of(dat)) = v_of(dat);
    state.s(x_of(dat), y_of(dat)) = s_of(dat);    
    state.g(x_of(dat), y_of(dat)) = g_of(dat);
    state.nb_v(x_of(dat), y_of(dat)) = nb_v_of(dat);
    state.nb_t(x_of(dat), y_of(dat)) = nb_t_of(dat);
    state.nb_s(x_of(dat), y_of(dat)) = nb_s_of(dat);
    state.p_move_out(x_of(dat), y_of(dat)) = p_move_out_of(dat);
end

end

