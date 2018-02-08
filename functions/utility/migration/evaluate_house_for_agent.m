function [ p_move_to_house ] = evaluate_house_for_agent( is_potential_house, s, state, opts )
%EVALUATE_HOUSE_FOR_AGENT Evaluate potential houses

if nargin ~= 4
   error('Not enough input arguments') 
end

% Initialize to 0
values = zeros(size(is_potential_house));

% Compute the nb tensions as if the agent already lived in the potential
% house. Then compute the probability based on the tension
values(is_potential_house) = ...
    opts.w_move_in(1) +...
    opts.w_move_in(2) *...
    exp(...
        opts.w_move_in(3) *...
        abs(s - state.nb_v(is_potential_house))...
       );
   
s0 = prod(1 - values(is_potential_house));
sh = (values * s0) ./ (1 - values);

p_move_to_house = sh / sum(sum(sh));

end

