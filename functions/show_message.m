function show_message( e, state, opts )
%SHOW_MESSAGE Prints a status message

is_occupied = g_occupants(state);
n_occupants = sum(sum(is_occupied));
n_total =  prod(opts.g_dims);

disp(['Epoch ', num2str(e), ' of ', num2str(opts.n_epochs), '. ',...
      'Occupied: ' num2str(n_occupants), ', Total: ', num2str(n_total)]);

end

